;;; subject: claude-agent-sdk-agent-loop 9 Hooks: callbacks the application attaches at fixed points of the loop, and where they run
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-hooks
;;; members: p-hooks-what p-hooks-isolation (hook points: each is one copy of agent-loop.hook.lisp)
;;; children: each hook is one copy of agent-loop.hook.lisp
;;; elsewhere: none
;;; left-out: none
(defrule hooks -> p-hooks-what points p-hooks-isolation)
(defrule p-hooks-what -> :nucleus p-hooks-what/n)
(defrule p-hooks-what/n -> :instruction "フックが何で、ループのどんな時点で呼ばれるかを 1 文で書く" :sample "Hooks are callbacks that fire at specific points in the loop: before a tool runs, after it returns, when the agent finishes, and so on.")
(defrule points -> :instruction "フックの時点を、1 行に 1 つ名前で挙げる" :frame "agent-loop.hook.lisp")
(defrule p-hooks-isolation -> :nucleus p-hooks-isolation/n)
(defrule p-hooks-isolation/n -> :instruction "フックがどこで動き、文脈に何の影響があるかを 1 文で書く" :sample "Hooks run in your application process, not inside the agent's context window, so they don't consume context.")
