;;; subject: opendev-terminal-agent-2603 2.5.4 Provider and Model Cache: how model facts fetched from an external catalog are cached on disk with a 24-hour stale-while-revalidate rule so the agent can start offline
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / p-model-catalog p-cache-refresh p-cache-overrides
;;; members: need refresh overrides
;;; elsewhere: none
;;; left-out: the closing paragraph of the section (p-bridge-to-discussion), which looks back over the architecture and states no property of the cache
(defrule model-cache -> model-cache-need model-cache-refresh model-cache-overrides)
(defrule model-cache-need -> :background model-cache-need/facts :nucleus model-cache-need/fetch)
(defrule model-cache-need/facts -> :instruction "必要なモデルの情報を 1 文で書く" :sample "The system needs to know what models are available from each provider, along with their capabilities (context length, vision support, pricing).")
(defrule model-cache-need/fetch -> :instruction "外部の一覧から取って保存する方針を 1 文で書く" :sample "Rather than hardcoding this information, OpenDev fetches it from an external catalog API and caches the results locally under ~/.opendev/cache/.")
(defrule model-cache-refresh -> :nucleus model-cache-refresh/rule :result model-cache-refresh/offline)
(defrule model-cache-refresh/rule -> :instruction "更新の規則を 1 文で書く" :sample "The cache uses a stale-while-revalidate strategy with a 24-hour time-to-live.")
(defrule model-cache-refresh/offline -> :instruction "この規則が保証することを 1 文で書く" :sample "This ensures that the agent can start even when offline: the cache file from the last successful sync provides enough information to operate normally.")
(defrule model-cache-overrides -> :instruction "ネットワーク無しで保存を満たすための指定を 1 文で書く" :sample "Environment overrides (OPENDEV_MODELS_DEV_PATH for a local catalog file, OPENDEV_DISABLE_REMOTE_MODELS to skip network entirely) allow the cache to be populated without network access, which is useful in air-gapped environments or for testing with a fixed model set.")
