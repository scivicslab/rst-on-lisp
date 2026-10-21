;;; one group of slash commands: which commands it holds and what they change
;;; members: session, mode, configuration, MCP, agent / skills / plugin, tool and help commands
(defrule command-group -> :nucleus command-group/does)
(defrule command-group/does -> :instruction "命令の種類の名前、含まれる命令、変えるものを 1 文で書く" :sample "Session commands (/clear, /compact) manage conversation state: clearing saves the current session and starts fresh, while compacting triggers context reduction on demand.")
