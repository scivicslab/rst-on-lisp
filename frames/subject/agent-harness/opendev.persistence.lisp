;;; subject: opendev-terminal-agent-2603 2.5 Persistence Layer: what the agent keeps on disk across runs and where: sessions, an operation log for undo, configuration, and a cache of model facts, all as ordinary files
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / p-plain-files p-two-roots
;;; members: files roots
;;; children (:include / :frame, in the text's order): sessions opendev.persistence.sessions.lisp, operation-log opendev.persistence.operation-log.lisp, configuration opendev.persistence.configuration.lisp, model-cache opendev.persistence.model-cache.lisp
;;; elsewhere: none
;;; left-out: none
(defrule persistence -> persistence-files persistence-roots sessions operation-log configuration model-cache)
(defrule persistence-files -> :nucleus persistence-files/ordinary :result persistence-files/no-database)
(defrule persistence-files/ordinary -> :instruction "保存する内容と、その形式を 1 文で書く" :sample "The persistence layer stores conversation histories, configuration, model metadata, and file-operation logs using ordinary files on disk: JSON for structured data, JSONL (one JSON object per line) for append-heavy streams, and plain text where simplicity matters.")
(defrule persistence-files/no-database -> :instruction "外部の記憶装置が要るかを 1 文で書く" :sample "No external database is required.")
(defrule persistence-roots -> :nucleus persistence-roots/two :result persistence-roots/separation)
(defrule persistence-roots/two -> :instruction "保存先の根の数と、案件ごとの分け方を 1 文で書く" :sample "All persistent state lives under two root directories.")
(defrule persistence-roots/separation -> :instruction "その分け方で保たれることを 1 文で書く" :sample "This separation ensures that conversations about one repository never appear alongside conversations about another, and that project-specific settings do not leak across unrelated codebases.")
(defrule sessions -> :instruction "会話の保存の形式、保存の手順、一覧、題を説明する" :include "opendev.persistence.sessions.lisp" :heading "### Session storage")
(defrule operation-log -> :instruction "ファイル操作の記録と、取り消しの仕組みを説明する" :include "opendev.persistence.operation-log.lisp" :heading "### Operation log and undo")
(defrule configuration -> :instruction "設定を重ねる階層と、その決まりを説明する" :include "opendev.persistence.configuration.lisp" :heading "### Configuration")
(defrule model-cache -> :instruction "モデルの能力の情報の保管と更新を説明する" :include "opendev.persistence.model-cache.lisp" :heading "### Provider and model cache")
