;;; one tool: what it does and in what mode, its parameters, the rules or limits it applies, and what it returns or records
;;; members: read_file, write_file, edit_file, list_files, search; run_command and the process tools; the web tools; the LSP tools; the user-interaction tools; search_tools; spawn_subagent, invoke_skill, batch_tool
(defrule tool -> :nucleus tool/n :elaboration-additional tool/a1 :elaboration-additional tool/a2 :elaboration-additional tool/a3)
(defrule tool/n -> :instruction "道具が何をするかを 1 文で書く" :sample "Creates new files only by rejecting attempts to overwrite existing files, directing the agent to use edit_file instead.")
(defrule tool/a1 -> :instruction "その規則が防ぐ失敗を 1 文で書く" :sample "This constraint prevents accidental full-file overwrites, which are a common failure mode when agents reconstruct files from memory rather than applying targeted edits.")
(defrule tool/a2 -> :instruction "引数の名前と意味を 1 文で書く" :sample "Parameters: file_path, content, and create_dirs (which auto-creates parent directories when set).")
(defrule tool/a3 -> :instruction "承認、記録、戻り値を 1 文で書く" :sample "The handler runs the approval workflow for write operations, records the action with the undo manager for rollback capability, and returns the file path and byte count on success.")
