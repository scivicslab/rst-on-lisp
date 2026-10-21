;;; one subsystem around the central loop: its name and what it does for the loop
;;; members: prompt composition, tool registry, safety system, context engineering, memory and session services, subagent orchestration
(defrule subsystem -> :nucleus subsystem/does)
(defrule subsystem/does -> :instruction "部品の名前と、それがループのために行うことを 1 文で書く" :sample "The Prompt Composition engine (Section 2.3.1) assembles the system prompt from modular sections (identity, safety policy, tool guidance, workflow rules, and dynamic context), split into cacheable and non-cacheable segments for efficient API caching.")
