;;; one tool of the harness: what it does and in what mode, why its rule is that way, its parameters, and how the harness treats the call
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule tool -> :nucleus tool/does :purpose tool/prevents :elaboration-part-whole tool/parameters :elaboration-process-step tool/handling)
(defrule tool/does -> :instruction "道具が何をするかを 1 文で書く" :sample "Creates new files only by rejecting attempts to overwrite existing files, directing the agent to use edit_file instead.")
(defrule tool/prevents -> :instruction "その決まりや仕様が防ぐ失敗を 1 文で書く。書かれていなければ空にする" :sample "This constraint prevents accidental full-file overwrites, which are a common failure mode when agents reconstruct files from memory rather than applying targeted edits.")
(defrule tool/parameters -> :instruction "引数の名前と意味を 1 文で書く" :sample "Parameters: file_path, content, and create_dirs (which auto-creates parent directories when set).")
(defrule tool/handling -> :instruction "呼び出しに対する承認、記録、戻り値を 1 文で書く。書かれていなければ空にする" :sample "The handler runs the approval workflow for write operations, records the action with the undo manager for rollback capability, and returns the file path and byte count on success.")
