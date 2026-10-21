;;; subject: opendev-terminal-agent-2603 2.3.6 Adaptive Context Compaction: how context is reduced in graduated stages of rising pressure instead of one emergency summary, and how learned strategies are kept across sessions
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / p-compaction-problem p-acc-introduced p-acc-stages p-artifact-index p-playbook-memory
;;; members: stages
;;; moved into design-decision items: p-compaction-problem (graduated stages instead of a binary threshold); p-acc-introduced; p-artifact-index (an index of touched files and the archive path); p-playbook-memory (a playbook of learned strategies)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp), stage-list (each item one copy of opendev.context-engineering.compaction-stage.lisp), playbook-stages (each item one copy of opendev.context-engineering.playbook-stage.lisp)
;;; elsewhere: none
;;; left-out: the captions of Figures 13 and 14
(defrule compaction -> decisions compaction-stages stage-list playbook-stages)
(defrule decisions -> :instruction "文脈の圧縮で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。段階的な圧縮、触れたファイルの索引、学んだ戦略の保持のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule compaction-stages -> :instruction "圧力が上がるにつれて段階を適用することを 1 文で書く" :sample "Rather than waiting for the context window to fill, ACC monitors context pressure at the start of every ReAct iteration and applies five graduated stages:")
(defrule stage-list -> :instruction "圧縮の段階を、圧力の低い方から順に、1 行に 1 つ段階の名前で挙げる" :frame "opendev.context-engineering.compaction-stage.lisp")
(defrule playbook-stages -> :instruction "手引きを更新する流れの段階を、1 行に 1 つ段階の名前で挙げる" :frame "opendev.context-engineering.playbook-stage.lisp")
