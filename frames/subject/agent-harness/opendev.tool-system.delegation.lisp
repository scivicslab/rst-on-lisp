;;; subject: opendev-terminal-agent-2603 2.4.8 Subagent Delegation, Skills, and Batch Execution: the three tools that go beyond single calls: handing a subtask to a subagent, loading domain knowledge on demand, and running several calls in one turn
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-beyond-single-calls p-spawn-subagent p-subagent-auto-parallel p-spawn-parameters p-skills-defined p-skills-discovery-phase p-skills-loading-phase p-skill-tiers p-batch-tool p-delegation-evolution
;;; members: overview skills tiers batch
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp), skill-phases (each item one copy of opendev.tool-system.skill-phase.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule delegation -> delegation-overview tools delegation-skills skill-phases delegation-tiers delegation-batch changes)
(defrule delegation-overview -> :instruction "この節が扱う三つの道具を 1 文で書く" :sample "This section describes three tools that extend the agent’s capabilities beyond single-tool invocations: subagent delegation for complex subtasks, skill loading for on-demand domain expertise, and batch execution for multi-tool efficiency.")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule delegation-skills -> :instruction "指示書の性質と必要な理由を 1 文で書く" :sample "Skills are modular knowledge units stored as markdown files with YAML frontmatter, providing domain-specific expertise (git conventions, code review checklists, deployment procedures) that would waste context if loaded unconditionally.")
(defrule skill-phases -> :instruction "指示書を扱う段階を、行う順に、1 行に 1 つ段階の名前で挙げる" :frame "opendev.tool-system.skill-phase.lisp")
(defrule delegation-tiers -> :instruction "指示書の置き場の優先順位を 1 文で書く" :sample "Skills are discovered from three tiers with strict priority ordering: project-local (.opendev/skills/, highest priority) for repository-specific conventions, user-global (˜ /.opendev/skills/) for personal preferences across all projects, and built-in (shipped with the package, lowest priority) for default expertise.")
(defrule delegation-batch -> :nucleus delegation-batch/mode :comparison delegation-batch/automatic)
(defrule delegation-batch/mode -> :instruction "一括実行で呼び出し側が実行の仕方を指定することを 1 文で書く" :sample "The agent specifies the execution mode: parallel (thread pool with max 5 concurrent workers) for independent operations like reading multiple files or running multiple searches, or serial for dependent operations like creating a directory then writing a file into it.")
(defrule delegation-batch/automatic -> :instruction "自動で判定する方式を試した結果を 1 文で書く" :sample "Automatic dependency detection was attempted but proved unreliable; explicit agent-specified mode delegating the decision to the entity with full context knowledge solved this cleanly.")
(defrule changes -> :instruction "委譲と指示書と一括実行が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
