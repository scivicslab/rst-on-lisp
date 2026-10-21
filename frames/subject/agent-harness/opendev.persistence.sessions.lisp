;;; subject: opendev-terminal-agent-2603 2.5.1 Session Storage: how one conversation is stored as a metadata file and a transcript, written safely, saved automatically, indexed, titled and resumed
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/05_persistence/05_persistence.lisp / p-session-files p-safe-write p-auto-save p-session-index p-session-titles p-cost-metadata p-legacy-migration
;;; members: files safe-write auto-save index titles cost
;;; children (:include / :frame, in the text's order): changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule sessions -> sessions-files sessions-safe-write sessions-auto-save sessions-index sessions-titles sessions-cost changes)
(defrule sessions-files -> :nucleus sessions-files/two :purpose sessions-files/split)
(defrule sessions-files/two -> :instruction "1 つの会話を保存するファイルの組を 1 文で書く" :sample "Each conversation is stored as two files: a .json metadata file and a .jsonl transcript file.")
(defrule sessions-files/split -> :instruction "分ける狙いを 1 文で書く" :sample "Splitting metadata from messages means that listing all sessions (to show the user a session picker) requires reading only the small metadata files rather than loading potentially large transcript histories.")
(defrule sessions-safe-write -> :nucleus sessions-safe-write/flow :reason sessions-safe-write/atomic)
(defrule sessions-safe-write/flow -> :instruction "同時に書かれても失われない書き込みの手順を 1 文で書く" :sample "Sessions are saved through a write flow designed to prevent data loss even under concurrent access.")
(defrule sessions-safe-write/atomic -> :instruction "置き換えが途中の状態を残さない理由を 1 文で書く" :sample "which on POSIX systems guarantees that the file is either fully written or untouched, never half-written.")
(defrule sessions-auto-save -> :nucleus sessions-auto-save/interval :comparison sessions-auto-save/append-only)
(defrule sessions-auto-save/interval -> :instruction "自動保存の間隔を 1 文で書く" :sample "Rather than requiring explicit save commands, the system auto-saves the conversation every 5 turns (configurable via auto_save_interval).")
(defrule sessions-auto-save/append-only -> :instruction "別の経路の保存の仕方を 1 文で書く。無ければ空にする" :sample "For multi-channel deployments (such as a web interface), a separate append-only path writes each new message individually to the transcript file under an exclusive lock, providing immediate durability at the cost of one file-system call per message.")
(defrule sessions-index -> :nucleus sessions-index/cached :evaluation-s sessions-index/self-healing)
(defrule sessions-index/cached -> :instruction "一覧のために軽い索引を持つ仕組みを 1 文で書く" :sample "A lightweight index file (sessions-index.json) caches the essential fields (session ID, title, message count, last-modified timestamp) at roughly 200 bytes per entry, enabling instant session listing.")
(defrule sessions-index/self-healing -> :instruction "索引が壊れても使い続けられる理由を 1 文で書く" :sample "This self-healing behavior means the index never becomes a single point of failure: even if the file is accidentally deleted or corrupted, the next list_sessions call regenerates it transparently.")
(defrule sessions-titles -> :nucleus sessions-titles/generated :elaboration-additional sessions-titles/default)
(defrule sessions-titles/generated -> :instruction "会話の題の作り方を 1 文で書く" :sample "A lightweight topic-detection model generates a short title (capped at 50 characters) by examining the last 4 messages.")
(defrule sessions-titles/default -> :instruction "指定が無いときに開く会話を 1 文で書く" :sample "When the user starts the agent in a project directory without specifying a session, the system defaults to the most recent session for that project, enabling a “continue where I left off” workflow.")
(defrule sessions-cost -> :instruction "会話の費用を記録する項目を 1 文で書く" :sample "Each session’s metadata file includes a cost_tracking object that records cumulative API usage: total input tokens, total output tokens, total cost in USD (computed from model pricing metadata), and the number of API calls.")
(defrule changes -> :instruction "保存の形式が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
