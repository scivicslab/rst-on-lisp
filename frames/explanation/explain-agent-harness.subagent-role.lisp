;;; one role of subagent: its name, the tools it gets, and what it is specialised for
;;; roles: claude-doc: - (subagents appear only as a context-saving measure and in the budget) / opendev: opendev.agent-core.subagent-role.lisp
(defrule subagent-role -> :nucleus subagent-role/role)
(defrule subagent-role/role -> :instruction "部下の役割の名前、持たせる道具、向いている仕事を書く" :sample "Code explorer: Read-only tools for codebase navigation. Specialized for understanding existing code structure.")
