;;; subject: opendev-terminal-agent-2603 2.4.5 Multi-Language Semantic Code Analysis via LSP: how symbol-level navigation and editing tools are built on language servers behind four layers with a content-hash cache
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-lsp-tools p-lsp-layers p-lsp-cache p-find-symbol p-find-references p-rename-symbol p-replace-body p-insert-symbol p-lsp-evolution
;;; members: layers
;;; moved into design-decision items: p-lsp-tools (language servers instead of custom parsers); p-lsp-cache (a two-level cache keyed by content hash)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp), layer-list (each item one copy of opendev.tool-system.lsp-layer.lisp), tools (each item one copy of opendev.tool-system.tool.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: the caption of Figure 18
(defrule code-analysis -> decisions code-analysis-layers layer-list tools changes)
(defrule decisions -> :instruction "コードの解析で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。解析の土台の選び方、往復を省く保存のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule code-analysis-layers -> :instruction "翻訳の層の数と役割を 1 文で書く" :sample "Figure 18 illustrates the architecture, organized into four layers that progressively translate between agent-facing tool calls and language-server-specific protocol messages.")
(defrule layer-list -> :instruction "層を、1 行に 1 つ層の名前で挙げる" :frame "opendev.tool-system.lsp-layer.lisp")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule changes -> :instruction "解析の方式が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
