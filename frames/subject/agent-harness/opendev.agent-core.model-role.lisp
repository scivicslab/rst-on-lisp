;;; one model role: its name, what work it takes, what it makes possible, and which model it falls back to
;;; members: Action model, Thinking model, Critique model, Vision model, Compact model
(defrule model-role -> :nucleus model-role/n)
(defrule model-role/n -> :instruction "役割の名前、受け持つ仕事、可能にすること、専用のモデルが無いときの代わりの先を、この順に書く" :sample "Thinking model: Optional model for extended reasoning without tool access. Enables focus on strategic planning without tool-calling pressure. Fallback: action model.")
