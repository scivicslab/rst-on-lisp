;;; subject: opendev-terminal-agent-2603 2.3.6 Adaptive Context Compaction: how context is reduced in graduated stages of rising pressure instead of one emergency summary, and how learned strategies are kept across sessions
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / p-compaction-problem p-acc-introduced p-acc-stages p-artifact-index p-playbook-memory
;;; members: problem acc stages artifact playbook
;;; children (:include / :frame, in the text's order): stage-list (each item one copy of opendev.context-engineering.compaction-stage.lisp), playbook-stages (each item one copy of opendev.context-engineering.playbook-stage.lisp)
;;; elsewhere: none
;;; left-out: the captions of Figures 13 and 14
(defrule compaction -> compaction-problem compaction-acc compaction-stages stage-list compaction-artifact compaction-playbook playbook-stages)
(defrule compaction-problem -> :nucleus compaction-problem/binary :result compaction-problem/late)
(defrule compaction-problem/binary -> :instruction "従来の二値の閾値の方式を 1 文で書く" :sample "Standard systems rely on a binary emergency compaction threshold (typically triggered at 95–99% capacity) that performs a lossy summarization of the conversation history.")
(defrule compaction-problem/late -> :instruction "その方式の欠点を 1 文で書く" :sample "This approach results in late activation, severe information loss, and compounding errors upon subsequent compactions.")
(defrule compaction-acc -> :instruction "使用量の測り方と、導入した枠組みを 1 文で書く" :sample "To mitigate these issues, OpenDev monitors token usage incrementally, using the API’s reported prompt_tokens count as a calibration anchor, and implements Adaptive Context Compaction (ACC), a framework that manages context pressure through a five-stage pipeline of progressively aggressive reduction strategies (Figure 13).")
(defrule compaction-stages -> :instruction "圧力が上がるにつれて段階を適用することを 1 文で書く" :sample "Rather than waiting for the context window to fill, ACC monitors context pressure at the start of every ReAct iteration and applies five graduated stages:")
(defrule stage-list -> :instruction "圧縮の段階を、圧力の低い方から順に、1 行に 1 つ段階の名前で挙げる" :frame "opendev.context-engineering.compaction-stage.lisp")
(defrule compaction-artifact -> :nucleus compaction-artifact/index :result compaction-artifact/non-lossy)
(defrule compaction-artifact/index -> :instruction "圧縮の要約に残す、触れたファイルの索引を 1 文で書く" :sample "ACC’s compaction pipeline additionally maintains an Artifact Index, a structured registry of all files touched and operations performed during the session (read, created, modified, deleted).")
(defrule compaction-artifact/non-lossy -> :instruction "保管先を要約に書く効果を 1 文で書く" :sample "making compaction effectively non-lossy: the agent can recover any detail by reading the archive. Quantitative evaluations demonstrate that ACC reduces peak context consumption of observations by approximately 54%, often eliminating the need for emergency compaction entirely over typical 30-turn sessions.")
(defrule compaction-playbook -> :background compaction-playbook/experience :nucleus compaction-playbook/playbook :elaboration-additional compaction-playbook/pipeline)
(defrule compaction-playbook/experience -> :instruction "実行をまたいで経験が積み上がることを 1 文で書く" :sample "Agents working in a project over multiple sessions accumulate experience about which approaches succeed and which do not.")
(defrule compaction-playbook/playbook -> :instruction "経験を手引きとして持つ仕組みを 1 文で書く" :sample "The Agentic Context Engineering (ACE) subsystem captures this experience as a playbook: a collection of natural-language bullets, each tagged with effectiveness counters (helpful, harmful, or neutral) and a creation timestamp.")
(defrule compaction-playbook/pipeline -> :instruction "手引きを更新する流れを 1 文で書く" :sample "Figure 14 illustrates the four-stage pipeline that keeps the playbook current.")
(defrule playbook-stages -> :instruction "手引きを更新する流れの段階を、1 行に 1 つ段階の名前で挙げる" :frame "opendev.context-engineering.playbook-stage.lisp")
