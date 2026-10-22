;;; one phase of how reusable instructions (skills) are handled: what is read, what is placed in the prompt or the conversation, and why
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule skill-phase -> :nucleus skill-phase/does :purpose skill-phase/purpose)
(defrule skill-phase/does -> :instruction "段階の名前と、その段階で読むもの、置くものを書く" :sample "Phase 1: Metadata discovery. At startup, the SkillLoader scans all skill directories, parsing only the YAML frontmatter to extract names and descriptions.")
(defrule skill-phase/purpose -> :instruction "その段階の目的を書く" :sample "enabling the agent to discover available expertise without loading instructional content.")
