;;; subject: claude-agent-sdk-agent-loop 5.2 Effort level: how much reasoning the model applies per response, the levels, and what the setting trades
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-effort
;;; members: p-effort-what p-effort-default (levels: each is one copy of agent-loop.effort-level.lisp)
;;; children: each level is one copy of agent-loop.effort-level.lisp
;;; elsewhere: none
;;; left-out: none
(defrule effort -> p-effort-what levels p-effort-default)
(defrule p-effort-what -> :nucleus p-effort-what/n :elaboration-additional p-effort-what/cost :elaboration-additional p-effort-what/support)
(defrule p-effort-what/n -> :instruction "この設定が何を制御するかを 1 文で書く" :sample "The effort option controls how much reasoning Claude applies.")
(defrule p-effort-what/cost -> :instruction "水準を下げると何が減るかを 1 文で書く" :sample "Lower effort levels use fewer tokens per turn and reduce cost.")
(defrule p-effort-what/support -> :instruction "すべてのモデルが対応するとは限らないことを 1 文で書く" :sample "Not all models support the effort parameter.")
(defrule levels -> :instruction "水準を、浅い方から順に、1 行に 1 つ水準の名前で挙げる" :frame "agent-loop.effort-level.lisp")
(defrule p-effort-default -> :nucleus p-effort-default/n :elaboration-additional p-effort-default/tradeoff)
(defrule p-effort-default/n -> :instruction "設定しないときに誰が水準を決めるかを 1 文で書く" :sample "If you don't set effort, Claude Code resolves the effort level itself.")
(defrule p-effort-default/tradeoff -> :instruction "この設定が何と何を引き換えにするかと、別の仕組みとの区別を 1〜2 文で書く" :sample "effort trades latency and token cost for reasoning depth within each response. Extended thinking is a separate mechanism.")
