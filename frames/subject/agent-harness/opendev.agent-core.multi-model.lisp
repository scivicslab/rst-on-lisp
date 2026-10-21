;;; subject: opendev-terminal-agent-2603 2.2.5 Workload-Optimized Multi-Model Architecture: why different kinds of work use different models, which model roles exist and what each falls back to, and how the clients and capability data are loaded
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / p-why-multi-model p-model-role-intro p-client-init-and-cache
;;; members: why roles clients
;;; children (:include / :frame, in the text's order): role-list (each item one copy of opendev.agent-core.model-role.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule multi-model -> multi-model-why multi-model-roles role-list multi-model-clients)
(defrule multi-model-why -> :nucleus multi-model-why/phases-differ :reason multi-model-why/single-model :comparison multi-model-why/options)
(defrule multi-model-why/phases-differ -> :instruction "仕事の段階ごとに必要なモデルの能力が違うことを 1 文で書く" :sample "A core realization of the compound AI systems paradigm [100] is that different execution phases benefit from different model capabilities.")
(defrule multi-model-why/single-model -> :instruction "1 つのモデルで全部をまかなう場合の損を 1 文で書く" :sample "Using a single model for all tasks either wastes cost (using expensive models for simple tasks) or sacrifices quality (using cheap models for complex reasoning).")
(defrule multi-model-why/options -> :instruction "検討した方式と、採った方式を 1 文で書く" :sample "Three approaches were considered: a single model for everything (simple but inflexible), task-specific routing (adopted here, which introduces complexity in selection logic but enables workload optimization), and ensemble execution (maximum quality but prohibitive latency and cost).")
(defrule multi-model-roles -> :instruction "仕事の種類の数と、専用のモデルへの振り分けを 1 文で書く" :sample "Five distinct workload categories route to specialized models:")
(defrule role-list -> :instruction "モデルの役割を、1 行に 1 つ役割の名前で挙げる" :frame "opendev.agent-core.model-role.lisp")
(defrule multi-model-clients -> :nucleus multi-model-clients/lazy :elaboration-additional multi-model-clients/capabilities :evaluation-s multi-model-clients/tradeoff)
(defrule multi-model-clients/lazy -> :instruction "モデルを選ぶと何が遅延して初期化されるかを 1 文で書く" :sample "Each model selection triggers lazy initialization of provider-specific API clients, reducing startup latency, as only models actually used in a session are initialized.")
(defrule multi-model-clients/capabilities -> :instruction "モデルの能力の情報の持ち方と更新の仕方を 1 文で書く" :sample "Model capabilities (context length, vision support, reasoning features) are cached locally with time-to-live refresh, enabling offline startup and background updates following a stale-while-revalidate pattern.")
(defrule multi-model-clients/tradeoff -> :instruction "その保管が引き換えにするものを 1 文で書く" :sample "The cache trades potential staleness for startup reliability, with background refresh ensuring eventual consistency.")
