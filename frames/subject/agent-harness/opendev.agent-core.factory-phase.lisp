;;; one phase of the factory that assembles the agents: what it finds or builds and registers, and what becomes available to the model afterwards
;;; members: Phase 1 (skills), Phase 2 (subagents), Phase 3 (main agent); the sample is Phase 1
(defrule factory-phase -> :nucleus factory-phase/does :result factory-phase/available)
(defrule factory-phase/does -> :instruction "段階の名前と、その段階が見つけて登録するものを 1 文で書く" :sample "Phase 1 (Skills). The factory discovers skill definitions from three directories (builtin (swecli/skills/builtin/), user global (~/.opendev/skills/), and project-local (.opendev/skills/)), creates a SkillLoader, and registers it with the tool registry")
(defrule factory-phase/available -> :instruction "登録の結果、モデルが使えるようになる道具を書く。無ければ空にする" :sample "so that the use_skill tool becomes available.")
