;;; subject: opendev-terminal-agent-2603 2.4.2 File Operations: the five tools that read, create, edit, list and search files, with the checks that keep the agent from damaging files by stale or inexact edits
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-file-tools p-read-file p-write-file p-edit-content-drift p-edit-replacer-chain p-edit-safety-checks p-list-files p-search-tool p-edit-evolution
;;; members: overview
;;; moved into design-decision items: p-edit-content-drift and p-edit-replacer-chain (a chain of replacers for inexact edits); p-edit-safety-checks (checks around an edit)
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp), decisions (each item one copy of opendev.design-decision.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule file-operations -> file-operations-overview tools decisions changes)
(defrule file-operations-overview -> :instruction "ファイル操作の道具の数と役割を 1 文で書く" :sample "Five tools handle all file-system interactions (see File Ops category in Table 1), from reading and writing to structured editing and searching.")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule decisions -> :instruction "ファイル編集で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。ずれを許す一致の仕組み、編集まわりの安全の検査のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule changes -> :instruction "編集の道具が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
