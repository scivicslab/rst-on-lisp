;;; one step of an iteration of the loop: what the executor takes, checks or calls at that step
;;; members: drain injected messages, check compaction, think, act and dispatch
(defrule iteration-step -> :nucleus iteration-step/does)
(defrule iteration-step/does -> :instruction "手順の名前と、その手順で実行部が何を取り出し、点検し、呼ぶかを 1 文で書く" :sample "First, the executor drains any messages that the UI thread injected since the last iteration, such as follow-up instructions or system signals delivered through a thread-safe queue.")
