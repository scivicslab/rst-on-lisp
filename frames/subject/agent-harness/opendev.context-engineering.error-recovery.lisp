;;; subject: opendev-terminal-agent-2603 2.3.5 Context-Injected Error Recovery: how a failed tool call is turned into targeted recovery guidance placed right before the next model call, with a bounded number of attempts
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / p-error-as-context p-error-recovery-steps p-error-nudge-budget
;;; members: steps
;;; moved into design-decision items: p-error-as-context (recovery guidance injected for a failed call); p-error-nudge-budget (a bounded number of attempts)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule error-recovery -> decisions error-recovery-steps)
(defrule decisions -> :instruction "エラーからの回復で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。手引きの注入、試行の上限のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule error-recovery-steps -> :nucleus error-recovery-steps/four-steps :example error-recovery-steps/example)
(defrule error-recovery-steps/four-steps -> :instruction "手順の数と各段階を 1 文で書く" :sample "The mechanism operates in four steps: (1) classify the error by pattern-matching the message to one of six categories (permission error, file not found, edit mismatch, syntax error, rate limit, timeout); (2) retrieve the corresponding recovery template from a centralized template store; (3) format the template with context-specific details (the failing file path, the mismatched content, the specific error message); and (4) inject the formatted template as a system message immediately before the next LLM call, placing it at maximum recency in the conversation.")
(defrule error-recovery-steps/example -> :instruction "具体的なエラーとその手引きを 1 文で書く" :sample "For example, an edit-mismatch error produces the guidance: “ the file has changed since you last read it; re-read the file and retry your edit with the current content. ” This is substantially more actionable than a generic retry instruction, because it tells the model what changed and what to do next.")
