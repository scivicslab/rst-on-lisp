;;; one step of walking through a method's code: what this piece of code does (and why, when it is not obvious), then
;;; the piece of code itself
;;; members: the sentence-and-code pairs that make up most of 4/Sec3, 4/Sec5 (ip_rcv_options, ip_options_compile),
;;;          4/Sec8, 4/Sec10 (ip_queue_xmit, ip_append_data), 4/Sec12, 4/Sec13, 4/Sec14, 4/Sec15, e.g. "Fetch the IPv4 header
;;;          from the SKB:" + iph = ip_hdr(skb);
(defrule step -> :nucleus step/n :reason step/because :example step/code)
(defrule step/n -> :instruction "このコードの部分が何をするかを、命令の形か「〜する」の形で 1 文で書き、コロンで終える"
  :sample "Fetch the ip_options object from the inet_skb_parm object which is associated to the SKB:")
(defrule step/because -> :instruction "そうする理由が自明でなければ、ヘッダの欄の単位や前の段階の結果を根拠に 1 文で書く。自明なら書かない"
  :sample "The frag_off field of the IPv4 header is measured in multiples of 8 bytes, so divide the offset by 8:")
(defrule step/code -> :instruction "そのコードの部分を、前後を「. . .」で省いて示す" :kind code-block)
