;;; subject: opendev-terminal-agent-2603 2.5.1 Session Storage: how one conversation is stored as a metadata file and a transcript, written safely, saved automatically, indexed, titled and resumed
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / p-session-files p-safe-write p-auto-save p-session-index p-session-titles p-cost-metadata p-legacy-migration
;;; members: titles cost
;;; moved into design-decision items: p-session-files (metadata and transcript in two files); p-safe-write (lock, temporary file, atomic rename); p-auto-save (saving every few turns); p-session-index (a self-healing index)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule sessions -> decisions sessions-titles sessions-cost changes)
(defrule decisions -> :instruction "会話の保存で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。ファイルの分け方、書き込みの安全、保存の間隔、索引のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule sessions-titles -> :nucleus sessions-titles/generated :elaboration-additional sessions-titles/default)
(defrule sessions-titles/generated -> :instruction "会話の題の作り方を 1 文で書く" :sample "A lightweight topic-detection model generates a short title (capped at 50 characters) by examining the last 4 messages.")
(defrule sessions-titles/default -> :instruction "指定が無いときに開く会話を 1 文で書く" :sample "When the user starts the agent in a project directory without specifying a session, the system defaults to the most recent session for that project, enabling a “continue where I left off” workflow.")
(defrule sessions-cost -> :instruction "会話の費用を記録する項目を 1 文で書く" :sample "Each session’s metadata file includes a cost_tracking object that records cumulative API usage: total input tokens, total output tokens, total cost in USD (computed from model pricing metadata), and the number of API calls.")
(defrule changes -> :instruction "保存の形式が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
