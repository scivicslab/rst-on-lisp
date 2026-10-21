;;; subject: opendev-terminal-agent-2603 2.1 Overview (2 System Architecture): how one terminal coding agent is divided into layers, from the entry point to the files it keeps, with the safety measures that cut across them
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / p-architecture-layers p-entry-and-frontends p-agent-layer-parts p-tool-and-context-parts p-persistence-stores p-safety-need p-overview-roadmap
;;; members: architecture safety roadmap
;;; children (:include / :frame, in the text's order): layers (each item one copy of opendev.layer.lisp), agent-core opendev.agent-core.lisp, context-engineering opendev.context-engineering.lisp, tool-system opendev.tool-system.lisp, persistence-layer opendev.persistence.lisp
;;; elsewhere: none
;;; left-out: the captions of Figures 2 and 3 (figures are not copied)
(in-package :rst)
(defdocument OpenDevFrame)

(defrule document -> title sections)
(defrule title -> :instruction "説明する、端末で動くコーディングエージェントの全体像の題を書く")
(defrule sections -> s1)
(defrule s1 -> opendev-architecture layers opendev-safety opendev-roadmap agent-core context-engineering tool-system persistence-layer :heading "## System architecture")
(defrule opendev-architecture -> :nucleus opendev-architecture/layers :elaboration-object-attribute opendev-architecture/flow)
(defrule opendev-architecture/layers -> :instruction "システムが何層から成り、各層が何かを 1 文で書く" :sample "Figure 2 illustrates the architecture of OpenDev across four principal layers: Entry & UI, Agent, Tool & Context, and Persistence.")
(defrule opendev-architecture/flow -> :instruction "層をまたぐ処理の流れの性質を 1 文で書く" :sample "A user query flows through this pipeline sequentially, from the entry point through agent reasoning and tool execution, before results are persisted and rendered.")
(defrule layers -> :instruction "層を、処理の流れの順に、1 行に 1 つ層の名前で挙げる" :frame "opendev.layer.lisp")
(defrule opendev-safety -> :reason opendev-safety/need :nucleus opendev-safety/stance)
(defrule opendev-safety/need -> :instruction "安全の仕組みを 1 つに頼れない理由を 1 文で書く" :sample "Because the agent can execute arbitrary shell commands, overwrite files, and spawn persistent processes, a single safety mechanism is insufficient.")
(defrule opendev-safety/stance -> :instruction "採る安全の構えと、独立した層の数を 1 文で書く" :sample "OpenDev therefore employs a defense-in-depth architecture with five independent safety layers (Figure 3), each designed to prevent a class of harm independently so that no single point of failure compromises the system.")
(defrule opendev-roadmap -> :instruction "この概観の後、各層を詳しくどの順に見ていくかを 1 文で書く" :sample "Having established the four-layer overview, we now examine each layer in detail, beginning with the agent core that implements the reasoning loop driving all agent behavior.")
(defrule agent-core -> :instruction "エージェントの核の層を説明する" :include "opendev.agent-core.lisp" :heading "## Agent core layer")
(defrule context-engineering -> :instruction "モデルが見る文脈を管理する層を説明する" :include "opendev.context-engineering.lisp" :heading "## Context engineering layer")
(defrule tool-system -> :instruction "エージェントが使う道具の層を説明する" :include "opendev.tool-system.lisp" :heading "## Tool system")
(defrule persistence-layer -> :instruction "状態を保存する層を説明する" :include "opendev.persistence.lisp" :heading "## Persistence layer")
