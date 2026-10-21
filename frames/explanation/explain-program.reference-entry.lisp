;;; one entry of a quick reference: the signature of a method or macro, and what it does, in one or two sentences
;;; from: ipv4.reference-entry.lisp
(defrule ref-entry -> :nucleus ref-entry/n :elaboration-additional ref-entry/does)
(defrule ref-entry/n -> :instruction "メソッドかマクロの宣言を、戻り値の型と引数を含めて書く" :sample "int ip_fragment(struct sk_buff *skb, int (*output)(struct sk_buff *));")
(defrule ref-entry/does -> :instruction "それが何をするか、どこから呼ばれるかを 1〜2 文で書く。名前が変わった経緯や引数の値の一覧の置き場所があれば添える"
  :sample "This method is the main defragmentation method. It processes an incoming IP fragment. The second parameter, user, indicates where this method was invoked from.")
