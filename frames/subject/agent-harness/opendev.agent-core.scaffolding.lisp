;;; subject: opendev-terminal-agent-2603 2.2.1 Agent Scaffolding: how every agent is assembled completely before it serves a prompt: the design decisions about types, construction time and entry point, the ordered phases of the factory, and the services handed to the agents
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / p-assembled-before-prompts p-agent-factory p-factory-skills-phase p-factory-subagents-phase p-factory-main-agent-phase p-phase-order-constraint p-subagent-compilation
;;; members: assembled phase-order pipeline
;;; moved into design-decision items: p-base-agent (eager construction), p-single-agent-class (type hierarchy of agents), p-agent-factory (single construction entry point), p-runtime-services (services carried to tools, and the lighter set for subagents), p-subagent-compilation (isolation of subagents), p-scaffolding-pivots (what each earlier design was replaced by)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp), phases (each item one copy of opendev.agent-core.factory-phase.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule scaffolding -> scaffolding-assembled decisions phases scaffolding-phase-order scaffolding-pipeline)
(defrule scaffolding-assembled -> :instruction "プロンプトを処理する前に、何を組み上げ終えるかを 1 文で書く" :sample "Before the agent can process user prompts, it must be fully assembled.")
(defrule decisions -> :instruction "エージェントの組み立てで下した設計の決定を、1 行に 1 つ決定の名前で挙げる。エージェントの型の階層、構築の時点、構築の入口、実行時の部品の渡し方、部下の分離、設計を改めた経緯のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule phases -> :instruction "工場が踏む段階を、踏む順に、1 行に 1 つ段階の名前で挙げる" :frame "opendev.agent-core.factory-phase.lisp")
(defrule scaffolding-phase-order -> :nucleus scaffolding-phase-order/constraint :reason scaffolding-phase-order/because)
(defrule scaffolding-phase-order/constraint -> :instruction "段階の順序に必須の制約があるかを 1 文で書く" :sample "The ordering constraint is essential: Phase 2 must complete before Phase 3")
(defrule scaffolding-phase-order/because -> :instruction "その制約の理由を 1 文で書く" :sample "because the spawn_subagent tool description is dynamically built from the set of registered agents, and it must be present in the main agent’s schema.")
(defrule scaffolding-pipeline -> :instruction "部下を登録する手順を、順に 1 文で書く" :sample "When SubAgentManager.register_subagent(spec) is called, it executes a four-step pipeline: (1) resolve the tool list, defaulting to a hardcoded set of safe tools if none is specified; (2) create an AppConfig copy with the model override if one is provided; (3) construct a MainAgent with allowed_tools set to the resolved list, triggering the eager build of a filtered system prompt and tool schema; and (4) set agent._subagent_system_prompt to the spec’s prompt override.")
