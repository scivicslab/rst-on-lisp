;;; subject: opendev-terminal-agent-2603 2.4.7 Token-Efficient External Tool Discovery via MCP: how external tools are found by keyword search and only the found tools have their schemas put in the context
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-lazy-discovery-need p-discovery-flow p-search-tools-detail p-discovery-evolution
;;; members: need flow detail
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: the caption of Figure 19
(defrule external-tools -> external-tools-need external-tools-flow external-tools-detail tools changes)
(defrule external-tools-need -> :background external-tools-need/cost :nucleus external-tools-need/lazy)
(defrule external-tools-need/cost -> :instruction "全ての定義を入れる費用を、数で書く" :sample "The core problem is context efficiency: a system with 100 external tools, each schema averaging 200 tokens, consumes 20,000 tokens purely for tool definitions.")
(defrule external-tools-need/lazy -> :instruction "採った方式を 1 文で書く" :sample "OpenDev adopts lazy discovery: tools are found on-demand through keyword search, and only discovered tool schemas are included in the context.")
(defrule external-tools-flow -> :nucleus external-tools-flow/integration :elaboration-object-attribute external-tools-flow/set :elaboration-process-step external-tools-flow/search)
(defrule external-tools-flow/integration -> :instruction "外部の道具をつなぐ仕組みを 1 文で書く" :sample "The system integrates MCP for dynamic tool connectivity.")
(defrule external-tools-flow/set -> :instruction "文脈に入れる定義の範囲を 1 文で書く" :sample "The system maintains a set of discovered tools, including only schemas for tools explicitly searched for or previously invoked.")
(defrule external-tools-flow/search -> :instruction "探索の手順を 1 文で書く" :sample "When the agent calls search_tools (e.g., with query \"database query tools\"), the SearchToolsHandler builds a vocabulary from all registered MCP tool names and descriptions, extracts keywords (tokens of 3+ characters), and scores each tool against the query using vocabulary matching.")
(defrule external-tools-detail -> :nucleus external-tools-detail/levels :evaluation-s external-tools-detail/tradeoff)
(defrule external-tools-detail/levels -> :instruction "文脈への投資を決める詳しさの水準を 1 文で書く" :sample "Three detail levels control context investment: names returns only tool names (minimal tokens), brief adds short descriptions, and full triggers full schema inclusion in subsequent LLM calls.")
(defrule external-tools-detail/tradeoff -> :instruction "この方式が引き換えにするものを 1 文で書く" :sample "This trades discovery overhead (the agent must search, then invoke) for context savings (only relevant tools are loaded).")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule changes -> :instruction "外部の道具の扱いが経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
