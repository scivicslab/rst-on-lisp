;;; subject: opendev-terminal-agent-2603 2.4.7 Token-Efficient External Tool Discovery via MCP: how external tools are found by keyword search and only the found tools have their schemas put in the context
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / s39 .. s41
;;; members: problem flow detail-levels design-evolution
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp)
;;; elsewhere: none
;;; left-out: the caption of Figure 19
(defrule external-tools -> external-tools-problem external-tools-flow tools external-tools-detail-levels external-tools-design-evolution)
(defrule external-tools-problem -> :nucleus external-tools-problem/n :elaboration-additional external-tools-problem/a1 :elaboration-additional external-tools-problem/a2)
(defrule external-tools-problem/n -> :instruction "外部の道具を扱う仕組みと、その根本の問題を 1 文で書く" :sample "One tool, search_tools, provides token-efficient external tool discovery via the Model Context Protocol [2] (see Discovery category in Table 1).")
(defrule external-tools-problem/a1 -> :instruction "全部入れる場合の費用を 1 文で書く" :sample "The core problem is context efficiency: a system with 100 external tools, each schema averaging 200 tokens, consumes 20,000 tokens purely for tool definitions.")
(defrule external-tools-problem/a2 -> :instruction "採った方式を 1 文で書く" :sample "OpenDev adopts lazy discovery: tools are found on-demand through keyword search, and only discovered tool schemas are included in the context.")
(defrule external-tools-flow -> :nucleus external-tools-flow/n :elaboration-additional external-tools-flow/a1 :elaboration-additional external-tools-flow/a2 :elaboration-additional external-tools-flow/a3 :elaboration-additional external-tools-flow/a4)
(defrule external-tools-flow/n -> :instruction "三つの部品の関わりを 1 文で書く" :sample "Figure 19 illustrates the three-component interaction.")
(defrule external-tools-flow/a1 -> :instruction "道具の定義を文脈に入れる範囲を 1 文で書く" :sample "The system maintains a set of discovered tools, including only schemas for tools explicitly searched for or previously invoked.")
(defrule external-tools-flow/a2 -> :instruction "検索の手順を 1 文で書く" :sample "When the agent calls search_tools (e.g., with query \"database query tools\"), the SearchToolsHandler builds a vocabulary from all registered MCP tool names and descriptions, extracts keywords (tokens of 3+ characters), and scores each tool against the query using vocabulary matching.")
(defrule external-tools-flow/a3 -> :instruction "見つけた道具の記録と効果を 1 文で書く" :sample "The ToolRegistry then marks matched tools as discovered via discover_mcp_tool(), adding their schemas to the discovered set so that the next LLM call includes them.")
(defrule external-tools-flow/a4 -> :instruction "検索を経ずに呼んだ場合を 1 文で書く" :sample "Directly invoking an MCP tool by its qualified name (e.g., mcp__github__create_issue) auto-discovers it without requiring a prior search.")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule external-tools-detail-levels -> :nucleus external-tools-detail-levels/n :elaboration-additional external-tools-detail-levels/a1 :elaboration-additional external-tools-detail-levels/a2)
(defrule external-tools-detail-levels/n -> :instruction "文脈への投資を決める三つの詳しさを 1 文で書く" :sample "Three detail levels control context investment: names returns only tool names (minimal tokens), brief adds short descriptions, and full triggers full schema inclusion in subsequent LLM calls.")
(defrule external-tools-detail-levels/a1 -> :instruction "採点の方法を 1 文で書く" :sample "Name matches score 2 points and description matches score 1 point; results rank by total score, surfacing the most relevant tools first.")
(defrule external-tools-detail-levels/a2 -> :instruction "この方式が引き換えにするものを 1 文で書く" :sample "This trades discovery overhead (the agent must search, then invoke) for context savings (only relevant tools are loaded).")
(defrule external-tools-design-evolution -> :nucleus external-tools-design-evolution/n :elaboration-additional external-tools-design-evolution/a1)
(defrule external-tools-design-evolution/n -> :instruction "最初の実装と、その費用を 1 文で書く" :sample "The initial implementation included all external tool schemas in every call, consuming up to 40% of the context before the first user message.")
(defrule external-tools-design-evolution/a1 -> :instruction "遅延発見の効果を 1 文で書く" :sample "Lazy discovery reduced baseline overhead to nearly zero (< 5%), growing only as capabilities are actually used.")
