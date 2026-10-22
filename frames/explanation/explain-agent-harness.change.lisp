;;; one change of design the harness's authors made after something failed: the earlier design, the problem it caused, what replaced it, and what the change brought
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule change -> :nucleus change/before :example change/problem :elaboration-process-step change/after :result change/effect)
(defrule change/before -> :instruction "以前の設計が何をどう行っていたかを 1 文で書く" :sample "Early versions stored full tool output in the conversation history regardless of length.")
(defrule change/problem -> :instruction "その設計が招いた問題を、具体的な数や場面で 1 文で書く" :sample "A single long-running test suite could consume 30,000 tokens of context in one tool call.")
(defrule change/after -> :instruction "置き換えた設計、または足した仕組みを 1 文で書く" :sample "The per-tool summarizer reduced this to under 100 tokens in most cases.")
(defrule change/effect -> :instruction "変更の効果を、変更前後の値で比べて書く。値が書かれていなければ空にする" :sample "extending typical session length from 15–20 turns (before context overflow) to 30–40 turns without compaction.")
