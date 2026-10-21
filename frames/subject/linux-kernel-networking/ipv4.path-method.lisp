;;; one method on a path, walked through: what it is and where it is called from, then its code steps and checks in order
;;; members: ip_rcv, ip_rcv_finish (4/Sec3), ip_route_input_noref, ip_route_input_mc, ipmr_queue_xmit, ipmr_forward_finish (4/Sec4),
;;;          ip_queue_xmit, ip_append_data (4/Sec10), ip_forward, ip_forward_finish (4/Sec15)
(defrule method -> method/intro method/steps :heading "#### {item}")
(defrule method/intro -> :nucleus method/intro/n :elaboration-additional method/intro/from)
(defrule method/intro/n -> :instruction "このメソッドが道筋で何を受け持つかを 1 文で書く" :sample "The ipmr_forward_finish() method is very short and is shown here in its entirety.")
(defrule method/intro/from -> :instruction "どのメソッドからどんな条件で呼ばれるかを 1 文で書く。前のメソッドの説明で分かるなら書かない"
  :sample "Now, assuming that there are no netfilter NF_INET_FORWARD hooks, the ip_forward_finish() method is invoked:")
(defrule method/steps -> :instruction "このメソッドのコードを先頭から、1 行に 1 つ、段階の名前で挙げる。パケットを落とす検査は検査と分かる名前にする" :frame "ipv4.code-step.lisp")
