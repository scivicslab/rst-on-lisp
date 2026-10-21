;;; subject: claude-agent-sdk-agent-loop 5.1 Turns and budget (5.1.1 Budget headroom): the two caps on a run, what happens at a cap, and how far spend can pass a cap
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-turns-budget s-budget-headroom
;;; members: budget-table p-budget-subagents p-headroom
;;; children: none
;;; elsewhere: none
;;; left-out: none
(defrule limits -> budget-table p-budget-subagents p-headroom)
(defrule budget-table -> :instruction "上限の設定を 1 行に 1 つ、設定の名前、上限にするもの、既定の値の順に、' | ' で区切って書く。見出しの行を先頭に置く"
  :sample "Option | What it controls | Default / Max turns (max_turns / maxTurns) | Maximum tool-use round trips | No limit"
  :kind table)
(defrule p-budget-subagents -> :nucleus p-budget-subagents/n :elaboration-additional p-budget-subagents/fail)
(defrule p-budget-subagents/n -> :instruction "上限に達したときに SDK が返すものと、費用の上限が部下の実行にも及ぶことを 1〜2 文で書く" :sample "When either limit is hit, the SDK returns a ResultMessage with a corresponding error subtype (error_max_turns or error_max_budget_usd). The budget cap covers subagents: their spend counts toward the total.")
(defrule p-budget-subagents/fail -> :instruction "費用が上限に達した後、部下の起動と実行中の部下がどうなるかを 1 文で書く" :sample "Once spend reaches the cap, spawning another subagent fails with \"Budget limit reached\", and Claude Code stops any background subagents still running.")
(defrule p-headroom -> :nucleus p-headroom/n :reason p-headroom/cause :consequence-s p-headroom/overshoot :elaboration-additional p-headroom/advice)
(defrule p-headroom/n -> :instruction "費用の上限をいつ照らし合わせるかを 1 文で書く" :sample "Claude Code compares spend with the max_budget_usd / maxBudgetUsd cap after model responses arrive.")
(defrule p-headroom/cause -> :instruction "その時機になる理由を 1 文で書く" :sample "because each response's cost comes from the token usage the API returns with it.")
(defrule p-headroom/overshoot -> :instruction "その結果、費用が上限を超えうる幅を 1〜2 文で書く" :sample "Spend can therefore pass the cap by up to the cost of that one response, plus anything that subagents still running at that moment spend before they stop.")
(defrule p-headroom/advice -> :instruction "上限を決めるときの心得を 1 文で書く" :sample "Leave headroom for this when you set the cap.")
