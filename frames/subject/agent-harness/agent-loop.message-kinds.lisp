;;; subject: claude-agent-sdk-agent-loop 3 Message types (3.1 Handle messages): what the loop yields to the program that drives it, kind by kind, and how the program takes them
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-messages s-handle-messages
;;; members: p-system-message p-assistant-message p-user-message p-stream-event p-result-message (each is one copy of agent-loop.message-kind.lisp), handle-items (first three bullets)
;;; children: each kind is one copy of agent-loop.message-kind.lisp
;;; elsewhere: none
;;; left-out: the sentence that gives the TypeScript SDK's type layout for the subtypes of the system message, the last two bullets of "Handle messages" (how Python and TypeScript test a message's type: isinstance, the type string)
(defrule message-kinds -> kinds handling)
(defrule kinds -> :instruction "ループが出すメッセージの種類を、1 行に 1 つ種類の名前で挙げる" :frame "agent-loop.message-kind.lisp")
(defrule handling -> :instruction "プログラムが何を知りたいかごとに、どの種類のメッセージを見ればよいかを、1 項目ずつ書く。知りたいことが結果だけの場合、途中経過の場合、実時間の流れの場合を分ける"
  :sample "Final results only: handle ResultMessage to get the output, cost, and whether the task succeeded or hit a limit. / Progress updates: handle AssistantMessage to see what Claude is doing each turn, including which tools it called. / Live streaming: enable partial messages (include_partial_messages in Python, includePartialMessages in TypeScript) to get StreamEvent messages in real time."
  :kind bullet)
