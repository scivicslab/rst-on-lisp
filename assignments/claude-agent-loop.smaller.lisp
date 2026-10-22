;;; The concept classes of claude-agent-loop.lisp, made smaller (ConceptClasses_261022_oo01): a subclass that
;;; said nothing its superclass does not became a value of it. This file stands alone; it is a proposal.
;;; standalone
;;; book-file: /home/devteam/works/doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp
;;; done: assistant-message became a value of message: it said nothing message does not
;;; done: budget-headroom became a value of budget-cap: it said nothing budget-cap does not
;;; done: budget-cap became a value of resource-constraint: it said nothing resource-constraint does not
;;; done: effort-level became a value of reasoning-effort: it said nothing reasoning-effort does not
;;; done: hooks became a value of mechanism: it said nothing mechanism does not
;;; done: large-tool-outputs became a value of resource-constraint: it said nothing resource-constraint does not
;;; done: mcp-servers became a value of integration: it said nothing integration does not
;;; done: integration became a value of mechanism: it said nothing mechanism does not
;;; done: message-lifecycle became a value of the-agent-loop: it said nothing the-agent-loop does not
;;; done: model became a value of configuration-setting: it said nothing configuration-setting does not
;;; done: parallel-tool-execution became a value of execution-strategy: it said nothing execution-strategy does not
;;; done: execution-strategy became a value of mechanism: it said nothing mechanism does not
;;; done: quickstart became a value of onboarding-guide: it said nothing onboarding-guide does not
;;; done: onboarding-guide became a value of process: it said nothing process does not
;;; done: reasoning-effort became a value of configuration-setting: it said nothing configuration-setting does not
;;; done: session-store became a value of session-persistence: it said nothing session-persistence does not
;;; done: session-persistence became a value of configuration-setting: it said nothing configuration-setting does not
;;; done: sessions-and-continuity became a value of session-management: it said nothing session-management does not
;;; done: session-management became a value of mechanism: it said nothing mechanism does not
;;; done: stop-reason became a value of status-indicator: it said nothing status-indicator does not
;;; done: stream-event became a value of message: it said nothing message does not
;;; done: subagents became a value of subagent-architecture: it said nothing subagent-architecture does not
;;; done: subagent-architecture became a value of the-agent-loop: it said nothing the-agent-loop does not
;;; done: system-message became a value of message: it said nothing message does not
;;; done: the-agent-loop became a value of process: it said nothing process does not
;;; done: the-context-window became a value of context-capacity: it said nothing context-capacity does not
;;; done: context-capacity became a value of resource-constraint: it said nothing resource-constraint does not
;;; done: tool-permissions became a value of permission-mode: it said nothing permission-mode does not
;;; done: permission-mode became a value of configuration-setting: it said nothing configuration-setting does not
;;; done: turns became a value of turn: it said nothing turn does not
;;; done: turn became a value of mechanism: it said nothing mechanism does not
;;; done: user-message became a value of message: it said nothing message does not
(in-package :concepts)

(defclass configuration-setting ()
  ((values :documentation "Which values does it take, and what does each do")
   (default-behavior :documentation "What does it do if not set?")
   (usage :documentation "How is it used to enable session resumption?"))
  (:documentation "A parameter that dictates the operational behavior or security constraints of a system"))

(defclass mechanism ()
  ((timing :documentation "When does it fire?")
   (error-handling :documentation "What happens when limits are hit?")
   (scope :documentation "What does it connect and define?"))
  (:documentation "A functional component or feature that operates within a system to handle specific events or processes"))

(defclass message ()
  ((when-delivered :documentation "When, and on what event, the program is handed this message")
   (kinds :documentation "What kinds (subtypes) of it there are, and what each means")
   (carried-values :documentation "What values it carries, what each holds, and when each is present")
   (how-to-receive :documentation "How the program receives it and tells it apart from other messages")
   (cautions :documentation "What to watch for when reading it"))
  (:documentation "Something the agent loop hands to the program that drives it"))

