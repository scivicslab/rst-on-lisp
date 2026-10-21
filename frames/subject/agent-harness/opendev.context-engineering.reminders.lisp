;;; subject: opendev-terminal-agent-2603 2.3.4 Context-Aware System Reminders: how short messages are injected just before the decision that would otherwise go wrong, so that early instructions keep their effect in a long run
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/03_context-engineering/03_context-engineering.lisp / p-reminder-problem p-reminder-example p-reminder-cause p-reminder-approach p-event-detectors p-reminder-templates p-reminder-guards p-user-role-choice p-reminder-degradation p-reminder-evolution
;;; members: problem cause approach detectors templates guards role degradation
;;; children (:include / :frame, in the text's order): changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: the captions of Figures 11 and 12
(defrule reminders -> reminders-problem reminders-cause reminders-approach reminders-detectors reminders-templates reminders-guards reminders-role reminders-degradation changes)
(defrule reminders-problem -> :instruction "長い実行で指示が効かなくなる問題を 1 文で書く" :sample "System reminders address a fundamental reliability problem in long-running agent sessions: as the conversation grows, the model’s attention drifts away from the initial system-prompt instructions, leading to silent failures such as premature task completion, abandoned error recovery, and unchecked exploration spirals (Figure 11).")
(defrule reminders-cause -> :instruction "その原因を指示文の位置から 1 文で書く" :sample "The root cause is simple: the system prompt sits at the very beginning of the conversation.")
(defrule reminders-approach -> :background reminders-approach/alternatives :nucleus reminders-approach/just-in-time)
(defrule reminders-approach/alternatives -> :instruction "先頭に全部置く方式や繰り返し入れる方式の限界を 1 文で書く" :sample "Putting all instructions up front works initially but degrades over long sessions.")
(defrule reminders-approach/just-in-time -> :instruction "必要な時点で短い催促を入れる方式を 1 文で書く" :sample "OpenDev addresses this with system reminders: short, single-purpose messages injected exactly when the agent needs them, right before the decision point where it would otherwise go wrong.")
(defrule reminders-detectors -> :instruction "催促を入れる条件の数と種類を 1 文で書く" :sample "As shown in Figure 12, the injection layer monitors eight conditions at the boundary between tool execution and the next LLM call: tool failure without retry (with six error-specific recovery templates), exploration spirals (5+ consecutive reads), denied tool re-attempts, premature completion with incomplete todos, continued work after all todos are done, plan approval without follow-through, unprocessed subagent results, and empty completion messages.")
(defrule reminders-templates -> :instruction "催促の文面を置く場所を 1 文で書く" :sample "All reminder text lives outside source code.")
(defrule reminders-guards -> :background reminders-guards/noise :nucleus reminders-guards/caps)
(defrule reminders-guards/noise -> :instruction "毎回出す催促が雑音になることを 1 文で書く" :sample "A reminder that fires on every iteration stops being helpful and becomes noise the model learns to ignore.")
(defrule reminders-guards/caps -> :instruction "催促の回数を制限する仕組みを 1 文で書く" :sample "To prevent this, each reminder type is governed by a counter or a one-shot flag tracked in the per-session IterationContext (right column of Figure 12).")
(defrule reminders-role -> :nucleus reminders-role/user-role :reason reminders-role/recency)
(defrule reminders-role/user-role -> :instruction "催促をどの役割の発言として入れるかを 1 文で書く" :sample "Reminders are injected as role: user messages rather than role: system.")
(defrule reminders-role/recency -> :instruction "その理由を 1 文で書く" :sample "After 40 turns of conversation, another system message blends into the background that the model has already partially forgotten.")
(defrule reminders-degradation -> :instruction "催促が欠けたときも動くことを 1 文で書く" :sample "If a reminder template is missing or retrieval fails, the agent still has its system prompt.")
(defrule changes -> :instruction "催促の仕組みが経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
