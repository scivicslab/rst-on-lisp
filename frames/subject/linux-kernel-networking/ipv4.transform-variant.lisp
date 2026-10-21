;;; one variant path of a transformation (fast path, slow path): when it is taken, how the header is set for the first,
;;; middle and last piece, the steps of its loop, and what happens after the loop on success and on failure
;;; members: Fast Path (4/Sec12), Slow Path (4/Sec13)
(defrule variant -> variant/when variant/fields variant/steps variant/after variant/end :heading "#### {item}")
(defrule variant/when -> :nucleus variant/when/n :otherwise variant/when/fallback)
(defrule variant/when/n -> :instruction "この道筋がどの条件のパケットに使われ、それを何で調べるかを 1 文で書く"
  :sample "First a check is performed to see whether the packet should be handled in the fast path by calling the skb_has_frag_list() method, which simply checks that skb_shinfo(skb)->frag_list is not NULL;")
(defrule variant/when/fallback -> :instruction "条件が満たされないとき、どの道筋に移るかを 1 文で書く。この道筋が最後の手段なら書かない"
  :sample "if something is not valid, the fallback to the slow path mechanism is activated (simply by calling goto slow_path).")
(defrule variant/fields -> :nucleus variant/fields/first :elaboration-set-member variant/fields/middle :elaboration-set-member variant/fields/last)
(defrule variant/fields/first -> :instruction "最初の断片のヘッダの欄にどの値を入れるかを 1 文で書く。前の道筋と同じなら段落ごと書かない"
  :sample "For the first fragment, the offset should be 0, and the flag should be IP_MF (More Fragments).")
(defrule variant/fields/middle -> :instruction "途中の断片の欄の値を 1 文で書く" :sample "For all other fragments except the last one, the IP_MF flag should be set, and the lower 13 bits should be the fragment offset (measured in units of 8 bytes).")
(defrule variant/fields/last -> :instruction "最後の断片の欄の値を 1 文で書く" :sample "For the last fragment, the IP_MF flag should not be set, but the lower 13 bits will still hold the fragment offset.")
(defrule variant/steps -> :instruction "繰り返しの中の段階を、コードの順に、1 行に 1 つ何をする段階かで挙げる" :frame "ipv4.code-step.lisp")
(defrule variant/after -> :instruction "繰り返しが終わった後に、成功と失敗それぞれで、統計、解放、返す値がどうなるかを、1 行に 1 つ挙げる" :frame "ipv4.code-step.lisp")
(defrule variant/end -> :nucleus variant/end/n)
(defrule variant/end/n -> :instruction "読み手がこの道筋を理解したことを 1 文で確かめる" :sample "You should now have a good understanding of the fast path in fragmentation and how it is implemented.")
