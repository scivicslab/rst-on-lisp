# rst-on-lisp

文書を Lisp の規則ファイル（`<name>.lisp`）として書き、共有文法と照らして markdown を書き出す変換器です。

- `markdown.lisp` 変換器。ABCL 1.9.2 の上の Common Lisp で動きます。
- `bin/run.sh` 規則ファイル 1 本に式を 1 つ適用します。`run.sh doc.lisp '(rst:check)'` で検査、`'(rst:render)'` で markdown を標準出力に書きます。
- `bin/make-markdown` 与えた根の下の、古くなった `.md` だけを作り直します。html-saurus のビルドがこれを呼びます。

共有文法ファイルの場所は `RST_GRAMMAR` で変えられます。既定は doc_Base010 の
`docs/rst-on-lisp/040_design/020_GrammarNotation_261006_oo01/grammar.lisp` です。

記法と形式の説明は doc_Base010 の `docs/rst-on-lisp` にあります。