(defclass process ()
  ((mechanism :documentation "How does it work?"))
  (:documentation "A sequence of steps or operations that a system performs to achieve a goal"))

(defclass resource-constraint ()
  ((context-accumulation :documentation "How does it affect context accumulation across turns?"))
  (:documentation "A limitation on the amount of data or memory available for processing within a single interaction"))

(defclass status-indicator ()
  ((values :documentation "Which values does it take, and what does each do"))
  (:documentation "A field that reports the specific condition or cause that terminated a generation process"))

(defclass result-message (message)
  ((how-it-ended :documentation "How the loop ended, and which value tells the endings apart"))
  (:documentation "The message that marks the end of the agent loop"))

(instance "AssistantMessage" message)
(instance "Budget headroom" resource-constraint)
(instance "budget cap" resource-constraint)
(instance "effort level" configuration-setting)
(instance "Hooks" mechanism)
(instance "large tool outputs" resource-constraint)
(instance "MCP servers" mechanism)
(instance "integration" mechanism)
(instance "message lifecycle" process)
(instance "model" configuration-setting)
(instance "parallel tool execution" mechanism)
(instance "execution strategy" mechanism)
(instance "quickstart" process)
(instance "onboarding guide" process)
(instance "reasoning effort" configuration-setting)
(instance "session_store" configuration-setting)
(instance "session persistence" configuration-setting)
(instance "Sessions and continuity" mechanism)
(instance "session management" mechanism)
(instance "stop_reason" status-indicator)
(instance "StreamEvent" message)
(instance "subagents" process)
(instance "subagent architecture" process)
(instance "SystemMessage" message)
(instance "the agent loop" process)
(instance "The context window" resource-constraint)
(instance "context capacity" resource-constraint)
(instance "tool permissions" configuration-setting)
(instance "Permission mode" configuration-setting)
(instance "turns" mechanism)
(instance "turn" mechanism)
(instance "UserMessage" message)

(assign "the agent loop" process
  (mechanism "title" "p-together-code" "glance-steps"))
(assign "message lifecycle" process
  (:aside "p-intro"))
(assign "SystemMessage" message
  (kinds "p-system-message"))
(assign "AssistantMessage" message
  (kinds "p-assistant-message"))
(assign "UserMessage" message
  (when-delivered "p-user-message"))
(assign "Permission mode" configuration-setting
  (values "permission-mode-table" "p-permission-mode-advice"))
(assign "model" configuration-setting
  (values "p-model"))
(assign "subagents" process
  (mechanism "efficient-items"))
(assign "Hooks" mechanism
  (timing "p-hooks-what" "hooks-table" "p-hooks-isolation"))
(assign "turns" mechanism
  (timing "turns-example")
  (error-handling "p-budget-subagents" "error-end-items" "autocompact-items")
  (:aside "p-autocompact-example"))
(assign "ResultMessage" result-message
  (how-it-ended "p-result-message" "p-result-what")
  (how-to-receive "handle-items")
  (kinds "result-table")
  (carried-values "p-result-field"))
(assign "stop_reason" status-indicator
  (values "p-result-stop-reason"))
(assign "tool permissions" configuration-setting
  (values "permission-items" "p-permission-mode-what"))
(assign "large tool outputs" resource-constraint
  (context-accumulation "p-consumes-note"))
(assign "StreamEvent" message
  (kinds "p-stream-event"))
(assign "MCP servers" mechanism
  (scope "builtin-items"))
(assign "parallel tool execution" mechanism
  (scope "p-parallel"))
(assign "Budget headroom" resource-constraint
  (context-accumulation "p-headroom" "budget-table")
  (:aside "guard-items"))
(assign "effort level" configuration-setting
  (values "p-effort-what" "effort-table")
  (default-behavior "p-effort-default"))
(assign "The context window" resource-constraint
  (context-accumulation "p-context-what" "consumes-table"))
(assign "Sessions and continuity" mechanism
  (scope "p-session-id" "p-session-resume"))
(assign "session_store" configuration-setting
  (usage "p-session-store"))
(assign "quickstart" process
  (mechanism "next-items"))
