;;; one role a model plays in the harness: the work it takes, what it makes possible, and which model it falls back to
;;; roles: claude-doc: - (one model option) / opendev: opendev.agent-core.model-role.lisp
(defrule model-role -> :nucleus model-role/role)
(defrule model-role/role -> :instruction "役割の名前、受け持つ仕事、可能にすること、専用のモデルが無いときの代わりの先を、この順に書く" :sample "Thinking model: Optional model for extended reasoning without tool access. Enables focus on strategic planning without tool-calling pressure. Fallback: action model.")
