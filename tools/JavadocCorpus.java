import com.sun.source.doctree.BlockTagTree;
import com.sun.source.doctree.DocCommentTree;
import com.sun.source.doctree.DocTree;
import com.sun.source.tree.ClassTree;
import com.sun.source.tree.CompilationUnitTree;
import com.sun.source.tree.MethodTree;
import com.sun.source.tree.Tree;
import com.sun.source.tree.VariableTree;
import com.sun.source.util.DocTrees;
import com.sun.source.util.JavacTask;
import com.sun.source.util.TreePath;

import javax.lang.model.element.Modifier;
import javax.tools.JavaFileObject;
import javax.tools.SimpleJavaFileObject;
import javax.tools.ToolProvider;
import java.io.IOException;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/**
 * The javadoc comments of chosen JDK packages, read from the JDK's src.zip with the javac tree API, written as a book the
 * frame pipeline reads (a package is a numbered chapter, a public class a section, a public member of it a subsection,
 * each heading followed by the comment turned into markdown), and counted: for each kind of declaration, how many
 * comments carry each block tag, and how long their first sentence is.
 *
 * <pre>java JavadocCorpus.java &lt;src.zip&gt; &lt;out-dir&gt; &lt;package&gt;...</pre>
 */
public class JavadocCorpus {

    record Comment(String pkg, String cls, String kind, String name, String text, List<String> tags, int firstSentence) {}

    public static void main(String[] a) throws Exception {
        Path out = Path.of(a[1]);
        List<String> packages = List.of(a).subList(2, a.length);
        Map<String, List<Comment>> byPackage = new TreeMap<>();
        try (ZipFile zip = new ZipFile(a[0])) {
            for (String pkg : packages) {
                List<JavaFileObject> sources = new ArrayList<>();
                String dir = "java.base/" + pkg.replace('.', '/') + "/";
                String other = null;
                for (ZipEntry e : zip.stream().toList()) {
                    String n = e.getName();
                    // a package outside java.base (java.net.http) lives in its own module
                    if (n.endsWith("/" + pkg.replace('.', '/') + "/package-info.java")) other = n.substring(0, n.length() - "package-info.java".length());
                }
                String prefix = other != null ? other : dir;
                for (ZipEntry e : zip.stream().toList()) {
                    String n = e.getName();
                    if (!n.startsWith(prefix) || !n.endsWith(".java") || n.substring(prefix.length()).contains("/")) continue;
                    String text = new String(zip.getInputStream(e).readAllBytes(), StandardCharsets.UTF_8);
                    sources.add(new SimpleJavaFileObject(URI.create("string:///" + n), JavaFileObject.Kind.SOURCE) {
                        @Override
                        public CharSequence getCharContent(boolean ignore) {
                            return text;
                        }
                    });
                }
                byPackage.put(pkg, read(pkg, sources));
            }
        }
        write(out, packages, byPackage);
        count(out, byPackage);
    }

    static List<Comment> read(String pkg, List<JavaFileObject> sources) throws IOException {
        var javac = ToolProvider.getSystemJavaCompiler();
        JavacTask task = (JavacTask) javac.getTask(null, null, d -> { }, List.of("-proc:none", "--enable-preview", "--release", "25"), null, sources);
        DocTrees docs = DocTrees.instance(task);
        List<Comment> out = new ArrayList<>();
        for (CompilationUnitTree unit : task.parse()) {
            for (Tree t : unit.getTypeDecls()) {
                if (t instanceof ClassTree c && c.getModifiers().getFlags().contains(Modifier.PUBLIC)) walk(docs, unit, c, pkg, out);
            }
        }
        return out;
    }

    static void walk(DocTrees docs, CompilationUnitTree unit, ClassTree c, String pkg, List<Comment> out) {
        String cls = c.getSimpleName().toString();
        add(docs, unit, c, pkg, cls, c.getKind().toString().toLowerCase().replace("annotation_type", "annotation"), cls, out);
        for (Tree m : c.getMembers()) {
            if (m instanceof MethodTree mt && isPublic(mt.getModifiers().getFlags(), c)) {
                String name = mt.getName().contentEquals("<init>") ? cls : mt.getName().toString();
                String params = String.join(", ", mt.getParameters().stream().map(p -> p.getType().toString()).toList());
                add(docs, unit, m, pkg, cls, mt.getName().contentEquals("<init>") ? "constructor" : "method", name + "(" + params + ")", out);
            } else if (m instanceof VariableTree vt && isPublic(vt.getModifiers().getFlags(), c)) {
                add(docs, unit, m, pkg, cls, "field", vt.getName().toString(), out);
            }
        }
    }

    /** A member of an interface is public without saying so. */
    static boolean isPublic(java.util.Set<Modifier> flags, ClassTree owner) {
        return flags.contains(Modifier.PUBLIC) || owner.getKind() == Tree.Kind.INTERFACE && !flags.contains(Modifier.PRIVATE);
    }

    static void add(DocTrees docs, CompilationUnitTree unit, Tree t, String pkg, String cls, String kind, String name, List<Comment> out) {
        DocCommentTree d = docs.getDocCommentTree(TreePath.getPath(unit, t));
        if (d == null) return;
        List<String> tags = new ArrayList<>();
        for (DocTree b : d.getBlockTags()) if (b instanceof BlockTagTree bt) tags.add("@" + bt.getTagName());
        String first = join(d.getFirstSentence());
        out.add(new Comment(pkg, cls, kind, name, markdown(d), tags, first.split("\\s+").length));
    }

