;;; one role of subagent: its name, the tools it gets, and what it is specialised for
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule subagent-role -> :nucleus subagent-role/role)
(defrule subagent-role/role -> :instruction "部下の役割の名前、持たせる道具、向いている仕事を書く" :sample "Code explorer: Read-only tools for codebase navigation. Specialized for understanding existing code structure.")
