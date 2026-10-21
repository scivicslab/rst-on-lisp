;;; subject: opendev-terminal-agent-2603 2.4.6 User Interaction, Task Management, and Planning: the eight tools that let the agent ask structured questions, track tasks, get a plan approved and signal completion
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / s33 .. s4
;;; members: overview plan-outcomes completion-signal design-evolution
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule user-interaction -> user-interaction-overview tools user-interaction-plan-outcomes user-interaction-completion-signal user-interaction-design-evolution)
(defrule user-interaction-overview -> :nucleus user-interaction-overview/n :elaboration-additional user-interaction-overview/a1)
(defrule user-interaction-overview/n -> :instruction "道具の数と、人が関わる骨格としての役割を 1 文で書く" :sample "Eight tools enable user interaction, task management, and plan-based workflows (see Task Mgmt, User Input, Planning, and Completion categories in Table 1).")
(defrule user-interaction-overview/a1 -> :instruction "この道具が確保することを 1 文で書く" :sample "They form the human-in-the-loop backbone of the system, ensuring the agent can gather requirements, report progress, and obtain approval at critical decision points.")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule user-interaction-plan-outcomes -> :nucleus user-interaction-plan-outcomes/n :elaboration-set-member user-interaction-plan-outcomes/a1 :elaboration-additional user-interaction-plan-outcomes/a2)
(defrule user-interaction-plan-outcomes/n -> :instruction "計画の承認の結果の選択肢を 1 文で書く" :sample "The user responds with one of three outcomes:")
(defrule user-interaction-plan-outcomes/a1 -> :instruction "選択肢を 1 項目ずつ書く" :sample "approve_auto: Approve the plan and auto-approve all subsequent edits that implement it, minimizing approval friction for trusted plans. / approve: Approve the plan but review each individual edit during implementation, maintaining fine-grained control. / modify: Reject with feedback, providing specific changes the agent should incorporate before re-presenting." :kind bullet)
(defrule user-interaction-plan-outcomes/a2 -> :instruction "承認後の計画の取り込みを 1 文で書く" :sample "On approval, plan steps are automatically extracted into the todo list, creating a structured execution tracker that the agent uses to methodically implement each step and report progress.")
(defrule user-interaction-completion-signal -> :nucleus user-interaction-completion-signal/n :elaboration-additional user-interaction-completion-signal/a1)
(defrule user-interaction-completion-signal/n -> :instruction "完了の合図が果たす構造上の役割を 1 文で書く" :sample "This tool serves a critical architectural role: it gives the ReAct executor a structured termination signal, distinguishing intentional completion from iteration exhaustion (hitting the maximum iteration limit).")
(defrule user-interaction-completion-signal/a1 -> :instruction "この道具が無い場合の問題を 1 文で書く" :sample "Without this tool, the agent would either loop until cut off or produce an unstructured final message, making it difficult for the system to determine whether the task was actually completed.")
(defrule user-interaction-design-evolution -> :nucleus user-interaction-design-evolution/n)
(defrule user-interaction-design-evolution/n -> :instruction "初期の版で利用者との対話がどうだったかを 1 文で書く" :sample "Early versions lacked structured user interaction; the agent output free-text questions that were difficult to parse reliably.")
