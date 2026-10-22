;;; one role a model plays in the harness: the work it takes, what it makes possible, and which model it falls back to
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule model-role -> :nucleus model-role/role)
(defrule model-role/role -> :instruction "役割の名前、受け持つ仕事、可能にすること、専用のモデルが無いときの代わりの先を、この順に書く" :sample "Thinking model: Optional model for extended reasoning without tool access. Enables focus on strategic planning without tool-calling pressure. Fallback: action model.")
