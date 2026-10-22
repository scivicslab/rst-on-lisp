;;; one way a run of the loop ends: what happened, and whether the final answer is handed back
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule ending -> :nucleus ending/what-happened :elaboration-additional ending/final-answer)
(defrule ending/what-happened -> :instruction "終わり方の名前と、何が起きたかを書く" :sample "Hit the maxTurns limit before finishing")
(defrule ending/final-answer -> :instruction "最終の応答が呼び出し元へ返るかを書く" :sample "Yes")
