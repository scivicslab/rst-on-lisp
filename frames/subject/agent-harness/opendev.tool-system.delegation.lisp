;;; subject: opendev-terminal-agent-2603 2.4.8 Subagent Delegation, Skills, and Batch Execution: the three tools that go beyond single calls: handing a subtask to a subagent, loading domain knowledge on demand, and running several calls in one turn
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-beyond-single-calls p-spawn-subagent p-subagent-auto-parallel p-spawn-parameters p-skills-defined p-skills-discovery-phase p-skills-loading-phase p-skill-tiers p-batch-tool p-delegation-evolution
;;; members: overview skills
;;; moved into design-decision items: p-skill-tiers (priority among skill locations); p-batch-tool (the caller states serial or parallel)
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp), skill-phases (each item one copy of opendev.tool-system.skill-phase.lisp), decisions (each item one copy of opendev.design-decision.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule delegation -> delegation-overview tools delegation-skills skill-phases decisions changes)
(defrule delegation-overview -> :instruction "この節が扱う三つの道具を 1 文で書く" :sample "This section describes three tools that extend the agent’s capabilities beyond single-tool invocations: subagent delegation for complex subtasks, skill loading for on-demand domain expertise, and batch execution for multi-tool efficiency.")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule delegation-skills -> :instruction "指示書の性質と必要な理由を 1 文で書く" :sample "Skills are modular knowledge units stored as markdown files with YAML frontmatter, providing domain-specific expertise (git conventions, code review checklists, deployment procedures) that would waste context if loaded unconditionally.")
(defrule skill-phases -> :instruction "指示書を扱う段階を、行う順に、1 行に 1 つ段階の名前で挙げる" :frame "opendev.tool-system.skill-phase.lisp")
(defrule decisions -> :instruction "委譲と指示書と一括実行で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。指示書の置き場の優先、実行の仕方を呼び出し側が決めることのうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule changes -> :instruction "委譲と指示書と一括実行が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
