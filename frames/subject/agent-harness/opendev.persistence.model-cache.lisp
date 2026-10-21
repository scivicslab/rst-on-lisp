;;; subject: opendev-terminal-agent-2603 2.5.4 Provider and Model Cache: how model facts fetched from an external catalog are cached on disk with a 24-hour stale-while-revalidate rule so the agent can start offline
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / p-model-catalog p-cache-refresh p-cache-overrides
;;; members: none
;;; moved into design-decision items: p-model-catalog (fetch from a catalog and cache); p-cache-refresh (stale-while-revalidate); p-cache-overrides (populating without network)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp)
;;; elsewhere: none
;;; left-out: the closing paragraph of the section (p-bridge-to-discussion), which looks back over the architecture and states no property of the cache
(defrule model-cache -> decisions)
(defrule decisions -> :instruction "モデルの情報の保管で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。外部の一覧からの取得、更新の規則、ネットワーク無しでの用意のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
