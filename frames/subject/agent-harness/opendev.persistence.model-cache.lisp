;;; subject: opendev-terminal-agent-2603 2.5.4 Provider and Model Cache: how model facts fetched from an external catalog are cached on disk with a 24-hour stale-while-revalidate rule so the agent can start offline
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / s12
;;; members: need refresh overrides
;;; elsewhere: none
;;; left-out: the final paragraph, which looks back over the architecture and leads to the discussion (it states no property of the cache)
(defrule model-cache -> model-cache-need model-cache-refresh model-cache-overrides)
(defrule model-cache-need -> :nucleus model-cache-need/n)
(defrule model-cache-need/n -> :instruction "必要なモデルの情報と、外部の一覧から取って保存することを 1 文で書く" :sample "The system needs to know what models are available from each provider, along with their capabilities (context length, vision support, pricing).")
(defrule model-cache-refresh -> :nucleus model-cache-refresh/n :elaboration-additional model-cache-refresh/a1 :elaboration-additional model-cache-refresh/a2 :elaboration-additional model-cache-refresh/a3)
(defrule model-cache-refresh/n -> :instruction "保存の更新の規則を 1 文で書く" :sample "The cache uses a stale-while-revalidate strategy with a 24-hour time-to-live.")
(defrule model-cache-refresh/a1 -> :instruction "更新のときの手順を 1 文で書く" :sample "If it is stale or missing, the system fetches fresh data from the API, transforms it into per-provider JSON files (one file per provider, containing model names, context lengths, capabilities, and pricing), and updates the marker.")
(defrule model-cache-refresh/a2 -> :instruction "取得に失敗したときの扱いを 1 文で書く" :sample "If the network fetch fails, the system falls back to the stale cache if one exists, or proceeds without capability information if no cache is available at all.")
(defrule model-cache-refresh/a3 -> :instruction "この規則が保証することを 1 文で書く" :sample "This ensures that the agent can start even when offline: the cache file from the last successful sync provides enough information to operate normally.")
(defrule model-cache-overrides -> :nucleus model-cache-overrides/n)
(defrule model-cache-overrides/n -> :instruction "ネットワーク無しで保存を満たすための環境の指定を 1 文で書く" :sample "Environment overrides (OPENDEV_MODELS_DEV_PATH for a local catalog file, OPENDEV_DISABLE_REMOTE_MODELS to skip network entirely) allow the cache to be populated without network access, which is useful in air-gapped environments or for testing with a fixed model set.")
