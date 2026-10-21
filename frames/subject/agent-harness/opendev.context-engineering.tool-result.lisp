;;; subject: opendev-terminal-agent-2603 2.3.2 Tool Result Optimization: how tool outputs are shrunk before they enter the conversation: per-tool summaries, offloading of very large outputs, hints suited to the agent, and their link to compaction
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / p-verbose-tool-output p-per-tool-summarizer p-offload-large-output p-agent-aware-hints p-summary-and-compaction p-tool-output-evolution
;;; members: summarizer
;;; moved into design-decision items: p-verbose-tool-output (compact representations before entering the history); p-offload-large-output (very large outputs go to files); p-agent-aware-hints (recovery hints that fit the agent); p-summary-and-compaction (summaries reused in compaction)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp), strategies (each item one copy of opendev.context-engineering.tool-type-strategy.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule tool-result -> decisions tool-result-summarizer strategies changes)
(defrule decisions -> :instruction "道具の出力の扱いで下した設計の決定を、1 行に 1 つ決定の名前で挙げる。縮めて入れる方針、大きな出力の退避、案内の出し分け、圧縮との関係のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule tool-result-summarizer -> :instruction "結果ごとに要約を作る仕組みを 1 文で書く" :sample "Each tool result passes through a dedicated summarizer that maps the tool name and raw output to a concise summary (typically 50–200 characters).")
(defrule strategies -> :instruction "縮め方を、1 行に 1 つ道具の種類の名前で挙げる" :frame "opendev.context-engineering.tool-type-strategy.lisp")
(defrule changes -> :instruction "出力の扱いが経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
