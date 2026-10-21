;;; subject: opendev-terminal-agent-2603 2.3.2 Tool Result Optimization: how tool outputs are shrunk before they enter the conversation: per-tool summaries, offloading of very large outputs, hints suited to the agent, and their link to compaction
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / p-verbose-tool-output p-per-tool-summarizer p-offload-large-output p-agent-aware-hints p-summary-and-compaction p-tool-output-evolution
;;; members: problem summarizer offload hints compaction-link
;;; children (:include / :frame, in the text's order): strategies (each item one copy of opendev.context-engineering.tool-type-strategy.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule tool-result -> tool-result-problem tool-result-summarizer strategies tool-result-offload tool-result-hints tool-result-compaction-link changes)
(defrule tool-result-problem -> :background tool-result-problem/verbose :nucleus tool-result-problem/approach)
(defrule tool-result-problem/verbose -> :instruction "道具の生の出力が文脈を食いつぶす問題を 1 文で書く" :sample "Raw tool outputs consume far more tokens than their informational value warrants.")
(defrule tool-result-problem/approach -> :instruction "その問題への対策の方針を 1 文で書く" :sample "Tool result optimization addresses this by transforming raw outputs into compact, semantically preserving representations before they enter the conversation history.")
(defrule tool-result-summarizer -> :instruction "結果ごとに要約を作る仕組みを 1 文で書く" :sample "Each tool result passes through a dedicated summarizer that maps the tool name and raw output to a concise summary (typically 50–200 characters).")
(defrule strategies -> :instruction "縮め方を、1 行に 1 つ道具の種類の名前で挙げる" :frame "opendev.context-engineering.tool-type-strategy.lisp")
(defrule tool-result-offload -> :background tool-result-offload/insufficient :nucleus tool-result-offload/scratch)
(defrule tool-result-offload/insufficient -> :instruction "要約でも足りない出力があることを 1 文で書く" :sample "For outputs that exceed 8,000 characters (approximately 2,000 tokens), the summarizer is insufficient: the full output would still dominate the context even after summarization.")
(defrule tool-result-offload/scratch -> :instruction "そういう出力の置き場を変える決まりを 1 文で書く" :sample "These outputs are offloaded to scratch files before entering the conversation history.")
(defrule tool-result-hints -> :instruction "退避したときの案内が、エージェントの能力に合わせて変わることを 1 文で書く" :sample "When output is offloaded to a scratch file, the truncation message includes a tailored recovery hint based on the current agent’s capabilities.")
(defrule tool-result-compaction-link -> :instruction "要約と退避が相補う役割を持つことを 1 文で書く" :sample "Tool result summaries and offloaded outputs serve complementary roles.")
(defrule changes -> :instruction "出力の扱いが経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
