;;; subject: opendev-terminal-agent-2603 2.2.5 Workload-Optimized Multi-Model Architecture: why different kinds of work use different models, which model roles exist and what each falls back to, and how the clients and capability data are loaded
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / p-why-multi-model p-model-role-intro p-client-init-and-cache
;;; members: roles
;;; moved into design-decision items: p-why-multi-model (task-specific routing of models); p-client-init-and-cache (lazy client start, capability cache)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp), role-list (each item one copy of opendev.agent-core.model-role.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule multi-model -> decisions multi-model-roles role-list)
(defrule decisions -> :instruction "モデルの使い分けで下した設計の決定を、1 行に 1 つ決定の名前で挙げる。仕事の種類ごとの振り分け、クライアントの遅延初期化、能力の情報の保管のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule multi-model-roles -> :instruction "仕事の種類の数と、専用のモデルへの振り分けを 1 文で書く" :sample "Five distinct workload categories route to specialized models:")
(defrule role-list -> :instruction "モデルの役割を、1 行に 1 つ役割の名前で挙げる" :frame "opendev.agent-core.model-role.lisp")
