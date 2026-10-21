;;; subject: claude-agent-sdk-agent-loop 5 Control how the loop runs (5.4 Model): the settings that bound a run, set how hard the model reasons, decide who approves tool use, and choose the model
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-control (s-turns-budget s-effort s-permission-mode s-model)
;;; members: p-model
;;; children (:include, in the page's order): 5.1 and 5.1.1 agent-loop.limits.lisp, 5.2 agent-loop.effort.lisp, 5.3 agent-loop.permission-mode.lisp
;;; elsewhere: none
;;; left-out: none
(defrule control -> limits effort permission-mode p-model)
(defrule limits -> :instruction "実行の長さと費用に上限を置く設定を説明する" :include "agent-loop.limits.lisp" :heading "#### Turns and budget")
(defrule effort -> :instruction "モデルがどれだけ考えるかを決める設定を説明する" :include "agent-loop.effort.lisp" :heading "#### Effort level")
(defrule permission-mode -> :instruction "ツールを使う前に承認を求めるかを決める設定を説明する" :include "agent-loop.permission-mode.lisp" :heading "#### Permission mode")
(defrule p-model -> :nucleus p-model/n)
(defrule p-model/n -> :instruction "どのモデルで実行するかを選ぶ設定を 1 文で書く" :sample "Set the model option to choose which model runs the session.")
