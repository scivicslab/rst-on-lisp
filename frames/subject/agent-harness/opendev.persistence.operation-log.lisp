;;; subject: opendev-terminal-agent-2603 2.5.2 Operation Log and Undo: how every file operation by the tools is logged for a one-command undo, and how a shadow git repository covers side effects of shell commands
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / s9 .. s10
;;; members: why record undo vcs shadow
;;; elsewhere: none
;;; left-out: none
(defrule operation-log -> operation-log-why operation-log-record operation-log-undo operation-log-vcs operation-log-shadow)
(defrule operation-log-why -> :nucleus operation-log-why/n :elaboration-additional operation-log-why/a1)
(defrule operation-log-why/n -> :instruction "エージェントの間違いと、取り消しの手段を 1 文で書く" :sample "Agents make mistakes: they write to the wrong file, make an edit that breaks something, or delete a file the user did not intend to remove.")
(defrule operation-log-why/a1 -> :instruction "操作を記録して一つの命令で戻す方針を 1 文で書く" :sample "Rather than requiring users to manually undo these changes with version control commands, OpenDev tracks every file operation (create, modify, delete) in a log and provides a single-command undo.")
(defrule operation-log-record -> :nucleus operation-log-record/n :elaboration-additional operation-log-record/a1 :elaboration-additional operation-log-record/a2)
(defrule operation-log-record/n -> :instruction "操作の記録が持つ項目を 1 文で書く" :sample "Each operation record contains the operation type, file path, timestamp, a unique identifier, and the file’s content before the operation.")
(defrule operation-log-record/a1 -> :instruction "記録を置く二つの場所を 1 文で書く" :sample "These records are stored in two places: an in-memory list for fast undo during the current session, and a JSONL file (operations.jsonl) in the session directory for durability.")
(defrule operation-log-record/a2 -> :instruction "耐久用の記録が失敗したときの扱いを 1 文で書く" :sample "The JSONL log is best-effort: if writing to it fails (for example, due to a permission issue), the failure is logged but does not interrupt the agent’s work.")
(defrule operation-log-undo -> :nucleus operation-log-undo/n :elaboration-additional operation-log-undo/a1 :elaboration-additional operation-log-undo/a2)
(defrule operation-log-undo/n -> :instruction "取り消しを求められたときの手順を 1 文で書く" :sample "When the user invokes undo, the system pops the most recent operation from the in-memory list and reverses it: created files are deleted, modified files are reverted to their backed-up content, and deleted files are restored from the saved copy.")
(defrule operation-log-undo/a1 -> :instruction "記憶上の履歴の上限を 1 文で書く" :sample "The in-memory history is capped at 50 operations to prevent unbounded memory growth.")
(defrule operation-log-undo/a2 -> :instruction "上限が支障にならない見立てを 1 文で書く" :sample "In practice, users rarely need to undo operations older than the last dozen or so, so this bound has not been a limitation.")
(defrule operation-log-vcs -> :nucleus operation-log-vcs/n :elaboration-additional operation-log-vcs/a1)
(defrule operation-log-vcs/n -> :instruction "取り消しが版管理と併用されることを 1 文で書く" :sample "The undo system works alongside version control rather than replacing it.")
(defrule operation-log-vcs/a1 -> :instruction "この取り消しが得意なことを 1 文で書く" :sample "It handles uncommitted changes without requiring the user to know git, and provides lower friction than typing git restore for quick corrections after agent mistakes.")
(defrule operation-log-shadow -> :nucleus operation-log-shadow/n :elaboration-additional operation-log-shadow/a1 :elaboration-additional operation-log-shadow/a2 :elaboration-additional operation-log-shadow/a3 :elaboration-additional operation-log-shadow/a4 :elaboration-additional operation-log-shadow/a5)
(defrule operation-log-shadow/n -> :instruction "記憶上の記録が捕らえられない副作用の範囲を 1 文で書く" :sample "The in-memory undo log tracks only file operations performed through the agent’s tools.")
(defrule operation-log-shadow/a1 -> :instruction "全体の取り消しのための影の版管理の置き場を 1 文で書く" :sample "For comprehensive per-step undo, the system maintains a shadow git repository, a bare repository at ~/.opendev/snapshot/<project-id>/ that shares no history with the user’s actual repository.")
(defrule operation-log-shadow/a2 -> :instruction "ファイルを変える各段階で行うことを 1 文で書く" :sample "At every agent step that modifies files, the snapshot system runs git add. && git write-tree against the project working directory using the shadow repository’s object store, recording a tree hash in the session metadata.")
(defrule operation-log-shadow/a3 -> :instruction "取り消しの命令が行うことを 1 文で書く" :sample "The /undo command computes a git diff between the current tree and the snapshot tree, identifies changed files, and restores them via git checkout <hash> -- <file>.")
(defrule operation-log-shadow/a4 -> :instruction "無視の設定と掃除を 1 文で書く" :sample "The shadow repository’s .gitignore is synchronized from the real repository to avoid tracking build artifacts.")
(defrule operation-log-shadow/a5 -> :instruction "この方式の利点を 1 文で書く" :sample "This approach leverages git’s content-addressable storage for perfect file-level restoration without interfering with the user’s version control workflow.")
