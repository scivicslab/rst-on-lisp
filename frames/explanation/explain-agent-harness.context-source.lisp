;;; one source that fills the model's context: its name, when it is loaded, and how much it costs
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule context-source -> :nucleus context-source/named :elaboration-additional context-source/loaded :elaboration-additional context-source/cost)
(defrule context-source/named -> :instruction "文脈を使うものの名前を書く" :sample "Conversation history")
(defrule context-source/loaded -> :instruction "それがいつ読み込まれるかを書く" :sample "Session start, via settingSources")
(defrule context-source/cost -> :instruction "それが文脈をどれだけ、どのように使うかを書く" :sample "Short summaries; full content loads only when invoked")
