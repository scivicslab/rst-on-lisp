;;; one role of subagent: its name, the tools it gets, and what it is specialised for
;;; members: Code explorer, Strategic planner, Web tools, User clarification
(defrule subagent-role -> :nucleus subagent-role/n)
(defrule subagent-role/n -> :instruction "部下の役割の名前、持たせる道具、向いている仕事を書く" :sample "Code explorer: Read-only tools for codebase navigation. Specialized for understanding existing code structure.")
