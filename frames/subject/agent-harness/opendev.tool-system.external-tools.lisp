;;; subject: opendev-terminal-agent-2603 2.4.7 Token-Efficient External Tool Discovery via MCP: how external tools are found by keyword search and only the found tools have their schemas put in the context
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-lazy-discovery-need p-discovery-flow p-search-tools-detail p-discovery-evolution
;;; members: flow
;;; moved into design-decision items: p-lazy-discovery-need (external tools discovered on demand); p-search-tools-detail (detail levels and scoring of the search)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp), tools (each item one copy of opendev.tool-system.tool.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: the caption of Figure 19
(defrule external-tools -> decisions external-tools-flow tools changes)
(defrule decisions -> :instruction "外部の道具の扱いで下した設計の決定を、1 行に 1 つ決定の名前で挙げる。定義を入れる時機、探索の詳しさの水準のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule external-tools-flow -> :nucleus external-tools-flow/integration :elaboration-object-attribute external-tools-flow/set :elaboration-process-step external-tools-flow/search)
(defrule external-tools-flow/integration -> :instruction "外部の道具をつなぐ仕組みを 1 文で書く" :sample "The system integrates MCP for dynamic tool connectivity.")
(defrule external-tools-flow/set -> :instruction "文脈に入れる定義の範囲を 1 文で書く" :sample "The system maintains a set of discovered tools, including only schemas for tools explicitly searched for or previously invoked.")
(defrule external-tools-flow/search -> :instruction "探索の手順を 1 文で書く" :sample "When the agent calls search_tools (e.g., with query \"database query tools\"), the SearchToolsHandler builds a vocabulary from all registered MCP tool names and descriptions, extracts keywords (tokens of 3+ characters), and scores each tool against the query using vocabulary matching.")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule changes -> :instruction "外部の道具の扱いが経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
