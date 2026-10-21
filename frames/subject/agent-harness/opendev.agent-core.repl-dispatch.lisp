;;; subject: opendev-terminal-agent-2603 2.2.4 REPL Command Dispatch: how input that needs no model is handled directly by commands, and how commands differ from the tools the model calls
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / p-dual-path-dispatch p-command-handler p-handler-categories p-command-side-effects p-commands-versus-tools
;;; members: groups effects
;;; moved into design-decision items: p-dual-path-dispatch (input that needs no model is handled by commands); p-command-handler (a common base class with injected managers); p-commands-versus-tools (commands kept apart from agent tools)
;;; children (:include / :frame, in the text's order): decisions (each item one copy of opendev.design-decision.lisp), group-list (each item one copy of opendev.agent-core.command-group.lisp)
;;; elsewhere: none
;;; left-out: the caption of Figure 7
(defrule repl-dispatch -> decisions repl-dispatch-groups group-list repl-dispatch-effects)
(defrule decisions -> :instruction "入力の振り分けで下した設計の決定を、1 行に 1 つ決定の名前で挙げる。モデルを通さない経路、命令の取り扱い部品の作り、命令と道具の分離のうち、このハーネスにあるもの" :frame "opendev.design-decision.lisp")
(defrule repl-dispatch-groups -> :instruction "取り扱い部品の種類の数を 1 文で書く" :sample "As shown in Figure 7, nine handler classes cover the system’s interactive control surface.")
(defrule group-list -> :instruction "命令の種類を、1 行に 1 つ種類の名前で挙げる" :frame "opendev.agent-core.command-group.lisp")
(defrule repl-dispatch-effects -> :nucleus repl-dispatch-effects/shared-state :example repl-dispatch-effects/examples)
(defrule repl-dispatch-effects/shared-state -> :instruction "命令が共有の状態を変更することを 1 文で書く" :sample "Commands do not produce isolated outputs; they modify shared state that subsequent agent interactions depend on.")
(defrule repl-dispatch-effects/examples -> :instruction "命令の副作用の具体例を 1 文で書く" :sample "For example, /models triggers a full reconstruction of the agent factory, rebuilding tool registries and system prompts with the new model’s capabilities. /mcp connect discovers and registers new tools from the connected server, expanding the tool schemas available to the agent on its next turn. /mode plan sets a flag that causes the query processor to activate planning behavior on the next query.")
