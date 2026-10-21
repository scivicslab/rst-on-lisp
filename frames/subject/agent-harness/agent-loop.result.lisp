;;; subject: claude-agent-sdk-agent-loop 8 Handle the result: how the end of the loop is told apart, what each ending carries, and what to guard against
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-result
;;; members: p-result-what p-result-field guard-items error-end-items p-result-stop-reason (subtypes: each is one copy of agent-loop.result-subtype.lisp)
;;; children: each subtype is one copy of agent-loop.result-subtype.lisp
;;; elsewhere: none
;;; left-out: none
(defrule result -> p-result-what subtypes p-result-field guards error-end p-result-stop-reason)
(defrule p-result-what -> :nucleus p-result-what/n)
(defrule p-result-what/n -> :instruction "終了時のメッセージが何を伝え、終わり方をどの欄で見分けるかを 1〜2 文で書く" :sample "When the loop ends, the ResultMessage tells you what happened and gives you the output. The subtype field (available in both SDKs) is the primary way to check termination state.")
(defrule subtypes -> :instruction "終わり方の副種類を、1 行に 1 つ副種類の名前で挙げる" :frame "agent-loop.result-subtype.lisp")
(defrule p-result-field -> :nucleus p-result-field/n)
(defrule p-result-field/n -> :instruction "最終の文章がどの終わり方にだけ付くか、どの終わり方にも付く欄は何かを 1〜2 文で書く" :sample "The result field holds the final text output and is only present on the success variant, so always check the subtype before reading it. All result subtypes carry total_cost_usd, usage, num_turns, and session_id so you can track cost and resume even after errors.")
(defrule guards -> :instruction "結果を読むときの落とし穴を、1 つにつき 1 項目で、どんな場合に何が起きるかと、どう確かめるかで書く"
  :sample "After a session crash, the final result is an error_during_execution whose cost fields may be zeroed and whose stop_reason is null, and the process exits after emitting it. / The usage field covers only the main agent loop. Use modelUsage, or model_usage in Python, for whole-tree token and cost accounting."
  :kind bullet)
(defrule error-end -> :instruction "エラーで終わったとき、呼び出しの形ごとに、1 項目で、その後に起きることを書く"
  :sample "A single-shot query() call yields the final result message, then raises an error that includes the failure text, such as \"Reached maximum number of turns\". / A streaming input session stays alive, and you can keep sending messages, except after a session crash, which emits a final error_during_execution result and exits the process."
  :kind bullet)
(defrule p-result-stop-reason -> :nucleus p-result-stop-reason/n :elaboration-additional p-result-stop-reason/values :elaboration-additional p-result-stop-reason/on-error)
(defrule p-result-stop-reason/n -> :instruction "最後のターンでモデルが生成をやめた理由を示す欄を 1 文で書く" :sample "The result also includes a stop_reason field (string | null in TypeScript, str | None in Python) indicating why the model stopped generating on its final turn.")
(defrule p-result-stop-reason/values -> :instruction "よくある値と意味を 1 文で書く" :sample "Common values are end_turn (model finished normally), max_tokens (hit the output token limit), and refusal (the model declined the request).")
(defrule p-result-stop-reason/on-error -> :instruction "エラーの結果でこの欄がどの値になるかを 1 文で書く" :sample "On error results that the loop produced, stop_reason carries the value from the last assistant response before the loop ended; the result Claude Code synthesizes after a session crash carries null.")
