;;; subject: agent-harness / claude-agent-sdk-agent-loop: the loop with which an agent run alternates between the model and its tools, explained from one cycle to the way a run is bounded, remembered and ended
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-glance s-turns (and the sections included below)
;;; members: p-intro glance-steps p-cycle turns-example
;;; children (:include, in the page's order): subject 3 and 3.1 agent-loop.message-kinds.lisp, 4 agent-loop.tool-execution.lisp, 5 agent-loop.control.lisp, 6 agent-loop.context-window.lisp, 7 agent-loop.session.lisp, 8 agent-loop.result.lisp, 9 agent-loop.hooks.lisp
;;; elsewhere: none (every section of the page is a node of its subject tree)
;;; left-out: subject 10 (Put it all together: a program that sets the options above, a sample of use), subject 11 (Next steps: pointers to other pages)
(in-package :rst)
(defdocument AgentLoopFrame)

(defrule document -> title sections)
(defrule title -> :instruction "説明する、エージェントの実行を回すループの題を書く")
(defrule sections -> s1)
(defrule s1 -> p-intro glance-steps p-cycle turns-example messages tool-execution control context-window session result hooks :heading "## The agent loop")

;; what the loop gives the reader (p-intro)
(defrule p-intro -> :nucleus p-intro/n)
(defrule p-intro/n -> :instruction "このループのどの仕組みを理解させる説明か、取り上げる仕組みを列挙して 1 文で書く" :sample "Understand the message lifecycle, tool execution, context window, and architecture that power your SDK agents.")
;; the cycle in the order it happens (glance-steps)
(defrule glance-steps -> :instruction "ループが 1 回りする間の段階を、起きる順に 1 項目ずつ、段階の名前に続けて、その段階で誰が何を受け取り何を返すかを書く"
  :sample "Receive prompt. Claude receives your prompt, along with the system prompt, tool definitions, and conversation history. / Execute tools. The SDK runs each requested tool and collects the results. / Repeat. Steps 2 and 3 repeat as a cycle. Each full cycle is one turn. / Return result. The SDK yields a final AssistantMessage with the text response (no tool calls), followed by a ResultMessage with the final text, token usage, cost, and session ID."
  :kind bullet)
;; when the cycle stops repeating (p-cycle)
(defrule p-cycle -> :nucleus p-cycle/n)
(defrule p-cycle/n -> :instruction "ループの 1 回りを何と呼び、何が起きるとその繰り返しが終わるかを 1 文で書く" :sample "Claude continues calling tools and processing results until it produces a response with no tool calls.")
;; one run followed turn by turn (turns-example)
(defrule turns-example -> :instruction "実際の 1 回の実行を、ターンごとに 1 項目ずつ、そのターンで呼んだ道具と受け取った結果で書く。最後は道具を呼ばない文章だけの応答で終える"
  :sample "Turn 1: Claude calls Bash to run npm test. The SDK yields an AssistantMessage with the tool call, executes the command, then yields a UserMessage with the output (three failures). / Final turn: Claude produces a text-only response with no tool calls: \"Fixed the auth bug, all three tests pass now.\""
  :kind bullet)
;; the parts of the loop, one section each
(defrule messages -> :instruction "ループが外へ出すメッセージの種類と、受け取り方を説明する" :include "agent-loop.message-kinds.lisp" :heading "### Message types")
(defrule tool-execution -> :instruction "ループが道具を実行する仕組みと、その許可、並べ方を説明する" :include "agent-loop.tool-execution.lisp" :heading "### Tool execution")
(defrule control -> :instruction "ループの回り方を決める設定を説明する" :include "agent-loop.control.lisp" :heading "### Control how the loop runs")
(defrule context-window -> :instruction "ループの間に積み上がる文脈と、その節約を説明する" :include "agent-loop.context-window.lisp" :heading "### The context window")
(defrule session -> :instruction "実行をまたいで続ける仕組みを説明する" :include "agent-loop.session.lisp" :heading "### Sessions and continuity")
(defrule result -> :instruction "ループが終わったときの結果の読み方を説明する" :include "agent-loop.result.lisp" :heading "### Handle the result")
(defrule hooks -> :instruction "ループの途中に処理を差し込む仕組みを説明する" :include "agent-loop.hooks.lisp" :heading "### Hooks")
