;;; subject: opendev-terminal-agent-2603 2.3.3 Dual-Memory Architecture for Bounded Thinking: how the thinking step gets a bounded context from a periodically regenerated summary of the whole history plus the latest messages verbatim
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / p-dual-memory-tension p-episodic-memory p-working-memory p-combined-context p-dual-memory-evolution
;;; members: tension long-range short-range combined
;;; children (:include / :frame, in the text's order): changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule dual-memory -> dual-memory-tension dual-memory-long-range dual-memory-short-range dual-memory-combined changes)
(defrule dual-memory-tension -> :instruction "履歴が大きすぎ、直近だけでは目標を忘れるという板挟みへの解決を 1 文で書く" :sample "We resolve this tension through a dual-memory architecture inspired by human cognitive science, which separates compressed long-range context from detailed short-range context.")
(defrule dual-memory-long-range -> :nucleus dual-memory-long-range/summary :purpose dual-memory-long-range/regenerate)
(defrule dual-memory-long-range/summary -> :instruction "全履歴の要約が担う長い範囲の文脈を 1 文で書く" :sample "An LLM-generated summary of the full conversation history captures strategic, long-range context: decisions already made, overall goals, key findings, and important file paths.")
(defrule dual-memory-long-range/regenerate -> :instruction "要約を作り直す頻度とその狙いを 1 文で書く" :sample "Periodic regeneration serves two purposes: it amortizes the cost of the summarization call, and it prevents summary drift, a phenomenon where iteratively summarizing a summary causes accumulated distortion.")
(defrule dual-memory-short-range -> :nucleus dual-memory-short-range/verbatim :reason dual-memory-short-range/rationale)
(defrule dual-memory-short-range/verbatim -> :instruction "直近の往復をそのまま残すことを 1 文で書く" :sample "The last several message pairs (the most recent 6 exchanges by default, controlled by exclude_last_n) are reproduced verbatim.")
(defrule dual-memory-short-range/rationale -> :instruction "要約しない理由を 1 文で書く" :sample "Summarization would destroy exactly the details that matter most for the next action.")
(defrule dual-memory-combined -> :instruction "考える呼び出しの前に組み立てる文脈を 1 文で書く" :sample "Before each thinking LLM call, the system constructs the thinking context by concatenating: (1) the episodic memory summary, providing the “big picture”; (2) the working memory messages, providing operational detail; and (3) the current user query.")
(defrule changes -> :instruction "履歴の扱いが経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
