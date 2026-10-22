;;; Paragraphs of claude-agent-loop assigned to what can be said of each concept's class
;;; (ConceptClasses_261022_oo01, FrameMakingWorkflow_261022_oo01 step 3), from tmp/concept-tree/claude-agent-loop.lisp.
;;; The classes below were added, or had slots added, while assigning. They are proposals: whether they join
;;; rst-on-lisp/concepts/ is decided by a person.
;;; book-file: /home/devteam/works/doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp
(in-package :concepts)

(defclass process ()
  ((mechanism :documentation "How does it work?"))
  (:documentation "A sequence of steps or operations that a system performs to achieve a goal"))

(defclass the-agent-loop (process) ()
  (:documentation "How the agent loop works"))

(defclass message-lifecycle (the-agent-loop) ()
  (:documentation "Understand the message lifecycle, tool execution, context window, and architecture that power your SDK agents."))

(defclass configuration-setting ()
  ((values :documentation "Which values does it take, and what does each do")
   (default-behavior :documentation "What does it do if not set?")
   (usage :documentation "How is it used to enable session resumption?"))
  (:documentation "A parameter that dictates the operational behavior or security constraints of a system"))

(defclass permission-mode (configuration-setting) ()
  (:documentation "Mode | Behavior | Use case \"default\" | Tool calls that need approval and aren't covered by allow rules trigger your canUseTool callback; no callback means deny  ..."))

(defclass model (configuration-setting) ()
  (:documentation "Set the model option to choose which model runs the session."))

(defclass subagent-architecture (the-agent-loop) ()
  (:documentation "A pattern where subagents handle subtasks and return only final responses to manage context space and tool scoping"))

(defclass subagents (subagent-architecture) ()
  (:documentation "Use subagents for subtasks. A subagent returns only its final response, so your main agent's context grows by a summary, not by the subtask's transcript. Be sel ..."))

(defclass mechanism ()
  ((timing :documentation "When does it fire?")
   (error-handling :documentation "What happens when limits are hit?")
   (scope :documentation "What does it connect and define?"))
  (:documentation "A functional component or feature that operates within a system to handle specific events or processes"))

(defclass hooks (mechanism) ()
  (:documentation "Hooks are callbacks that fire at specific points in the loop: before a tool runs, after it returns, when the agent finishes, and so on."))

(defclass turn (mechanism) ()
  (:documentation "A unit of interaction in the agent loop, consisting of an assistant message (often containing tool calls) and the subsequent user message (containing tool results or feedback)"))

(defclass turns (turn) ()
  (:documentation "Turn 1: Claude calls Bash to run npm test. The SDK yields an AssistantMessage with the tool call, executes the command, then yields a UserMessage with the outpu ..."))

(defclass status-indicator ()
  ((values :documentation "Which values does it take, and what does each do"))
  (:documentation "A field that reports the specific condition or cause that terminated a generation process"))

(defclass stop-reason (status-indicator) ()
  (:documentation "The result also includes a stop_reason field (string | null in TypeScript, str | None in Python) indicating why the model stopped generating on its final turn."))

(defclass tool-permissions (permission-mode) ()
  (:documentation "allowed_tools / allowedTools auto-approves listed tools. A read-only agent with [\"Read\", \"Glob\", \"Grep\"] in its allowed tools list runs those tools without prom ..."))

(defclass resource-constraint ()
  ((context-accumulation :documentation "How does it affect context accumulation across turns?"))
  (:documentation "A limitation on the amount of data or memory available for processing within a single interaction"))

(defclass large-tool-outputs (resource-constraint) ()
  (:documentation "Large tool outputs consume significant context. Reading a big file or running a command with verbose output can use thousands of tokens in a single turn."))

(defclass integration (mechanism) ()
  (:documentation "A mechanism that connects external services with MCP servers (databases, browsers, APIs) and defines custom tools with custom tool handlers"))

(defclass mcp-servers (integration) ()
  (:documentation "Connect external services with MCP servers (databases, browsers, APIs). Define custom tools with custom tool handlers. Load project skills via setting sources f ..."))

(defclass execution-strategy (mechanism) ()
  (:documentation "A mechanism that determines the temporal ordering (concurrent or sequential) of tool calls within a single turn"))

(defclass parallel-tool-execution (execution-strategy) ()
  (:documentation "When Claude requests multiple tool calls in a single turn, both SDKs can run them concurrently or sequentially depending on the tool."))