    /** The comment as markdown: paragraphs at <p>, code at {@code}, links by their label, block tags each on a line of its own. */
    static String markdown(DocCommentTree d) {
        StringBuilder sb = new StringBuilder();
        // the body is a list of tree nodes; printed as a list it would put ", " between them
        sb.append(html(join(d.getFullBody()))).append("\n\n");
        for (DocTree b : d.getBlockTags()) sb.append(html(b.toString())).append("\n\n");
        return sb.toString().replaceAll("\n{3,}", "\n\n").strip();
    }

    static String join(List<? extends DocTree> nodes) {
        StringBuilder sb = new StringBuilder();
        for (DocTree t : nodes) sb.append(t);
        return sb.toString();
    }

    static String html(String s) {
        return s.replaceAll("\\{@(?:code|literal) ([^}]*)}", "`$1`")
                .replaceAll("\\{@(?:link|linkplain) [^} ]+ ([^}]*)}", "$1")
                .replaceAll("\\{@(?:link|linkplain) ([^}]*)}", "`$1`")
                .replaceAll("\\{@\\w+ ?([^}]*)}", "$1")
                .replaceAll("(?i)<p>|<p [^>]*>", "\n\n")
                .replaceAll("(?i)</?(?:pre)>", "\n```\n")
                .replaceAll("(?i)<li>", "\n- ")
                .replaceAll("(?i)<code>|</code>", "`")
                .replaceAll("(?i)</?(?:ul|ol|li|em|i|b|strong|blockquote|table|tr|td|th|thead|tbody|caption|div|span|a|sup|sub|br|dl|dt|dd|h\\d|section|tt|var)(?:\\s[^>]*)?/?>", "")
                .replace("&lt;", "<").replace("&gt;", ">").replace("&amp;", "&").replace("&nbsp;", " ")
                .replaceAll("[ \\t]+\n", "\n");
    }

    /** One directory per package, one markdown file per class: "# n package", "## n.m Class", "### n.m.k member". */
    static void write(Path out, List<String> packages, Map<String, List<Comment>> byPackage) throws IOException {
        int chapter = 0;
        for (String pkg : packages) {
            chapter++;
            Path dir = out.resolve(String.format("Chap%02d_%s", chapter, pkg));
            Files.createDirectories(dir);
            Map<String, List<Comment>> byClass = new LinkedHashMap<>();
            for (Comment c : byPackage.get(pkg)) byClass.computeIfAbsent(c.cls(), k -> new ArrayList<>()).add(c);
            int section = 0;
            for (var e : byClass.entrySet()) {
                section++;
                StringBuilder sb = new StringBuilder();
                if (section == 1) sb.append("# ").append(chapter).append(" ").append(pkg).append("\n\n");
                int member = 0;
                for (Comment c : e.getValue()) {
                    if (c.name().equals(e.getKey()) && !c.kind().equals("constructor")) {
                        sb.append("## ").append(chapter).append('.').append(section).append(' ').append(c.kind()).append(' ').append(c.cls()).append("\n\n");
                    } else {
                        if (member == 0 && sb.indexOf("## ") < 0) sb.append("## ").append(chapter).append('.').append(section).append(" class ").append(e.getKey()).append("\n\n");
                        sb.append("### ").append(chapter).append('.').append(section).append('.').append(++member).append(' ').append(c.kind()).append(' ')
                          .append(c.cls()).append('.').append(c.name()).append("\n\n");
                    }
                    sb.append(c.text()).append("\n\n");
                }
                Files.writeString(dir.resolve(String.format("%03d_%s.md", section, e.getKey())), sb.toString());
            }
        }
    }

    /** For each kind of declaration: how many comments, how many carry each block tag, and the first sentence's mean length. */
    static void count(Path out, Map<String, List<Comment>> byPackage) throws IOException {
        Map<String, Map<String, Integer>> tags = new TreeMap<>();
        Map<String, int[]> n = new TreeMap<>();
        for (List<Comment> cs : byPackage.values()) {
            for (Comment c : cs) {
                n.computeIfAbsent(c.kind(), k -> new int[2]);
                n.get(c.kind())[0]++;
                n.get(c.kind())[1] += c.firstSentence();
                for (String t : new java.util.TreeSet<>(c.tags())) tags.computeIfAbsent(c.kind(), k -> new TreeMap<>()).merge(t, 1, Integer::sum);
            }
        }
        StringBuilder sb = new StringBuilder("kind\tcomments\tfirst sentence words\ttag\tcomments with it\tshare\n");
        for (var e : n.entrySet()) {
            int count = e.getValue()[0];
            sb.append(e.getKey()).append('\t').append(count).append('\t').append(String.format("%.1f", e.getValue()[1] / (double) count)).append("\t\t\t\n");
            for (var t : tags.getOrDefault(e.getKey(), Map.of()).entrySet()) {
                sb.append(e.getKey()).append("\t\t\t").append(t.getKey()).append('\t').append(t.getValue()).append('\t')
                  .append(String.format("%.0f%%", 100.0 * t.getValue() / count)).append('\n');
            }
        }
        Files.writeString(out.resolve("tag-counts.tsv"), sb.toString());
        System.out.print(sb);
    }
}
