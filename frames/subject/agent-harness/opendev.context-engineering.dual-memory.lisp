;;; subject: opendev-terminal-agent-2603 2.3.3 Dual-Memory Architecture for Bounded Thinking: how the thinking step gets a bounded context from a periodically regenerated summary of the whole history plus the latest messages verbatim
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / p-dual-memory-tension p-episodic-memory p-working-memory p-combined-context p-dual-memory-evolution
;;; members: combined
;;; moved into design-decision items: p-dual-memory-tension (summary plus recent messages); p-episodic-memory (a summary regenerated from the full history); p-working-memory (recent messages kept verbatim)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule dual-memory -> decisions dual-memory-combined changes)
(defrule decisions -> :instruction "考える段階に渡す履歴で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。長い範囲の要約、直近の原文のままの保持のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule dual-memory-combined -> :instruction "考える呼び出しの前に組み立てる文脈を 1 文で書く" :sample "Before each thinking LLM call, the system constructs the thinking context by concatenating: (1) the episodic memory summary, providing the “big picture”; (2) the working memory messages, providing operational detail; and (3) the current user query.")
(defrule changes -> :instruction "履歴の扱いが経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
