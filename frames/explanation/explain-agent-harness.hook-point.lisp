;;; one point of the loop at which the harness runs an outside callback: when it fires and what it is commonly used for
;;; roles: claude-doc: agent-loop.hook.lisp / opendev: the ten lifecycle events of p-lifecycle-hooks and p-tool-lifecycle-hooks
(defrule hook-point -> :nucleus hook-point/fires :purpose hook-point/uses)
(defrule hook-point/fires -> :instruction "フックがいつ呼ばれるかを書く" :sample "Before a tool executes")
(defrule hook-point/uses -> :instruction "よくある使い方を書く" :sample "Validate inputs, block dangerous commands")
