;;; subject: opendev-terminal-agent-2603 2.4.6 User Interaction, Task Management, and Planning: the eight tools that let the agent ask structured questions, track tasks, get a plan approved and signal completion
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-interaction-tools p-ask-user p-ask-user-rendering p-task-tracking p-present-plan p-plan-to-todos p-task-complete p-interaction-evolution
;;; members: overview plan-outcomes
;;; moved into design-decision items: p-task-complete (an explicit completion signal)
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp), decisions (each item one copy of opendev.design-decision.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule user-interaction -> user-interaction-overview tools user-interaction-plan-outcomes decisions changes)
(defrule user-interaction-overview -> :instruction "道具の数と、人が関わる骨格としての役割を 1 文で書く" :sample "Eight tools enable user interaction, task management, and plan-based workflows (see Task Mgmt, User Input, Planning, and Completion categories in Table 1).")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule user-interaction-plan-outcomes -> :nucleus user-interaction-plan-outcomes/three :elaboration-set-member user-interaction-plan-outcomes/outcomes)
(defrule user-interaction-plan-outcomes/three -> :instruction "計画の承認の結果の選択肢を 1 文で書く" :sample "The user responds with one of three outcomes:")
(defrule user-interaction-plan-outcomes/outcomes -> :instruction "選択肢を 1 項目ずつ書く" :sample "approve_auto: Approve the plan and auto-approve all subsequent edits that implement it, minimizing approval friction for trusted plans. / approve: Approve the plan but review each individual edit during implementation, maintaining fine-grained control. / modify: Reject with feedback, providing specific changes the agent should incorporate before re-presenting." :kind bullet)
(defrule decisions -> :instruction "利用者との対話と作業の管理で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。完了の合図のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule changes -> :instruction "利用者との対話が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
