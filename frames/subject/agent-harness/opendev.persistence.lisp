;;; subject: opendev-terminal-agent-2603 2.5 Persistence Layer: what the agent keeps on disk across runs and where: sessions, an operation log for undo, configuration, and a cache of model facts, all as ordinary files
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / s1
;;; members: files roots
;;; children (:include / :frame, in the text's order): sessions opendev.persistence.sessions.lisp, operation-log opendev.persistence.operation-log.lisp, configuration opendev.persistence.configuration.lisp, model-cache opendev.persistence.model-cache.lisp
;;; elsewhere: none
;;; left-out: none
(defrule persistence -> persistence-files persistence-roots sessions operation-log configuration model-cache)
(defrule persistence-files -> :nucleus persistence-files/n :elaboration-additional persistence-files/a1)
(defrule persistence-files/n -> :instruction "この層が何を、どんな形式のファイルで保存するかを 1 文で書く" :sample "The persistence layer stores conversation histories, configuration, model metadata, and file-operation logs using ordinary files on disk: JSON for structured data, JSONL (one JSON object per line) for append-heavy streams, and plain text where simplicity matters.")
(defrule persistence-files/a1 -> :instruction "外部の記憶装置を要らないことを 1 文で書く" :sample "No external database is required.")
(defrule persistence-roots -> :nucleus persistence-roots/n :elaboration-additional persistence-roots/a1 :elaboration-additional persistence-roots/a2)
(defrule persistence-roots/n -> :instruction "保存する状態が二つの根の下にあることを 1 文で書く" :sample "All persistent state lives under two root directories.")
(defrule persistence-roots/a1 -> :instruction "利用者全体の状態と、案件ごとの状態の置き場を 1 文で書く" :sample "Project-scoped state (session transcripts, project-specific settings) goes to a subdirectory derived from the project path: ~/.opendev/projects/{encoded-path}/, where the project’s absolute path is encoded by replacing path separators with dashes (e.g., /Users/alice/myapp becomes -Users-alice-myapp).")
(defrule persistence-roots/a2 -> :instruction "この分け方で保たれることを 1 文で書く" :sample "This separation ensures that conversations about one repository never appear alongside conversations about another, and that project-specific settings do not leak across unrelated codebases.")
(defrule sessions -> :instruction "会話の保存の形式、保存の手順、一覧、題を説明する" :include "opendev.persistence.sessions.lisp" :heading "### Session storage")
(defrule operation-log -> :instruction "ファイル操作の記録と、取り消しの仕組みを説明する" :include "opendev.persistence.operation-log.lisp" :heading "### Operation log and undo")
(defrule configuration -> :instruction "設定を重ねる階層と、その決まりを説明する" :include "opendev.persistence.configuration.lisp" :heading "### Configuration")
(defrule model-cache -> :instruction "モデルの能力の情報の保管と更新を説明する" :include "opendev.persistence.model-cache.lisp" :heading "### Provider and model cache")
