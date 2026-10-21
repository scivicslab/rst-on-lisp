;;; subject: opendev-terminal-agent-2603 2.4.3 Shell Execution and Background Tasks: how shell commands run safely through a staged pipeline, and how long-running processes are moved to the background, listed, read and stopped
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-shell-tools p-shell-pipeline p-background-tasks p-list-processes p-get-process-output p-kill-process p-shell-evolution
;;; members: overview pipeline background
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: the caption of Figure 17
(defrule shell-execution -> shell-execution-overview shell-execution-pipeline shell-execution-background tools changes)
(defrule shell-execution-overview -> :nucleus shell-execution-overview/four :reason shell-execution-overview/rationale)
(defrule shell-execution-overview/four -> :instruction "シェルの道具の数を 1 文で書く" :sample "Four tools handle shell execution and background task management (see Process category in Table 1).")
(defrule shell-execution-overview/rationale -> :instruction "安全に実行し、背景でも動かす必要を 1 文で書く" :sample "The agent needs to run arbitrary shell commands for testing, building, and system interaction, but must do so safely; long-running processes like development servers require background execution with output capture.")
(defrule shell-execution-pipeline -> :instruction "命令が通る段階の数と名前を 1 文で書く" :sample "Figure 17 illustrates the pipeline, which processes every shell command through six stages: (1) safety gates that block dangerous patterns with no override, (2) command preparation that auto-confirms package manager prompts and unbuffers Python output, (3) server detection via regex match against 16 framework patterns (Section E.2) that auto-promotes long-running servers to background mode, (4) execution fork between PTY-based background and piped foreground with process-group isolation, (5) output management with 30k-character head-tail truncation and 100ms polling, and (6) timeout handling with 60-second idle and 600-second absolute limits.")
(defrule shell-execution-background -> :nucleus shell-execution-background/registered :elaboration-part-whole shell-execution-background/states)
(defrule shell-execution-background/registered -> :instruction "背景へ移した命令の登録を 1 文で書く" :sample "Commands promoted to background are registered with the BackgroundTaskManager, which assigns 7-character hex IDs (from uuid4().hex[:7], providing ∼268M unique values).")
(defrule shell-execution-background/states -> :instruction "処理の状態の遷移を 1 文で書く" :sample "Tasks transition through four states: RUNNING → COMPLETED (exit code 0), FAILED (non-zero exit), or KILLED (via signal).")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule changes -> :instruction "シェルの扱いが経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
