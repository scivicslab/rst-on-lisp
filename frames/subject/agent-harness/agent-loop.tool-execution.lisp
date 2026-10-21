;;; subject: claude-agent-sdk-agent-loop 4 Tool execution (4.2 Tool permissions, 4.3 Parallel tool execution): which tool calls the loop lets run without asking, which it blocks, and which it runs side by side
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-tools (s-tool-permissions s-parallel-tools)
;;; members: permission-items p-parallel
;;; children: none
;;; elsewhere: none
;;; left-out: 4.1 Built-in tools (three bullets that only point to MCP servers, custom tool handlers and skills, each explained on another page)
(defrule tool-execution -> permissions p-parallel)
(defrule permissions -> :instruction "ツールの呼び出しを許可する設定を、設定 1 つにつき 1 項目で、設定の名前と、それが何を自動で通すか、何を止めるか、何を決めるかを書く"
  :sample "allowed_tools / allowedTools auto-approves listed tools. / disallowed_tools / disallowedTools blocks listed tools, regardless of other settings. / permission_mode / permissionMode controls how much human oversight you want."
  :kind bullet)
(defrule p-parallel -> :nucleus p-parallel/n :elaboration-set-member p-parallel/readonly :elaboration-additional p-parallel/write :elaboration-additional p-parallel/custom)
(defrule p-parallel/n -> :instruction "1 ターンに複数のツール呼び出しがあるとき、並べて実行するか順に実行するかがツールで決まることを 1 文で書く" :sample "When Claude requests multiple tool calls in a single turn, both SDKs can run them concurrently or sequentially depending on the tool.")
(defrule p-parallel/readonly -> :instruction "並べて実行できるツールの種類を、例を挙げて 1 文で書く" :sample "Read-only tools (like Read, Glob, Grep, and MCP tools marked as read-only) can run concurrently.")
(defrule p-parallel/write -> :instruction "順に実行するツールの種類と、順にする理由を 1 文で書く" :sample "Tools that modify state (like Edit, Write, and Bash) run sequentially to avoid conflicts.")
(defrule p-parallel/custom -> :instruction "利用者が作ったツールの既定の実行の仕方と、並べて実行させる設定を 1〜2 文で書く。作れないなら書かない" :sample "Custom tools default to sequential execution. To enable parallel execution for a custom tool, set readOnlyHint in its annotations.")
