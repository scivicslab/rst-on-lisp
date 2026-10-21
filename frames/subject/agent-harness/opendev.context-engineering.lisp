;;; subject: opendev-terminal-agent-2603 2.3 Context Engineering Layer: the mechanisms that decide what the model sees at each step, from the system prompt to the compaction of a growing conversation
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / s1
;;; members: what flow
;;; children (:include / :frame, in the text's order): prompt-construction opendev.context-engineering.prompt-construction.lisp, tool-result opendev.context-engineering.tool-result.lisp, dual-memory opendev.context-engineering.dual-memory.lisp, reminders opendev.context-engineering.reminders.lisp, error-recovery opendev.context-engineering.error-recovery.lisp, compaction opendev.context-engineering.compaction.lisp, retrieval opendev.context-engineering.retrieval.lisp
;;; elsewhere: none
;;; left-out: the caption of Figure 9
(defrule context-engineering -> context-engineering-what context-engineering-flow prompt-construction tool-result dual-memory reminders error-recovery compaction retrieval)
(defrule context-engineering-what -> :nucleus context-engineering-what/n :elaboration-additional context-engineering-what/a1)
(defrule context-engineering-what/n -> :instruction "エージェントの応答の質が何で決まるかを 1 文で書く" :sample "LLM-based agents do not simply send user messages to a model and receive responses.")
(defrule context-engineering-what/a1 -> :instruction "この層の名前と、それが管理するものを 1 文で書く" :sample "We refer to the set of mechanisms that manage this window collectively as the Context Engineering Layer [53, 36, 98].")
(defrule context-engineering-flow -> :nucleus context-engineering-flow/n :elaboration-additional context-engineering-flow/a1)
(defrule context-engineering-flow/n -> :instruction "利用者の問い合わせが文脈の部品をどの順に通るかを 1 文で書く" :sample "Figure 9 shows the subsystems and their interactions.")
(defrule context-engineering-flow/a1 -> :instruction "各部品を取り上げる順を 1 文で書く" :sample "The remainder of this section presents each subsystem in the order it first influences the context window within a session.")
(defrule prompt-construction -> :instruction "役割と制約を述べる指示文の組み立てを説明する" :include "opendev.context-engineering.prompt-construction.lisp" :heading "### Dynamic system prompt construction")
(defrule tool-result -> :instruction "道具の出力を文脈に入れる前に縮める仕組みを説明する" :include "opendev.context-engineering.tool-result.lisp" :heading "### Tool result optimization")
(defrule dual-memory -> :instruction "考える段階に渡す履歴を一定の大きさに保つ仕組みを説明する" :include "opendev.context-engineering.dual-memory.lisp" :heading "### Dual-memory architecture for bounded thinking")
(defrule reminders -> :instruction "長い実行で指示が薄れることへの対策を説明する" :include "opendev.context-engineering.reminders.lisp" :heading "### Context-aware system reminders")
(defrule error-recovery -> :instruction "道具の失敗に回復の手引きを添える仕組みを説明する" :include "opendev.context-engineering.error-recovery.lisp" :heading "### Context-injected error recovery")
(defrule compaction -> :instruction "文脈が一杯になる前に段階的に縮める仕組みを説明する" :include "opendev.context-engineering.compaction.lisp" :heading "### Adaptive context compaction")
(defrule retrieval -> :instruction "必要なコードを探し、文脈に組み上げる流れを説明する" :include "opendev.context-engineering.retrieval.lisp" :heading "### Context retrieval and assembly pipeline")
