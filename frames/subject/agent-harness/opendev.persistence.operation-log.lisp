;;; subject: opendev-terminal-agent-2603 2.5.2 Operation Log and Undo: how every file operation by the tools is logged for a one-command undo, and how a shadow git repository covers side effects of shell commands
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / p-undo-need p-operation-record p-undo-procedure p-undo-and-vcs p-shadow-git
;;; members: record undo
;;; moved into design-decision items: p-undo-need (log every file operation for a one-command undo); p-undo-and-vcs (undo alongside version control); p-shadow-git (a shadow git repository for side effects)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule operation-log -> decisions operation-log-record operation-log-undo)
(defrule decisions -> :instruction "取り消しで下した設計の決定を、1 行に 1 つ決定の名前で挙げる。操作の記録、版管理との併用、副作用を覆う仕組みのうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule operation-log-record -> :nucleus operation-log-record/fields :elaboration-part-whole operation-log-record/places)
(defrule operation-log-record/fields -> :instruction "操作の記録が持つ項目を 1 文で書く" :sample "Each operation record contains the operation type, file path, timestamp, a unique identifier, and the file’s content before the operation.")
(defrule operation-log-record/places -> :instruction "記録を置く場所を 1 文で書く" :sample "These records are stored in two places: an in-memory list for fast undo during the current session, and a JSONL file (operations.jsonl) in the session directory for durability.")
(defrule operation-log-undo -> :nucleus operation-log-undo/undo-flow :elaboration-object-attribute operation-log-undo/cap)
(defrule operation-log-undo/undo-flow -> :instruction "取り消しを求められたときの手順を 1 文で書く" :sample "When the user invokes undo, the system pops the most recent operation from the in-memory list and reverses it: created files are deleted, modified files are reverted to their backed-up content, and deleted files are restored from the saved copy.")
(defrule operation-log-undo/cap -> :instruction "記憶上の履歴の上限とその狙いを 1 文で書く" :sample "The in-memory history is capped at 50 operations to prevent unbounded memory growth.")
