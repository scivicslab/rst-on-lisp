;;; subject: opendev-terminal-agent-2603 2.4.5 Multi-Language Semantic Code Analysis via LSP: how symbol-level navigation and editing tools are built on language servers behind four layers with a content-hash cache
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-lsp-tools p-lsp-layers p-lsp-cache p-find-symbol p-find-references p-rename-symbol p-replace-body p-insert-symbol p-lsp-evolution
;;; members: adopt layers cache
;;; children (:include / :frame, in the text's order): layer-list (each item one copy of opendev.tool-system.lsp-layer.lisp), tools (each item one copy of opendev.tool-system.tool.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: the caption of Figure 18
(defrule code-analysis -> code-analysis-adopt code-analysis-layers layer-list code-analysis-cache tools changes)
(defrule code-analysis-adopt -> :background code-analysis-adopt/text :nucleus code-analysis-adopt/lsp)
(defrule code-analysis-adopt/text -> :instruction "文字列の検索が意味の構造を捉えられない問題を 1 文で書く" :sample "Text-based tools can search for strings but miss semantic structure: finding all usages of a method requires distinguishing method calls from variable names, handling overloading, and tracking references across files.")
(defrule code-analysis-adopt/lsp -> :instruction "言語サーバを使う方針を書く" :sample "so OpenDev adopts Language Server Protocol integration via standard language servers [55], reusing a mature ecosystem where each server is maintained by domain experts.")
(defrule code-analysis-layers -> :instruction "翻訳の層の数と役割を 1 文で書く" :sample "Figure 18 illustrates the architecture, organized into four layers that progressively translate between agent-facing tool calls and language-server-specific protocol messages.")
(defrule layer-list -> :instruction "層を、1 行に 1 つ層の名前で挙げる" :frame "opendev.tool-system.lsp-layer.lisp")
(defrule code-analysis-cache -> :nucleus code-analysis-cache/two-level :elaboration-set-member code-analysis-cache/levels)
(defrule code-analysis-cache/two-level -> :instruction "往復を省く保存の仕組みを 1 文で書く" :sample "each language server maintains a two-level cache keyed by file content hash (MD5).")
(defrule code-analysis-cache/levels -> :instruction "保存の段ごとの使い方を 1 文で書く" :sample "When a file has not changed, queries return from Level 2 without contacting the server.")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule changes -> :instruction "解析の方式が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
