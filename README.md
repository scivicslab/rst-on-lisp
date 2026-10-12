# rst-on-lisp

文書を Lisp の規則ファイル（`<name>.lisp`）として書き、共有文法と照らして markdown を書き出す変換器です。

- `markdown.lisp` 変換器。ABCL 1.9.2 の上の Common Lisp で動きます。
- `bin/run.sh` 規則ファイル 1 本に式を 1 つ適用します。`run.sh doc.lisp '(rst:check)'` で検査、`'(rst:render)'` で markdown を標準出力に書きます。`'(rst:verify)'` は検査と同じものを印字し、結果を終了状態で返します（0 は違反も空欄も無い、1 は違反がある、2 は違反が無く空欄がある）。
- `bin/make-markdown` 与えた根の下の、古くなった `.md` だけを作り直します。html-saurus のビルドがこれを呼びます。

規則ファイルの参考資料は `(defrelated (id 関係 "説明") (id 関係) …)` でまとめて書けます。説明を省くと、`~/works/doc_*/docs`（`RST_DOC_ROOTS` で変えられます）から参照先の題名を document id で引きます。

共有文法ファイルの場所は `RST_GRAMMAR` で変えられます。既定はこのリポジトリの `grammar.lisp` です。

記法と形式の説明は doc_Base010 の `docs/rst-on-lisp` にあります。
