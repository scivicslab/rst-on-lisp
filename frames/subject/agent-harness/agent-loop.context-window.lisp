;;; subject: agent-harness / claude-agent-sdk-agent-loop 6 The context window: what the model can see in a session, what fills it, how it is compacted, and how to keep it small
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-context (s-what-consumes s-autocompact s-keep-efficient)
;;; members: p-context-what p-consumes-note autocompact-items efficient-items (sources: each is one copy of agent-loop.context-source.lisp)
;;; children: each source of context is one copy of agent-loop.context-source.lisp
;;; elsewhere: none
;;; left-out: the sample CLAUDE.md section that lists what a summary must preserve (a sample of use)
(defrule context-window -> p-context-what sources p-consumes-note compaction efficiency)
(defrule p-context-what -> :nucleus p-context-what/n :elaboration-additional p-context-what/accumulates :elaboration-additional p-context-what/cache)
(defrule p-context-what/n -> :instruction "文脈の窓が何で、ターンの間にどうなるかを 1〜2 文で書く" :sample "The context window is the total amount of information available to Claude during a session. It does not reset between turns within a session.")
(defrule p-context-what/accumulates -> :instruction "何が積み上がるかを列挙して 1 文で書く" :sample "Everything accumulates: the system prompt, tool definitions, conversation history, tool inputs, and tool outputs.")
(defrule p-context-what/cache -> :instruction "ターンの間で変わらない内容の扱いと、その効果を 1 文で書く" :sample "Content that stays the same across turns (system prompt, tool definitions, CLAUDE.md) is automatically prompt cached, which reduces cost and latency for repeated prefixes.")
(defrule sources -> :instruction "文脈を使うものを、1 行に 1 つ、名前で挙げる" :frame "agent-loop.context-source.lisp")
(defrule p-consumes-note -> :nucleus p-consumes-note/n :elaboration-additional p-consumes-note/grows)
(defrule p-consumes-note/n -> :instruction "最も大きく文脈を使うものと、1 ターンでの大きさの目安を 1〜2 文で書く" :sample "Large tool outputs consume significant context. Reading a big file or running a command with verbose output can use thousands of tokens in a single turn.")
(defrule p-consumes-note/grows -> :instruction "ターンが増えると文脈がどうなるかを 1 文で書く" :sample "Context accumulates across turns, so longer sessions with many tool calls build up significantly more context than short ones.")
(defrule compaction -> :instruction "文脈が一杯になったときの自動の圧縮を、利用者が関われる点ごとに 1 項目ずつ、点の名前と、何ができるかで書く"
  :sample "Summarization instructions in CLAUDE.md: The compactor reads your CLAUDE.md like any other context, so you can include a section telling it what to preserve when summarizing. / PreCompact hook: Run custom logic before compaction occurs, for example to archive the full transcript. / Manual compaction: Send /compact as a prompt string to trigger compaction on demand."
  :kind bullet)
(defrule efficiency -> :instruction "文脈を小さく保つ方法を、方法 1 つにつき 1 項目で、方法の名前と、それが文脈をどう減らすかを書く"
  :sample "Use subagents for subtasks. A subagent returns only its final response, so your main agent's context grows by a summary, not by the subtask's transcript. / Use lower effort for routine tasks. Set effort to \"low\" for agents that only need to read files or list directories."
  :kind bullet)
