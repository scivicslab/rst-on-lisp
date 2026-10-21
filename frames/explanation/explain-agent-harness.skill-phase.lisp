;;; one phase of how reusable instructions (skills) are handled: what is read, what is placed in the prompt or the conversation, and why
;;; roles: claude-doc: - (skill descriptions are one source of context) / opendev: opendev.tool-system.skill-phase.lisp (the sample is the discovery phase)
(defrule skill-phase -> :nucleus skill-phase/does :purpose skill-phase/purpose)
(defrule skill-phase/does -> :instruction "段階の名前と、その段階で読むもの、置くものを書く" :sample "Phase 1: Metadata discovery. At startup, the SkillLoader scans all skill directories, parsing only the YAML frontmatter to extract names and descriptions.")
(defrule skill-phase/purpose -> :instruction "その段階の目的を書く" :sample "enabling the agent to discover available expertise without loading instructional content.")
