;;; one point of the loop at which the harness runs an outside callback: when it fires and what it is commonly used for
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule hook-point -> :nucleus hook-point/fires :purpose hook-point/uses)
(defrule hook-point/fires -> :instruction "フックがいつ呼ばれるかを書く" :sample "Before a tool executes")
(defrule hook-point/uses -> :instruction "よくある使い方を書く" :sample "Validate inputs, block dangerous commands")
