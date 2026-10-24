import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Chosen pages of the Apache Pekko manual (Paradox markdown, Apache License 2.0) written as a book the frame pipeline
 * reads: one numbered chapter per page in reading order, its "##" headings numbered as sections and its "###" headings as
 * subsections. Of Paradox's own markup, a language switch keeps its Java side, an API name or a link keeps its label,
 * and dependency blocks, snippet includes and the markers of note blocks are dropped.
 *
 * <pre>java PekkoManual.java &lt;paradox-dir&gt; &lt;out-dir&gt; &lt;page&gt;...</pre>
 */
public class PekkoManual {

    public static void main(String[] a) throws Exception {
        Path src = Path.of(a[0]), out = Path.of(a[1]);
        List<String> pages = List.of(a).subList(2, a.length);
        int chapter = 0;
        for (String page : pages) {
            chapter++;
            String text = convert(Files.readString(src.resolve(page)));
            StringBuilder sb = new StringBuilder();
            int section = 0, sub = 0;
            boolean code = false, titled = false;
            for (String line : text.split("\n", -1)) {
                if (line.startsWith("```")) code = !code;
                if (!code && line.startsWith("# ") && !titled) {
                    sb.append("# ").append(chapter).append(' ').append(line.substring(2).strip()).append('\n');
                    titled = true;
                } else if (!code && line.startsWith("## ")) {
                    section++;
                    sub = 0;
                    sb.append("## ").append(chapter).append('.').append(section).append(' ').append(line.substring(3).strip()).append('\n');
                } else if (!code && line.startsWith("### ") && section > 0) {
                    sb.append("### ").append(chapter).append('.').append(section).append('.').append(++sub).append(' ').append(line.substring(4).strip()).append('\n');
                } else if (!code && line.matches("^#{3,6} .*")) {
                    sb.append("**").append(line.replaceFirst("^#+ ", "").strip()).append("**\n");
                } else {
                    sb.append(line).append('\n');
                }
            }
            Path dir = out.resolve(String.format("Chap%02d_%s", chapter, page.replaceAll("[/.]", "_").replace("_md", "")));
            Files.createDirectories(dir);
            Files.writeString(dir.resolve(String.format("p%02d.md", chapter)), sb.toString().replaceAll("\n{3,}", "\n\n"));
            System.out.println(chapter + " " + page + " " + section + " section(s)");
        }
    }

    static String convert(String s) {
        // a language switch keeps its Java side: @scala[...]@java[...] and either alone
        s = replaceBracketed(s, "@scala[", t -> "");
        s = replaceBracketed(s, "@java[", t -> t);
        // an API name or a link keeps its label
        // a link target may hold one level of parentheses: (pekko.actor.typed.ActorRef#tell(T))
        s = s.replaceAll("@(?:javadoc|scaladoc|apidoc|github|extref)(?::[^\\[]*)?\\[([^\\]]*)]\\((?:[^()]|\\([^()]*\\))*\\)", "`$1`");
        // an API name with no target: its last name
        s = s.replaceAll("@apidoc\\[(?:[\\w.*]+\\.)?([^\\].]+)]", "`$1`");
        s = s.replaceAll("@ref:?\\[([^\\]]*)]\\([^)]*\\)", "$1");
        s = s.replaceAll("@ref:\\[([^\\]]*)]", "$1");
        // blocks Paradox fills in from elsewhere: dependencies, code snippets, the markers of note and div blocks
        s = s.replaceAll("(?s)@@dependency\\[[^\\]]*]\\s*\\{.*?\\n}", "");
        s = s.replaceAll("(?m)^\\s*(?:Scala|Java)?\\s*:\\s*@@snip.*$", "");
        s = s.replaceAll("(?m)^\\s*@@snip.*$", "");
        s = s.replaceAll("(?m)^@@@.*$", "");
        s = s.replaceAll("(?m)^\\s*@@\\w.*$", "");
        return s;
    }

    /** Replaces each "marker[...]" (brackets may nest) by what {@code f} makes of its inside. */
    static String replaceBracketed(String s, String marker, java.util.function.UnaryOperator<String> f) {
        StringBuilder out = new StringBuilder();
        int i = 0;
        while (true) {
            int at = s.indexOf(marker, i);
            if (at < 0) break;
            out.append(s, i, at);
            int depth = 1, j = at + marker.length();
            while (j < s.length() && depth > 0) {
                char c = s.charAt(j);
                if (c == '[') depth++;
                if (c == ']') depth--;
                j++;
            }
            out.append(f.apply(s.substring(at + marker.length(), Math.max(at + marker.length(), j - 1))));
            i = j;
        }
        out.append(s.substring(i));
        return out.toString();
    }
}
