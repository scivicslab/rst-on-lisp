;;; subject: opendev-terminal-agent-2603 2.2.4 REPL Command Dispatch: how input that needs no model is handled directly by commands, and how commands differ from the tools the model calls
;;; made-from: doc_Base012/docs/Papers-AgentHarness/opendev-terminal-agent/02_agent-core/02_agent-core.lisp / p-dual-path-dispatch p-command-handler p-handler-categories p-command-side-effects p-commands-versus-tools
;;; members: split handler groups effects versus-tools
;;; children (:include / :frame, in the text's order): group-list (each item one copy of opendev.agent-core.command-group.lisp)
;;; elsewhere: none
;;; left-out: the caption of Figure 7
(defrule repl-dispatch -> repl-dispatch-split repl-dispatch-handler repl-dispatch-groups group-list repl-dispatch-effects repl-dispatch-versus-tools)
(defrule repl-dispatch-split -> :reason repl-dispatch-split/not-all :nucleus repl-dispatch-split/dual-path)
(defrule repl-dispatch-split/not-all -> :instruction "モデルを通さずに済む入力があることと、その例を書く" :sample "However, not all input requires LLM involvement. Session management, mode switching, model selection, and MCP server configuration are deterministic operations that can be handled directly by the REPL without invoking the agent.")
(defrule repl-dispatch-split/dual-path -> :instruction "入力の境界で経路を分ける仕組みを 1 文で書く" :sample "The system therefore implements a dual-path dispatch at the input boundary: if the input begins with a “ / ” prefix, it is routed to a registered command handler; otherwise, it proceeds to the query processor and enters the agent loop.")
(defrule repl-dispatch-handler -> :nucleus repl-dispatch-handler/common-base :elaboration-object-attribute repl-dispatch-handler/injected)
(defrule repl-dispatch-handler/common-base -> :instruction "命令の取り扱い部品の共通の親と、その役割を 1 文で書く" :sample "All command handlers extend a common abstract base class that provides the handler interface and standardized output formatting.")
(defrule repl-dispatch-handler/injected -> :instruction "部品が共有の管理部品を得る方法を 1 文で書く" :sample "Each handler receives a reference to the REPL instance at construction, granting access to the shared managers (session, mode, configuration, MCP) through explicit dependency injection rather than global state.")
(defrule repl-dispatch-groups -> :instruction "取り扱い部品の種類の数を 1 文で書く" :sample "As shown in Figure 7, nine handler classes cover the system’s interactive control surface.")
(defrule group-list -> :instruction "命令の種類を、1 行に 1 つ種類の名前で挙げる" :frame "opendev.agent-core.command-group.lisp")
(defrule repl-dispatch-effects -> :nucleus repl-dispatch-effects/shared-state :example repl-dispatch-effects/examples)
(defrule repl-dispatch-effects/shared-state -> :instruction "命令が共有の状態を変更することを 1 文で書く" :sample "Commands do not produce isolated outputs; they modify shared state that subsequent agent interactions depend on.")
(defrule repl-dispatch-effects/examples -> :instruction "命令の副作用の具体例を 1 文で書く" :sample "For example, /models triggers a full reconstruction of the agent factory, rebuilding tool registries and system prompts with the new model’s capabilities. /mcp connect discovers and registers new tools from the connected server, expanding the tool schemas available to the agent on its next turn. /mode plan sets a flag that causes the query processor to activate planning behavior on the next query.")
(defrule repl-dispatch-versus-tools -> :nucleus repl-dispatch-versus-tools/distinction :antithesis repl-dispatch-versus-tools/tools :result repl-dispatch-versus-tools/separation)
(defrule repl-dispatch-versus-tools/distinction -> :instruction "命令とエージェントの道具の区別の性質を 1 文で書く" :sample "The distinction between REPL commands and agent tools is architectural, not incidental.")
(defrule repl-dispatch-versus-tools/tools -> :instruction "道具の性質を命令と対比して 1 文で書く" :sample "Agent tools, by contrast, are selected by the LLM during reasoning, executed through the tool registry with pre- and post-execution hooks, subject to user approval based on the configured autonomy level, and tracked by the undo manager.")
(defrule repl-dispatch-versus-tools/separation -> :instruction "この分離で得られることを 1 文で書く" :sample "This separation ensures that system-level operations (changing models, managing servers, resetting sessions) remain fast and predictable, while delegating open-ended problem-solving to the agent loop.")
