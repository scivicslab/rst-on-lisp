;;; one test that looks right and is wrong, why, and the right test
;;; members: p-fp-nan p-fp-zero
(defrule pitfall -> :nucleus pitfall/n :example pitfall/wrong :reason pitfall/cause :example pitfall/right)
(defrule pitfall/n -> :instruction "調べたいことを 1 文で書く" :sample "There are both positive and negative floating-point zeroes, 0.0 and -0.0.")
(defrule pitfall/wrong -> :instruction "正しく見えて誤っている書き方を示す" :kind code-block)
(defrule pitfall/cause -> :instruction "それが誤りである理由を 1 文で書く" :sample "All \"not a number\" values are considered distinct.")
(defrule pitfall/right -> :instruction "正しい書き方を示す" :kind code-block)
