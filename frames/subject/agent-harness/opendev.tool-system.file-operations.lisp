;;; subject: opendev-terminal-agent-2603 2.4.2 File Operations: the five tools that read, create, edit, list and search files, with the checks that keep the agent from damaging files by stale or inexact edits
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-file-tools p-read-file p-write-file p-edit-content-drift p-edit-replacer-chain p-edit-safety-checks p-list-files p-search-tool p-edit-evolution
;;; members: overview edit-matching edit-safety
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule file-operations -> file-operations-overview tools file-operations-edit-matching file-operations-edit-safety changes)
(defrule file-operations-overview -> :instruction "ファイル操作の道具の数と役割を 1 文で書く" :sample "Five tools handle all file-system interactions (see File Ops category in Table 1), from reading and writing to structured editing and searching.")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule file-operations-edit-matching -> :background file-operations-edit-matching/drift :nucleus file-operations-edit-matching/chain)
(defrule file-operations-edit-matching/drift -> :instruction "モデルが書く置換前の文字列が実物とずれる問題を 1 文で書く" :sample "In practice, the LLM frequently produces old_content that differs slightly from the actual file: trailing whitespace variations, indentation mismatches, escape sequence differences, or minor reformatting from reconstructing code from memory rather than verbatim copy.")
(defrule file-operations-edit-matching/chain -> :instruction "ずれを許す一致の仕組みを 1 文で書く" :sample "The edit tool implements a chain-of-responsibility pattern with nine replacer classes, each addressing a specific mismatch category, from exact match through whitespace normalization, indentation flexibility, escape handling, and context-aware anchor matching (Appendix D enumerates all nine passes with descriptions).")
(defrule file-operations-edit-safety -> :nucleus file-operations-edit-safety/checks :elaboration-set-member file-operations-edit-safety/stale)
(defrule file-operations-edit-safety/checks -> :instruction "一致の後に編集が守る安全と観測の対策を 1 文で書く" :sample "Beyond matching, the edit handler enforces several safety and observability measures.")
(defrule file-operations-edit-safety/stale -> :instruction "読んだ後に変わったファイルへの編集を断る検査を 1 文で書く" :sample "Stale-read validation rejects edits to files modified since the agent’s last read.")
(defrule changes -> :instruction "編集の道具が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
