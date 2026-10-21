;;; one entry of a quick reference: the signature of a method or macro, and what it does, in one or two sentences
;;; members: every entry of "Methods" (4/Sec18) and "Macros" (4/Sec45)
(defrule entry -> :nucleus entry/n :elaboration-additional entry/does)
(defrule entry/n -> :instruction "メソッドかマクロの宣言を、戻り値の型と引数を含めて書く" :sample "int ip_fragment(struct sk_buff *skb, int (*output)(struct sk_buff *));")
(defrule entry/does -> :instruction "それが何をするか、どこから呼ばれるかを 1〜2 文で書く。名前が変わった経緯や引数の値の一覧の置き場所があれば添える"
  :sample "This method is the main defragmentation method. It processes an incoming IP fragment. The second parameter, user, indicates where this method was invoked from.")
