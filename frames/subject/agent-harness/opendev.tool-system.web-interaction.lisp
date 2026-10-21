;;; subject: opendev-terminal-agent-2603 2.4.4 Web Interaction: the four read-only tools that fetch pages, search the web, take screenshots and open a browser, and why a browser engine is used
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / p-web-tools p-fetch-url p-deep-crawl p-web-search p-screenshot p-open-browser p-web-evolution
;;; members: overview deep-crawl
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp), changes (each item one copy of opendev.design-change.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule web-interaction -> web-interaction-overview tools web-interaction-deep-crawl changes)
(defrule web-interaction-overview -> :nucleus web-interaction-overview/four :elaboration-object-attribute web-interaction-overview/read-only)
(defrule web-interaction-overview/four -> :instruction "ウェブの道具の数と用途を 1 文で書く" :sample "Four tools provide web interaction capabilities (see Web category in Table 1) for documentation research, content inspection, and browser-based testing.")
(defrule web-interaction-overview/read-only -> :instruction "計画の間にも使えるかを 1 文で書く" :sample "All web tools are read-only and safe for use in plan mode.")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule web-interaction-deep-crawl -> :instruction "複数の頁にわたる探索の方式を 1 文で書く" :sample "For multi-page exploration, the tool supports deep crawling with three configurable strategies: breadth-first (BFS), depth-first (DFS), or best-first (priority by content relevance).")
(defrule changes -> :instruction "ウェブの取得が経た転換を、1 行に 1 つ、置き換えた設計の名前で挙げる" :frame "opendev.design-change.lisp")
