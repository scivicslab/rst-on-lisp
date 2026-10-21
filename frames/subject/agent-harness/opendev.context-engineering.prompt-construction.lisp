;;; subject: opendev-terminal-agent-2603 2.3.1 Dynamic System Prompt Construction: how the system prompt is put together at start-up from sections by a composer, and the design decisions about loading, modes, placeholders, providers, caching and fallbacks
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / p-prompt-is-control p-prompt-pipeline
;;; members: control pipeline
;;; moved into design-decision items: p-monolithic-prompt-costs (context-sensitive loading of sections), p-prompt-tiers and p-mode-specific-prompts (separate prompts per reasoning mode), p-template-variables (placeholders resolved by a registry), p-provider-sections (provider-specific sections), p-prompt-caching (a stable part and a dynamic part), p-prompt-fallbacks (what happens when sections are missing)
;;; children (:include / :frame, in the text's order): composer-steps (each item one copy of opendev.context-engineering.composer-step.lisp), decisions (each item one copy of opendev.design-decision.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule prompt-construction -> prompt-construction-control prompt-construction-pipeline composer-steps decisions)
(defrule prompt-construction-control -> :instruction "指示文が振る舞いの制御で果たす役割を 1 文で書く" :sample "In an LLM-based agent, the system prompt is the primary instrument of behavioral control: it encodes the agent’s identity, capability boundaries, safety constraints, and task conventions.")
(defrule prompt-construction-pipeline -> :instruction "指示文を実行時に組み立てる流れと、節が持つ付随情報を 1 文で書く" :sample "OpenDev assembles each agent’s system prompt at runtime through the pipeline illustrated in Figure 10.")
(defrule composer-steps -> :instruction "組み立て役の段階を、行う順に、1 行に 1 つ段階の名前で挙げる" :frame "opendev.context-engineering.composer-step.lisp")
(defrule decisions -> :instruction "指示文の組み立てで下した設計の決定を、1 行に 1 つ決定の名前で挙げる。節の読み込みの条件、モードごとの指示文、雛形の置換、提供元ごとの節、入力の保存への対応、節が欠けたときの扱いのうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
