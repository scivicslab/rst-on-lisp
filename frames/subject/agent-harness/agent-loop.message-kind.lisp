;;; one kind of message the loop yields: its name and what it reports, when it is emitted, what it carries, and what to know when reading it
;;; members: SystemMessage (with its four subtypes), AssistantMessage, UserMessage, StreamEvent, ResultMessage
(defrule message-kind -> :nucleus message-kind/n :elaboration-additional message-kind/when :elaboration-additional message-kind/carries :elaboration-set-member message-kind/subtypes :elaboration-additional message-kind/note)
(defrule message-kind/n -> :instruction "メッセージの種類の名前と、それが何を伝えるものかを 1 文で書く" :sample "SystemMessage: session lifecycle events.")
(defrule message-kind/when -> :instruction "それがいつ出るかを 1 文で書く。出る条件があれば条件も書く" :sample "StreamEvent: only emitted when partial messages are enabled.")
(defrule message-kind/carries -> :instruction "それが運ぶ中身を 1 文で書く" :sample "Each carries a single content block, such as text or a tool call, and the messages from one response share a message ID.")
(defrule message-kind/subtypes -> :instruction "種類がさらに副種類に分かれるなら、副種類 1 つにつき 1 項目で、名前と意味を書く。分かれなければ空にする"
  :sample "\"init\": session metadata for the run. / \"compact_boundary\": fires after compaction. / \"informational\": plain-text status banners from the loop. / \"worker_shutting_down\": the host is exiting or Remote Control disconnected."
  :kind bullet)
(defrule message-kind/note -> :instruction "読むときに知っておくべき注意を 1 文で書く。無ければ書かない" :sample "A small number of trailing system events, such as prompt_suggestion, can arrive after it, so iterate the stream to completion rather than breaking on the result.")
