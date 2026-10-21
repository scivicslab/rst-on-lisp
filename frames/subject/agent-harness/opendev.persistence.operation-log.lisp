;;; subject: opendev-terminal-agent-2603 2.5.2 Operation Log and Undo: how every file operation by the tools is logged for a one-command undo, and how a shadow git repository covers side effects of shell commands
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / p-undo-need p-operation-record p-undo-procedure p-undo-and-vcs p-shadow-git
;;; members: need record undo vcs shadow
;;; elsewhere: none
;;; left-out: none
(defrule operation-log -> operation-log-need operation-log-record operation-log-undo operation-log-vcs operation-log-shadow)
(defrule operation-log-need -> :background operation-log-need/errs :nucleus operation-log-need/log)
(defrule operation-log-need/errs -> :instruction "エージェントの間違いの種類を 1 文で書く" :sample "Agents make mistakes: they write to the wrong file, make an edit that breaks something, or delete a file the user did not intend to remove.")
(defrule operation-log-need/log -> :instruction "記録と一つの命令での取り消しという方針を 1 文で書く" :sample "Rather than requiring users to manually undo these changes with version control commands, OpenDev tracks every file operation (create, modify, delete) in a log and provides a single-command undo.")
(defrule operation-log-record -> :nucleus operation-log-record/fields :elaboration-part-whole operation-log-record/places)
(defrule operation-log-record/fields -> :instruction "操作の記録が持つ項目を 1 文で書く" :sample "Each operation record contains the operation type, file path, timestamp, a unique identifier, and the file’s content before the operation.")
(defrule operation-log-record/places -> :instruction "記録を置く場所を 1 文で書く" :sample "These records are stored in two places: an in-memory list for fast undo during the current session, and a JSONL file (operations.jsonl) in the session directory for durability.")
(defrule operation-log-undo -> :nucleus operation-log-undo/undo-flow :elaboration-object-attribute operation-log-undo/cap)
(defrule operation-log-undo/undo-flow -> :instruction "取り消しを求められたときの手順を 1 文で書く" :sample "When the user invokes undo, the system pops the most recent operation from the in-memory list and reverses it: created files are deleted, modified files are reverted to their backed-up content, and deleted files are restored from the saved copy.")
(defrule operation-log-undo/cap -> :instruction "記憶上の履歴の上限とその狙いを 1 文で書く" :sample "The in-memory history is capped at 50 operations to prevent unbounded memory growth.")
(defrule operation-log-vcs -> :instruction "取り消しが版管理とどう併用されるかを 1 文で書く" :sample "The undo system works alongside version control rather than replacing it.")
(defrule operation-log-shadow -> :background operation-log-shadow/limit :nucleus operation-log-shadow/repository :elaboration-process-step operation-log-shadow/snapshot)
(defrule operation-log-shadow/limit -> :instruction "記録が捉えられない副作用を 1 文で書く" :sample "It cannot capture side effects from shell commands (e.g., npm install modifying package-lock.json) or build processes.")
(defrule operation-log-shadow/repository -> :instruction "全体の取り消しのための影の版管理を 1 文で書く" :sample "For comprehensive per-step undo, the system maintains a shadow git repository, a bare repository at ~/.opendev/snapshot/<project-id>/ that shares no history with the user’s actual repository.")
(defrule operation-log-shadow/snapshot -> :instruction "変更する各段階で行うことを 1 文で書く" :sample "At every agent step that modifies files, the snapshot system runs git add. && git write-tree against the project working directory using the shadow repository’s object store, recording a tree hash in the session metadata.")
