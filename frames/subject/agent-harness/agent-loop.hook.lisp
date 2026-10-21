;;; one hook point: its name, when it fires, and what it is commonly used for
;;; members: PreToolUse, PostToolUse, UserPromptSubmit, Stop, SubagentStart / SubagentStop, PreCompact
(defrule hook -> :nucleus hook/n :elaboration-additional hook/uses)
(defrule hook/n -> :instruction "フックがいつ呼ばれるかを書く" :sample "Before a tool executes")
(defrule hook/uses -> :instruction "よくある使い方を書く" :sample "Validate inputs, block dangerous commands")
