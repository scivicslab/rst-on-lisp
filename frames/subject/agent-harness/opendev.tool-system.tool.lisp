;;; one tool: what it does and in what mode, why its rule is that way, its parameters, and how the handler treats the call
;;; members: read_file, write_file, edit_file, list_files, search; run_command and the process tools; the web tools; the LSP tools; the user-interaction tools; search_tools; spawn_subagent, invoke_skill, batch_tool (the sample is write_file)
(defrule tool -> :nucleus tool/does :purpose tool/rationale :elaboration-part-whole tool/parameters :elaboration-process-step tool/handling)
(defrule tool/does -> :instruction "道具が何をするかを 1 文で書く" :sample "Creates new files only by rejecting attempts to overwrite existing files, directing the agent to use edit_file instead.")
(defrule tool/rationale -> :instruction "その決まりや仕様が防ぐ失敗を 1 文で書く。書かれていなければ空にする" :sample "This constraint prevents accidental full-file overwrites, which are a common failure mode when agents reconstruct files from memory rather than applying targeted edits.")
(defrule tool/parameters -> :instruction "引数の名前と意味を 1 文で書く" :sample "Parameters: file_path, content, and create_dirs (which auto-creates parent directories when set).")
(defrule tool/handling -> :instruction "呼び出しに対する承認、記録、戻り値を 1 文で書く。書かれていなければ空にする" :sample "The handler runs the approval workflow for write operations, records the action with the undo manager for rollback capability, and returns the file path and byte count on success.")
