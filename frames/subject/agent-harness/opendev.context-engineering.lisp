;;; subject: opendev-terminal-agent-2603 2.3 Context Engineering Layer: the mechanisms that decide what the model sees at each step, from the system prompt to the compaction of a growing conversation
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / p-context-layer-defined p-context-layer-flow
;;; members: quality flow
;;; children (:include / :frame, in the text's order): prompt-construction opendev.context-engineering.prompt-construction.lisp, tool-result opendev.context-engineering.tool-result.lisp, dual-memory opendev.context-engineering.dual-memory.lisp, reminders opendev.context-engineering.reminders.lisp, error-recovery opendev.context-engineering.error-recovery.lisp, compaction opendev.context-engineering.compaction.lisp, retrieval opendev.context-engineering.retrieval.lisp
;;; elsewhere: none
;;; left-out: the caption of Figure 9
(defrule context-engineering -> context-engineering-quality context-engineering-flow prompt-construction tool-result dual-memory reminders error-recovery compaction retrieval)
(defrule context-engineering-quality -> :nucleus context-engineering-quality/visible-context :definition context-engineering-quality/named)
(defrule context-engineering-quality/visible-context -> :instruction "応答の質が何で決まるかを 1 文で書く" :sample "The quality of every response is determined primarily by what the model is allowed to see in its context window: which instructions it receives, how much conversation history is retained, what it has learned from prior interactions, and how relevant external information is assembled before each call [53, 36, 98].")
(defrule context-engineering-quality/named -> :instruction "この仕組みの集まりの名前を 1 文で定義する" :sample "We refer to the set of mechanisms that manage this window collectively as the Context Engineering Layer [53, 36, 98].")
(defrule context-engineering-flow -> :instruction "部品とその関わりを図で示すと書く" :sample "Figure 9 shows the subsystems and their interactions.")
(defrule prompt-construction -> :instruction "役割と制約を述べる指示文の組み立てを説明する" :include "opendev.context-engineering.prompt-construction.lisp" :heading "### Dynamic system prompt construction")
(defrule tool-result -> :instruction "道具の出力を文脈に入れる前に縮める仕組みを説明する" :include "opendev.context-engineering.tool-result.lisp" :heading "### Tool result optimization")
(defrule dual-memory -> :instruction "考える段階に渡す履歴を一定の大きさに保つ仕組みを説明する" :include "opendev.context-engineering.dual-memory.lisp" :heading "### Dual-memory architecture for bounded thinking")
(defrule reminders -> :instruction "長い実行で指示が薄れることへの対策を説明する" :include "opendev.context-engineering.reminders.lisp" :heading "### Context-aware system reminders")
(defrule error-recovery -> :instruction "道具の失敗に回復の手引きを添える仕組みを説明する" :include "opendev.context-engineering.error-recovery.lisp" :heading "### Context-injected error recovery")
(defrule compaction -> :instruction "文脈が一杯になる前に段階的に縮める仕組みを説明する" :include "opendev.context-engineering.compaction.lisp" :heading "### Adaptive context compaction")
(defrule retrieval -> :instruction "必要なコードを探し、文脈に組み上げる流れを説明する" :include "opendev.context-engineering.retrieval.lisp" :heading "### Context retrieval and assembly pipeline")
