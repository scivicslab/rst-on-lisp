;;; subject: opendev-terminal-agent-2603 2.2.7 Subagent Orchestration: how the main agent hands subtasks to specialised subagents with limited tools, runs them side by side, and keeps them from running without end
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / p-why-subagents p-subagent-roles-intro p-subagent-restriction p-subagent-parallelism p-subagent-prompt-refinements p-subagent-evolution
;;; members: why roles
;;; moved into design-decision items: p-subagent-restriction (limited tools per subagent); p-subagent-parallelism (running subagents side by side); p-subagent-prompt-refinements (stop conditions in subagent prompts)
;;; children (:include / :frame, in the text's order): role-list (each item one copy of opendev.agent-core.subagent-role.lisp), decisions (each item one copy of opendev.design-decision.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule subagents -> subagents-why subagents-roles role-list decisions changes)
(defrule subagents-why -> :nucleus subagents-why/spawn :elaboration-object-attribute subagents-why/isolated)
(defrule subagents-why/spawn -> :instruction "主のエージェントが専門の部下を起動できることを 1 文で書く" :sample "The main agent can spawn specialized subagents for specific subtasks, each with filtered tool access and specialized prompts.")
(defrule subagents-why/isolated -> :instruction "部下の実行がどう隔てられ、何で縛られるかを 1 文で書く" :sample "Subagents execute in isolated contexts with their own iteration budgets, preventing unbounded execution.")
(defrule subagents-roles -> :instruction "部下が役割ごとに違うことを 1 文で書く" :sample "Different subagents serve different roles:")
(defrule role-list -> :instruction "部下の役割を、1 行に 1 つ役割の名前で挙げる" :frame "opendev.agent-core.subagent-role.lisp")
(defrule decisions -> :instruction "部下の扱いで下した設計の決定を、1 行に 1 つ決定の名前で挙げる。道具の制限、並べた実行、指示に入れる終了の条件のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule changes -> :instruction "部下の設計が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
