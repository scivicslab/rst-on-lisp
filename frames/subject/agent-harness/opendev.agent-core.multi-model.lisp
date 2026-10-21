;;; subject: opendev-terminal-agent-2603 2.2.5 Workload-Optimized Multi-Model Architecture: why different phases of work use different models, which model roles exist and what each falls back to, and how clients are started
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / s34 .. s36
;;; members: idea roles-intro clients
;;; children (:include / :frame, in the text's order): roles (each item one copy of opendev.agent-core.model-role.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule multi-model -> multi-model-idea multi-model-roles-intro roles multi-model-clients)
(defrule multi-model-idea -> :nucleus multi-model-idea/n :elaboration-additional multi-model-idea/a1 :elaboration-additional multi-model-idea/a2 :elaboration-additional multi-model-idea/a3 :elaboration-additional multi-model-idea/a4 :elaboration-additional multi-model-idea/a5)
(defrule multi-model-idea/n -> :instruction "段階ごとに必要なモデルの能力が違うという考えを 1 文で書く" :sample "A core realization of the compound AI systems paradigm [100] is that different execution phases benefit from different model capabilities.")
(defrule multi-model-idea/a1 -> :instruction "推論に向く条件を 1 文で書く" :sample "Reasoning tasks benefit from extended thinking without tool distraction.")
(defrule multi-model-idea/a2 -> :instruction "視覚の仕事に必要なモデルを 1 文で書く" :sample "Visual tasks require vision-language models.")
(defrule multi-model-idea/a3 -> :instruction "要約に向くモデルを 1 文で書く" :sample "Bulk summarization benefits from cheaper, faster models.")
(defrule multi-model-idea/a4 -> :instruction "1 つのモデルで全部をまかなう場合の損を 1 文で書く" :sample "Using a single model for all tasks either wastes cost (using expensive models for simple tasks) or sacrifices quality (using cheap models for complex reasoning).")
(defrule multi-model-idea/a5 -> :instruction "検討した三つの方式と、採った方式を 1 文で書く" :sample "Three approaches were considered: a single model for everything (simple but inflexible), task-specific routing (adopted here, which introduces complexity in selection logic but enables workload optimization), and ensemble execution (maximum quality but prohibitive latency and cost).")
(defrule multi-model-roles-intro -> :nucleus multi-model-roles-intro/n)
(defrule multi-model-roles-intro/n -> :instruction "仕事の種類の数と、それが専用のモデルへ振り分けられることを 1 文で書く" :sample "Five distinct workload categories route to specialized models:")
(defrule roles -> :instruction "モデルの役割を、1 行に 1 つ役割の名前で挙げる" :frame "opendev.agent-core.model-role.lisp")
(defrule multi-model-clients -> :nucleus multi-model-clients/n :elaboration-additional multi-model-clients/a1 :elaboration-additional multi-model-clients/a2)
(defrule multi-model-clients/n -> :instruction "モデルを選ぶと何が遅延して初期化されるかを 1 文で書く" :sample "Each model selection triggers lazy initialization of provider-specific API clients, reducing startup latency, as only models actually used in a session are initialized.")
(defrule multi-model-clients/a1 -> :instruction "モデルの能力の情報の持ち方と更新の仕方を 1 文で書く" :sample "Model capabilities (context length, vision support, reasoning features) are cached locally with time-to-live refresh, enabling offline startup and background updates following a stale-while-revalidate pattern.")
(defrule multi-model-clients/a2 -> :instruction "この保管が引き換えにするものを 1 文で書く" :sample "The cache trades potential staleness for startup reliability, with background refresh ensuring eventual consistency.")
