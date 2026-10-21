;;; subject: opendev-terminal-agent-2603 2.4.8 Subagent Delegation, Skills, and Batch Execution: the three tools that go beyond single calls: handing a subtask to a subagent, loading domain knowledge on demand, and running several calls in one turn
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / s42 .. s4
;;; members: overview subagent skills batch design-evolution next
;;; elsewhere: none
;;; left-out: none
(defrule delegation -> delegation-overview delegation-subagent delegation-skills delegation-batch delegation-design-evolution delegation-next)
(defrule delegation-overview -> :nucleus delegation-overview/n)
(defrule delegation-overview/n -> :instruction "この節が扱う三つの道具を 1 文で書く" :sample "This section describes three tools that extend the agent’s capabilities beyond single-tool invocations: subagent delegation for complex subtasks, skill loading for on-demand domain expertise, and batch execution for multi-tool efficiency.")
(defrule delegation-subagent -> :nucleus delegation-subagent/n :elaboration-additional delegation-subagent/a1 :elaboration-additional delegation-subagent/a2)
(defrule delegation-subagent/n -> :instruction "部下の起動が何を作るかを 1 文で書く" :sample "Launches an isolated subagent with its own ReAct loop and filtered tool registry.")
(defrule delegation-subagent/a1 -> :instruction "自動で並べて動かす性質を 1 文で書く" :sample "A key design property is automatic parallelization: when the main agent emits multiple spawn_subagent calls in the same LLM response, the SubAgentManager executes them concurrently via asyncio.gather(), with each subagent running in a separate thread with its own iteration budget and tool worker pool.")
(defrule delegation-subagent/a2 -> :instruction "追加の引数を 1 文で書く" :sample "Additional parameters provide flexibility: model override (haiku for fast, low-cost tasks; sonnet for balanced capability; opus for complex reasoning), background execution (agent continues without waiting for completion), and session resume by agent ID (enabling multi-turn subagent workflows where context is preserved across invocations).")
(defrule delegation-skills -> :nucleus delegation-skills/n :elaboration-additional delegation-skills/a1 :elaboration-additional delegation-skills/a2 :elaboration-additional delegation-skills/a3)
(defrule delegation-skills/n -> :instruction "指示書の性質と、必要な理由を 1 文で書く" :sample "Skills are modular knowledge units stored as markdown files with YAML frontmatter, providing domain-specific expertise (git conventions, code review checklists, deployment procedures) that would waste context if loaded unconditionally.")
(defrule delegation-skills/a1 -> :instruction "第 1 段階の見つける仕事を 1 文で書く" :sample "Phase 1: Metadata discovery.")
(defrule delegation-skills/a2 -> :instruction "第 2 段階の読み込みを 1 文で書く" :sample "Phase 2: On-demand loading.")
(defrule delegation-skills/a3 -> :instruction "指示書の置き場の優先順位を 1 文で書く" :sample "Skills are discovered from three tiers with strict priority ordering: project-local (.opendev/skills/, highest priority) for repository-specific conventions, user-global (˜ /.opendev/skills/) for personal preferences across all projects, and built-in (shipped with the package, lowest priority) for default expertise.")
(defrule delegation-batch -> :nucleus delegation-batch/n :elaboration-additional delegation-batch/a1 :elaboration-additional delegation-batch/a2)
(defrule delegation-batch/n -> :instruction "一括実行の道具が何を可能にするかを 1 文で書く" :sample "Enables multiple tool calls in a single agent turn, reducing round-trip overhead.")
(defrule delegation-batch/a1 -> :instruction "実行の仕方を呼び出し側が指定する理由を 1 文で書く" :sample "The agent specifies the mode because only it knows the dependency relationships from context, as the system cannot reliably infer whether operations are independent.")
(defrule delegation-batch/a2 -> :instruction "自動判定を試した結果を 1 文で書く" :sample "Automatic dependency detection was attempted but proved unreliable; explicit agent-specified mode delegating the decision to the entity with full context knowledge solved this cleanly.")
(defrule delegation-design-evolution -> :nucleus delegation-design-evolution/n :elaboration-additional delegation-design-evolution/a1)
(defrule delegation-design-evolution/n -> :instruction "初期の設計に無かったものと、その問題を 1 文で書く" :sample "The initial design had no batch execution; every tool required a full LLM round-trip, and multiple file reads took multiple turns.")
(defrule delegation-design-evolution/a1 -> :instruction "現在の設計が三つの問題をどう解くかを 1 文で書く" :sample "The current architecture addresses all three issues: batch execution eliminates unnecessary round-trips, two-phase skill loading reduces baseline overhead to a compact metadata index, and automatic parallelization of subagent calls exploits task independence without requiring the agent to manage concurrency explicitly.")
(defrule delegation-next -> :nucleus delegation-next/n)
(defrule delegation-next/n -> :instruction "この節から次の層への橋渡しを 1 文で書く" :sample "The tools above produce artifacts and side effects; the persistence layer ensures these survive across sessions and provides rollback when the agent makes mistakes.")
