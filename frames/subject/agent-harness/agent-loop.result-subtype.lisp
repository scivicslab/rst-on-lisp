;;; one way a run ends: its subtype name, what happened, and whether the final text is present
;;; members: success, error_max_turns, error_max_budget_usd, error_during_execution, error_max_structured_output_retries
(defrule subtype -> :nucleus subtype/n :elaboration-additional subtype/text)
(defrule subtype/n -> :instruction "副種類の名前と、何が起きたかを書く" :sample "Hit the maxTurns limit before finishing")
(defrule subtype/text -> :instruction "最終の文章の欄が使えるかを書く" :sample "Yes")
