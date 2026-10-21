;;; one source that fills the context window: its name, when it loads, and how much it costs
;;; members: system prompt, CLAUDE.md files, tool definitions, conversation history, skill descriptions
(defrule context-source -> :nucleus context-source/n :elaboration-additional context-source/when :elaboration-additional context-source/impact)
(defrule context-source/n -> :instruction "文脈を使うものの名前を書く" :sample "Conversation history")
(defrule context-source/when -> :instruction "それがいつ読み込まれるかを書く" :sample "Session start, via settingSources")
(defrule context-source/impact -> :instruction "それが文脈をどれだけ、どのように使うかを書く" :sample "Short summaries; full content loads only when invoked")
