;;; subject: claude-agent-sdk-agent-loop 5.3 Permission mode: the setting that decides whether the agent asks for approval before using a tool, the modes, and which to pick for which use
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-permission-mode
;;; members: p-permission-mode-what p-permission-mode-advice (modes: each is one copy of agent-loop.mode.lisp)
;;; children: each mode is one copy of agent-loop.mode.lisp
;;; elsewhere: none
;;; left-out: none
(defrule permission-mode -> p-permission-mode-what modes p-permission-mode-advice)
(defrule p-permission-mode-what -> :nucleus p-permission-mode-what/n)
(defrule p-permission-mode-what/n -> :instruction "この設定の名前と、それが何を制御するかを 1 文で書く" :sample "The permission mode option (permission_mode in Python, permissionMode in TypeScript) controls whether the agent asks for approval before using tools:")
(defrule modes -> :instruction "モードを、1 行に 1 つモードの名前で挙げる" :frame "agent-loop.mode.lisp")
(defrule p-permission-mode-advice -> :nucleus p-permission-mode-advice/n :elaboration-additional p-permission-mode-advice/accept :elaboration-additional p-permission-mode-advice/bypass)
(defrule p-permission-mode-advice/n -> :instruction "対話する応用に向くモードを 1 文で書く" :sample "For interactive applications, use \"default\" with a tool approval callback to surface approval prompts.")
(defrule p-permission-mode-advice/accept -> :instruction "開発機で自動で動かす応用に向くモードを 1 文で書く" :sample "For autonomous agents on a dev machine, \"acceptEdits\" auto-approves file edits and common filesystem commands while still gating other Bash commands behind allow rules.")
(defrule p-permission-mode-advice/bypass -> :instruction "承認を全部飛ばすモードを使ってよい場所を 1 文で書く" :sample "Reserve \"bypassPermissions\" for CI, containers, or other isolated environments.")
