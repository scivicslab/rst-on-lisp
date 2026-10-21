;;; subject: opendev-terminal-agent-2603 2.4 Tool System: the actions the agent can take on its environment, organised by a registry into handler categories, with approval and hooks in front of every call
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/04_tool-system/04_tool-system.lisp / s1
;;; members: what
;;; children (:include / :frame, in the text's order): registry opendev.tool-system.registry.lisp, file-operations opendev.tool-system.file-operations.lisp, shell-execution opendev.tool-system.shell-execution.lisp, web-interaction opendev.tool-system.web-interaction.lisp, code-analysis opendev.tool-system.code-analysis.lisp, user-interaction opendev.tool-system.user-interaction.lisp, external-tools opendev.tool-system.external-tools.lisp, delegation opendev.tool-system.delegation.lisp
;;; elsewhere: none
;;; left-out: none
(defrule tool-system -> tool-system-what registry file-operations shell-execution web-interaction code-analysis user-interaction external-tools delegation)
(defrule tool-system-what -> :nucleus tool-system-what/n :elaboration-additional tool-system-what/a1 :elaboration-additional tool-system-what/a2)
(defrule tool-system-what/n -> :instruction "道具の仕組みが両立させる性質を 1 文で書く" :sample "The tools through which the agent interacts with the development environment form an extensible ecosystem that balances comprehensive capability with context efficiency, safety with flexibility, and built-in tools with dynamic discovery.")
(defrule tool-system-what/a1 -> :instruction "この節の構成と、各分類を挙げて 1 文で書く" :sample "Table 1 in Appendix A provides a complete catalog of all 35 built-in tools; the remainder of this section describes the registry architecture that organizes them into handler categories, then details each category: file operations, shell execution, web interaction, semantic code analysis via LSP, user interaction and task management, external tool discovery via MCP, and subagent delegation.")
(defrule tool-system-what/a2 -> :instruction "全分類にまたがる安全の構えを 1 文で書く" :sample "A defense-in-depth safety architecture spans all categories.")
(defrule registry -> :instruction "道具を分類して登録し、呼び出しを配る仕組みと、その前に置く承認とフックを説明する" :include "opendev.tool-system.registry.lisp" :heading "### Registry architecture and schema construction")
(defrule file-operations -> :instruction "ファイルの読み書きと検索の道具を説明する" :include "opendev.tool-system.file-operations.lisp" :heading "### File operations")
(defrule shell-execution -> :instruction "シェルの命令と、長く動く処理の扱いを説明する" :include "opendev.tool-system.shell-execution.lisp" :heading "### Shell execution and background tasks")
(defrule web-interaction -> :instruction "ウェブの取得と閲覧の道具を説明する" :include "opendev.tool-system.web-interaction.lisp" :heading "### Web interaction")
(defrule code-analysis -> :instruction "言語サーバを使った意味に基づくコードの解析と編集の道具を説明する" :include "opendev.tool-system.code-analysis.lisp" :heading "### Multi-language semantic code analysis via LSP")
(defrule user-interaction -> :instruction "利用者への質問、作業の管理、計画の承認の道具を説明する" :include "opendev.tool-system.user-interaction.lisp" :heading "### User interaction, task management, and planning")
(defrule external-tools -> :instruction "外部の道具を必要なときだけ見つけて使う仕組みを説明する" :include "opendev.tool-system.external-tools.lisp" :heading "### Token-efficient external tool discovery via MCP")
(defrule delegation -> :instruction "部下への委譲、指示書の取り込み、一括実行の道具を説明する" :include "opendev.tool-system.delegation.lisp" :heading "### Subagent delegation, skills, and batch execution")
