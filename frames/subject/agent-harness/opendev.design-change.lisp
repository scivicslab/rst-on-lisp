;;; one change of design the authors made after something failed: the earlier design, the problem it caused, what replaced it, and what the change brought
;;; members: tool-result storage (2.3.2); the others are filled from the paragraphs named "design evolution" or "pivots"
(defrule design-change -> :nucleus design-change/before :example design-change/problem :elaboration-process-step design-change/after :result design-change/effect)
(defrule design-change/before -> :instruction "以前の設計が何をどう行っていたかを 1 文で書く" :sample "Early versions stored full tool output in the conversation history regardless of length.")
(defrule design-change/problem -> :instruction "その設計が招いた問題を、具体的な数や場面で 1 文で書く" :sample "A single long-running test suite could consume 30,000 tokens of context in one tool call.")
(defrule design-change/after -> :instruction "置き換えた設計、または足した仕組みを 1 文で書く" :sample "The per-tool summarizer reduced this to under 100 tokens in most cases.")
(defrule design-change/effect -> :instruction "変更の効果を、変更前後の値で比べて書く。値が書かれていなければ空にする" :sample "extending typical session length from 15–20 turns (before context overflow) to 30–40 turns without compaction.")