(defclass budget-cap (resource-constraint) ()
  (:documentation "A constraint that limits the total estimated monetary spend of a session, stopping the execution loop when a defined maximum budget is reached"))

(defclass budget-headroom (budget-cap) ()
  (:documentation "Claude Code compares spend with the max_budget_usd / maxBudgetUsd cap after model responses arrive."))

(defclass reasoning-effort (configuration-setting) ()
  (:documentation "A configuration setting that controls the depth and amount of reasoning applied by the model"))

(defclass effort-level (reasoning-effort) ()
  (:documentation "The effort option controls how much reasoning Claude applies."))

(defclass context-capacity (resource-constraint) ()
  (:documentation "A constraint that limits the total amount of information (tokens) available to the model during a session, affecting memory and processing capacity rather than monetary cost"))

(defclass the-context-window (context-capacity) ()
  (:documentation "The context window is the total amount of information available to Claude during a session. It does not reset between turns within a session."))

(defclass session-management (mechanism) ()
  (:documentation "A mechanism that maintains state and context across multiple interactions by creating, tracking, and resuming sessions"))

(defclass sessions-and-continuity (session-management) ()
  (:documentation "Each interaction with the SDK creates or continues a session. Capture the session ID from ResultMessage.session_id (available in both SDKs) to resume later."))

(defclass session-persistence (configuration-setting) ()
  (:documentation "A configuration setting that specifies an adapter to mirror session transcripts to an external backend, enabling session resumption across stateless or serverless environments"))

(defclass session-store (session-persistence) ()
  (:documentation "To resume sessions across stateless containers or serverless hosts, pass a session_store / sessionStore adapter so the SDK mirrors transcripts to your own backe ..."))

(defclass onboarding-guide (process) ()
  (:documentation "A guide for installing the SDK and running a full example end to end"))

(defclass quickstart (onboarding-guide) ()
  (:documentation "Haven't run an agent yet? Start with the quickstart to get the SDK installed and see a full example running end to end. Ready to hook into your project? Load CL ..."))

(assign "the agent loop" the-agent-loop
  (mechanism "title" "p-together-code" "glance-steps"))
(assign "message lifecycle" message-lifecycle
  (:aside "p-intro"))
(assign "SystemMessage" system-message
  (kinds "p-system-message"))
(assign "AssistantMessage" assistant-message
  (kinds "p-assistant-message"))
(assign "UserMessage" user-message
  (when-delivered "p-user-message"))
(assign "Permission mode" permission-mode
  (values "permission-mode-table" "p-permission-mode-advice"))
(assign "model" model
  (values "p-model"))
(assign "subagents" subagents
  (mechanism "efficient-items"))
(assign "Hooks" hooks
  (timing "p-hooks-what" "hooks-table" "p-hooks-isolation"))
(assign "turns" turns
  (timing "turns-example")
  (error-handling "p-budget-subagents" "error-end-items" "autocompact-items")
  (:aside "p-autocompact-example"))
(assign "ResultMessage" result-message
  (how-it-ended "p-result-message" "p-result-what")
  (how-to-receive "handle-items")
  (kinds "result-table")
  (carried-values "p-result-field"))
(assign "stop_reason" stop-reason
  (values "p-result-stop-reason"))
(assign "tool permissions" tool-permissions
  (values "permission-items" "p-permission-mode-what"))
(assign "large tool outputs" large-tool-outputs
  (context-accumulation "p-consumes-note"))
(assign "StreamEvent" stream-event
  (kinds "p-stream-event"))
(assign "MCP servers" mcp-servers
  (scope "builtin-items"))
(assign "parallel tool execution" parallel-tool-execution
  (scope "p-parallel"))
(assign "Budget headroom" budget-headroom
  (context-accumulation "p-headroom" "budget-table")
  (:aside "guard-items"))
(assign "effort level" effort-level
  (values "p-effort-what" "effort-table")
  (default-behavior "p-effort-default"))
(assign "The context window" the-context-window
  (context-accumulation "p-context-what" "consumes-table"))
(assign "Sessions and continuity" sessions-and-continuity
  (scope "p-session-id" "p-session-resume"))
(assign "session_store" session-store
  (usage "p-session-store"))
(assign "quickstart" quickstart
  (mechanism "next-items"))
