;;; subject: opendev-terminal-agent-2603 2.2 Agent Core Layer: the layer between the interface and the tools: how an agent is built before the first prompt and how it works after it
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / p-agent-core-place
;;; members: place perspectives
;;; children (:include / :frame, in the text's order): scaffolding opendev.agent-core.scaffolding.lisp, runtime opendev.agent-core.runtime.lisp, lifecycle opendev.agent-core.lifecycle.lisp, repl-dispatch opendev.agent-core.repl-dispatch.lisp, multi-model opendev.agent-core.multi-model.lisp, react-loop opendev.agent-core.react-loop.lisp, subagents opendev.agent-core.subagents.lisp
;;; elsewhere: none
;;; left-out: none
(defrule agent-core -> agent-core-place agent-core-perspectives scaffolding runtime lifecycle repl-dispatch multi-model react-loop subagents)
(defrule agent-core-place -> :nucleus agent-core-place/position :elaboration-part-whole agent-core-place/front-door)
(defrule agent-core-place/position -> :instruction "核の層が、画面と道具の層のどこにあるかを 1 文で書く" :sample "The agent layer sits between the UI and the tool execution layers (Figure 2).")
(defrule agent-core-place/front-door -> :instruction "全ての入力を受ける入口の部品を 1 文で書く" :sample "At its center is a single entry point, MainAgent, which receives every user prompt and decides how to process it.")
(defrule agent-core-perspectives -> :nucleus agent-core-perspectives/two-views :definition agent-core-perspectives/harness :comparison agent-core-perspectives/contrast)
(defrule agent-core-perspectives/two-views -> :instruction "層を理解するための 2 つの見方を 1 文で書く" :sample "Understanding this layer requires two perspectives: how agents are assembled before the first prompt arrives (scaffolding), and how the assembled agent processes user messages at runtime (the harness).")
(defrule agent-core-perspectives/harness -> :instruction "ハーネスとは何かを 1 文で定義する" :sample "In this context, a harness is the runtime orchestration layer that wraps the core reasoning loop and coordinates tool execution, context management, safety enforcement, and session persistence around it [99].")
(defrule agent-core-perspectives/contrast -> :instruction "組み立ての関心と実行時の関心の違いを 1 文で書く" :sample "Where scaffolding is concerned with constructing the agent before the first prompt, the harness is concerned with everything that happens after: dispatching tools, compacting context, enforcing safety invariants, and persisting state across turns.")
(defrule scaffolding -> :instruction "最初のプロンプトの前にエージェントを組み立てる仕組みを説明する" :include "opendev.agent-core.scaffolding.lisp" :heading "### Agent scaffolding")
(defrule runtime -> :instruction "組み立て後のエージェントが動く仕組みと二つのモードを説明する" :include "opendev.agent-core.runtime.lisp" :heading "### Agent runtime architecture")
(defrule lifecycle -> :instruction "1 件のユーザのメッセージが通る道筋を説明する" :include "opendev.agent-core.lifecycle.lisp" :heading "### Conversation lifecycle")
(defrule repl-dispatch -> :instruction "モデルを通さずに処理する入力の振り分けを説明する" :include "opendev.agent-core.repl-dispatch.lisp" :heading "### REPL command dispatch")
(defrule multi-model -> :instruction "仕事の種類ごとにモデルを使い分ける仕組みを説明する" :include "opendev.agent-core.multi-model.lisp" :heading "### Workload-optimized multi-model architecture")
(defrule react-loop -> :instruction "推論と行動を繰り返すループを説明する" :include "opendev.agent-core.react-loop.lisp" :heading "### Extended ReAct execution loop")
(defrule subagents -> :instruction "部分の仕事を別のエージェントに任せる仕組みを説明する" :include "opendev.agent-core.subagents.lisp" :heading "### Subagent orchestration")
