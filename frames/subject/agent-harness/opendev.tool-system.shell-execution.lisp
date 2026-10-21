;;; subject: opendev-terminal-agent-2603 2.4.3 Shell Execution and Background Tasks: how shell commands run safely through a staged pipeline, and how long-running processes are moved to the background, listed, read and stopped
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / s13 .. s18
;;; members: overview pipeline background design-evolution
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp)
;;; elsewhere: none
;;; left-out: the caption of Figure 17
(defrule shell-execution -> shell-execution-overview shell-execution-pipeline shell-execution-background tools shell-execution-design-evolution)
(defrule shell-execution-overview -> :nucleus shell-execution-overview/n)
(defrule shell-execution-overview/n -> :instruction "シェルの道具の数と、安全に実行する必要を 1 文で書く" :sample "Four tools handle shell execution and background task management (see Process category in Table 1).")
(defrule shell-execution-pipeline -> :nucleus shell-execution-pipeline/n)
(defrule shell-execution-pipeline/n -> :instruction "命令が通る段階の数と、その名前を挙げて 1 文で書く" :sample "Figure 17 illustrates the pipeline, which processes every shell command through six stages: (1) safety gates that block dangerous patterns with no override, (2) command preparation that auto-confirms package manager prompts and unbuffers Python output, (3) server detection via regex match against 16 framework patterns (Section E.2) that auto-promotes long-running servers to background mode, (4) execution fork between PTY-based background and piped foreground with process-group isolation, (5) output management with 30k-character head-tail truncation and 100ms polling, and (6) timeout handling with 60-second idle and 600-second absolute limits.")
(defrule shell-execution-background -> :nucleus shell-execution-background/n :elaboration-additional shell-execution-background/a1 :elaboration-additional shell-execution-background/a2)
(defrule shell-execution-background/n -> :instruction "背景へ移した命令の登録を 1 文で書く" :sample "Commands promoted to background are registered with the BackgroundTaskManager, which assigns 7-character hex IDs (from uuid4().hex[:7], providing ∼268M unique values).")
(defrule shell-execution-background/a1 -> :instruction "登録で作るもの、書き出し先、監視の仕組みを 1 文で書く" :sample "Registration creates the task record, opens an output file at /tmp/opendev/{sanitized-dir}/tasks/{id}.output, writes any initial startup output captured during the first 20 seconds, and spawns a daemon thread that continuously streams PTY output to the file via select.select() polling.")
(defrule shell-execution-background/a2 -> :instruction "処理の状態の遷移を 1 文で書く" :sample "Tasks transition through four states: RUNNING → COMPLETED (exit code 0), FAILED (non-zero exit), or KILLED (via signal).")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule shell-execution-design-evolution -> :nucleus shell-execution-design-evolution/n :elaboration-additional shell-execution-design-evolution/a1)
(defrule shell-execution-design-evolution/n -> :instruction "最初の実装の方式と、その問題を 1 文で書く" :sample "The initial implementation used subprocess.run() with a fixed timeout.")
(defrule shell-execution-design-evolution/a1 -> :instruction "解決した方法を 1 文で書く" :sample "Activity-based idle timeout solved the server problem, and PTY-based execution solved output buffering issues where programs would produce no visible output until process termination.")
