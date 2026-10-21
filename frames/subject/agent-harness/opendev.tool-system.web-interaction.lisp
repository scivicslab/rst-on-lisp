;;; subject: opendev-terminal-agent-2603 2.4.4 Web Interaction: the four read-only tools that fetch pages, search the web, take screenshots and open a browser, and why a browser engine is used
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / s19 .. s4
;;; members: overview design-evolution
;;; children (:include / :frame, in the text's order): tools (each item one copy of opendev.tool-system.tool.lisp)
;;; elsewhere: none
;;; left-out: none
(defrule web-interaction -> web-interaction-overview tools web-interaction-design-evolution)
(defrule web-interaction-overview -> :nucleus web-interaction-overview/n :elaboration-additional web-interaction-overview/a1)
(defrule web-interaction-overview/n -> :instruction "ウェブの道具の数と用途を 1 文で書く" :sample "Four tools provide web interaction capabilities (see Web category in Table 1) for documentation research, content inspection, and browser-based testing.")
(defrule web-interaction-overview/a1 -> :instruction "計画モードで使えるかを 1 文で書く" :sample "All web tools are read-only and safe for use in plan mode.")
(defrule tools -> :instruction "道具を、1 行に 1 つ道具の名前で挙げる" :frame "opendev.tool-system.tool.lisp")
(defrule web-interaction-design-evolution -> :nucleus web-interaction-design-evolution/n :elaboration-additional web-interaction-design-evolution/a1)
(defrule web-interaction-design-evolution/n -> :instruction "最初の実装の方式と、その問題を 1 文で書く" :sample "The initial implementation used simple HTTP requests via the requests library, which failed on JavaScript-rendered single-page applications that dominate modern documentation and web frameworks.")
(defrule web-interaction-design-evolution/a1 -> :instruction "切り替えで解決したことを 1 文で書く" :sample "Switching to Crawl4AI with Playwright’s browser engine solved this, enabling full DOM rendering before content extraction.")
