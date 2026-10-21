;;; subject: opendev-terminal-agent-2603 2.5.3 Configuration: the four tiers of settings, each overriding the one below it, and how the context limit follows from the chosen model
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / p-config-tiers p-config-precedence p-context-limit-derived
;;; members: none
;;; moved into design-decision items: p-config-tiers (a hierarchy of settings); p-config-precedence (which tier wins, loaded once); p-context-limit-derived (the context limit follows the model)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp), tier-list (each item one copy of opendev.persistence.tier.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule configuration -> decisions tier-list)
(defrule decisions -> :instruction "設定で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。設定の階層、優先の順、上限をモデルから決めることのうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule tier-list -> :instruction "階層を、1 行に 1 つ階層の名前で挙げる" :frame "opendev.persistence.tier.lisp")
