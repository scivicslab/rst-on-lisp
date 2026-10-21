;;; one source that fills the model's context: its name, when it is loaded, and how much it costs
;;; roles: claude-doc: agent-loop.context-source.lisp / opendev: the six ordered sources of p-context-assembly and the tiers of p-prompt-tiers
(defrule context-source -> :nucleus context-source/named :elaboration-additional context-source/loaded :elaboration-additional context-source/cost)
(defrule context-source/named -> :instruction "文脈を使うものの名前を書く" :sample "Conversation history")
(defrule context-source/loaded -> :instruction "それがいつ読み込まれるかを書く" :sample "Session start, via settingSources")
(defrule context-source/cost -> :instruction "それが文脈をどれだけ、どのように使うかを書く" :sample "Short summaries; full content loads only when invoked")
