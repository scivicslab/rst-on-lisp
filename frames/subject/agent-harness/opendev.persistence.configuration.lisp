;;; subject: opendev-terminal-agent-2603 2.5.3 Configuration: the four tiers of settings, each overriding the one below it, and how the context limit follows from the chosen model
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / p-config-tiers p-config-precedence p-context-limit-derived
;;; members: tiers precedence limit
;;; children (:include / :frame, in the text's order): tier-list (each item one copy of opendev.persistence.tier.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule configuration -> configuration-tiers tier-list configuration-precedence configuration-limit)
(defrule configuration-tiers -> :instruction "設定が階層を成す狙いを 1 文で書く" :sample "Configuration follows a four-tier hierarchy designed so that users get reasonable behavior out of the box but can customize anything at the right scope:")
(defrule tier-list -> :instruction "階層を、1 行に 1 つ階層の名前で挙げる" :frame "opendev.persistence.tier.lisp")
(defrule configuration-precedence -> :instruction "どの階層が優先されるかを 1 文で書く" :sample "Each tier overrides the one above it: project settings take precedence over user-global settings, which take precedence over environment variables, which take precedence over built-in defaults.")
(defrule configuration-limit -> :nucleus configuration-limit/derived :result configuration-limit/no-mismatch)
(defrule configuration-limit/derived -> :instruction "上限を利用者の設定ではなく、モデルの能力から決めることを 1 文で書く" :sample "Context window limits are derived automatically from model capabilities rather than requiring explicit configuration.")
(defrule configuration-limit/no-mismatch -> :instruction "その方式が避ける誤設定を 1 文で書く" :sample "This avoids a common source of misconfiguration where users set a context limit that does not match their model’s actual capacity.")
