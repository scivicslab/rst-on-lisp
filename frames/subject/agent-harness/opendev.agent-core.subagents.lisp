;;; subject: opendev-terminal-agent-2603 2.2.7 Subagent Orchestration: how the main agent hands subtasks to specialised subagents with limited tools, runs them side by side, and keeps them from running without end
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / p-why-subagents p-subagent-roles-intro p-subagent-restriction p-subagent-parallelism p-subagent-prompt-refinements p-subagent-evolution
;;; members: why roles restriction parallelism prompts
;;; children (:include / :frame, in the text's order): role-list (each item one copy of opendev.agent-core.subagent-role.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule subagents -> subagents-why subagents-roles role-list subagents-restriction subagents-parallelism subagents-prompts changes)
(defrule subagents-why -> :nucleus subagents-why/spawn :elaboration-object-attribute subagents-why/isolated)
(defrule subagents-why/spawn -> :instruction "主のエージェントが専門の部下を起動できることを 1 文で書く" :sample "The main agent can spawn specialized subagents for specific subtasks, each with filtered tool access and specialized prompts.")
(defrule subagents-why/isolated -> :instruction "部下の実行がどう隔てられ、何で縛られるかを 1 文で書く" :sample "Subagents execute in isolated contexts with their own iteration budgets, preventing unbounded execution.")
(defrule subagents-roles -> :instruction "部下が役割ごとに違うことを 1 文で書く" :sample "Different subagents serve different roles:")
(defrule role-list -> :instruction "部下の役割を、1 行に 1 つ役割の名前で挙げる" :frame "opendev.agent-core.subagent-role.lisp")
(defrule subagents-restriction -> :nucleus subagents-restriction/deliberate :reason subagents-restriction/reasons)
(defrule subagents-restriction/deliberate -> :instruction "部下の能力を意図して制限する理由の数を 1 文で書く" :sample "Subagent capabilities are deliberately restricted for three reasons.")
(defrule subagents-restriction/reasons -> :instruction "理由を 1 項目ずつ、理由の内容で書く" :sample "First, task management tools are excluded from subagents so that only the main agent coordinates todo lists, preventing race conditions and inconsistent state. / Second, limited tool access reduces context size and focuses each subagent on its specific role, meaning an exploration subagent does not need write capabilities. / Third, restricted tools limit the blast radius of errors: an exploration subagent cannot accidentally modify files." :kind bullet)
(defrule subagents-parallelism -> :nucleus subagents-parallelism/concurrent :means subagents-parallelism/guidance :evaluation-s subagents-parallelism/tradeoff)
(defrule subagents-parallelism/concurrent -> :instruction "部下を並べて動かせる場面を 1 文で書く" :sample "The main agent can spawn multiple subagents concurrently (each in its own thread) for independent queries such as parallel file searches, codebase exploration, or web fetches.")
(defrule subagents-parallelism/guidance -> :instruction "並べて動かす方法を 1 文で書く" :sample "Making multiple spawn_subagent calls in the same response triggers automatic parallel execution.")
(defrule subagents-parallelism/tradeoff -> :instruction "並べることが引き換えにするものを 1 文で書く" :sample "This trades thread overhead for latency reduction on independent operations.")
(defrule subagents-prompts -> :nucleus subagents-prompts/termination :example subagents-prompts/explorer)
(defrule subagents-prompts/termination -> :instruction "部下の指示に終了の条件を入れることを 1 文で書く" :sample "Subagent prompts include explicit termination conditions")
(defrule subagents-prompts/explorer -> :instruction "終了の条件の具体例を 1 文で書く" :sample "The Code Explorer subagent has stop conditions (“ stop when evidence is clear,” “ stop if progress stalls,” “ prefer depth over breadth ”) and an anti-loop instruction (“ re-reading the same file triggers immediate stop ”).")
(defrule changes -> :instruction "部下の設計が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
