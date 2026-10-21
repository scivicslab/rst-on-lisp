;;; subject: opendev-terminal-agent-2603 2.2.2 Agent Runtime Architecture: how the assembled agent turns a stateless model into a tool-using agent: the central loop, the subsystems around it, the steps of planning by a subagent, and the design decisions about modes and planning
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / p-harness-runtime p-six-phase-cycle p-input-and-output-boundary p-seven-subsystems p-planner-stages p-plan-review p-normal-mode p-replanning
;;; members: harness cycle boundaries subsystems planner-stages plan-review normal-mode replanning
;;; moved into design-decision items: p-two-modes and p-mode-routing (two modes, chosen once per prompt), p-planning-by-subagent (planning delegated to a read-only subagent), p-old-plan-design and p-new-plan-design (the earlier state machine, and what the delegation brings)
;;; children (:include / :frame, in the text's order): subsystem-list (each item one copy of opendev.agent-core.subsystem.lisp), decisions (each item one copy of opendev.design-decision.lisp)
;;; elsewhere: none
;;; left-out: the captions of Figures 4 and 5
(defrule runtime -> runtime-harness runtime-cycle runtime-boundaries runtime-subsystems subsystem-list decisions runtime-planner-stages runtime-plan-review runtime-normal-mode runtime-replanning)
(defrule runtime-harness -> :instruction "実行時の動作を統べる仕組みと、それがモデルをどう変えるかを 1 文で書く" :sample "The runtime behavior is governed by the agent harness, the orchestration infrastructure introduced in Section 2.2 that turns a stateless LLM into a persistent, tool-using, self-correcting agent.")
(defrule runtime-cycle -> :instruction "中心のループが 1 回の繰り返しで行う段階を挙げて 1 文で書く" :sample "The ReAct loop at the center of Figure 4 executes six phases per iteration: pre-check and compaction, thinking, self-critique, action, tool execution, and post-processing.")
(defrule runtime-boundaries -> :instruction "入力を受ける部分と、実行中にも届くメッセージの扱いを 1 文で書く。出力側の後処理があれば、それも書く" :sample "At the top of Figure 4, the Input Layer accepts user messages through a thread-safe bounded queue, allowing follow-up messages to arrive while the agent is mid-execution.")
(defrule runtime-subsystems -> :instruction "ループの周りの部品の数と、各部品が別の関心を担うことを 1 文で書く" :sample "The periphery of Figure 4 shows seven subsystems, each addressing a distinct concern and detailed in a dedicated section.")
(defrule subsystem-list -> :instruction "周りの部品を、1 行に 1 つ部品の名前で挙げる" :frame "opendev.agent-core.subsystem.lisp")
(defrule decisions -> :instruction "実行時の構造で下した設計の決定を、1 行に 1 つ決定の名前で挙げる。動作のモードの数、モードを決める時機、計画の任せ先のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule runtime-planner-stages -> :instruction "計画役が行う段階の数と、段階の内容を順に書く" :sample "The Planner subagent executes in three stages visible in Figure 5.")
(defrule runtime-plan-review -> :instruction "計画を書き終えた後、何を誰に返し、利用者がどう選ぶかを 1 文で書く" :sample "Upon completion, the Planner returns the plan file path to the main agent.")
(defrule runtime-normal-mode -> :instruction "計画の外での、通常の動作を 1 文で書く" :sample "Normal Mode is the default and only operating state.")
(defrule runtime-replanning -> :instruction "実行中に予期しない結果に出会ったときの対処を 1 文で書く" :sample "During execution, if the agent encounters unexpected results (such as a test failure that reveals a deeper issue, a dependency conflict, or a scope change), it can spawn the Planner subagent again with the current codebase state as context, producing a revised plan that accounts for what has changed since the original plan was approved.")
