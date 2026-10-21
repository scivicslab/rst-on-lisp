;;; one member of a data structure: its name and what it stands for, what it holds and in which unit, how others hold it
;;; and why, its limits, what it is used for or who sets it, and its parts
;;; from: ipv4.struct-member.lisp
(defrule member -> :nucleus member/n :definition member/def :comparison member/other :reason member/because :elaboration-additional member/limits
                   :elaboration-additional member/use :elaboration-set-member member/bits)
(defrule member/n -> :instruction "欄の名前と、名前が何の略かを 1 文で書く" :sample "ihl: This stands for Internet Header Length.")
(defrule member/def -> :instruction "欄が何を、どの単位で持つかを 1 文で書く" :sample "The length of the IPv4 header, measured in multiples of 4 bytes.")
(defrule member/other -> :instruction "同じ欄を別の版や別のプログラムではどう持つかを 1 文で書く。比べるものが無ければ書かない"
  :sample "The length of the IPv4 header is not fixed, as opposed to the header of IPv6, where the length is fixed (40 bytes).")
(defrule member/because -> :instruction "その違いや、その持ち方になっている理由を 1 文で書く。無ければ書かない" :sample "The reason is that the IPv4 header can include optional, varying length options.")
(defrule member/limits -> :instruction "欄の値の最小と最大、取るべき値、守るべき制約を 1〜2 文で書く。無ければ書かない"
  :sample "The minimum size of the IPv4 header is 20 bytes, when there are no options, and the maximum size is 60 bytes. The corresponding ihl values are 5 for minimum IPv4 header size, and 15 for the maximum size.")
(defrule member/use -> :instruction "その値が何に使われ、値によって入力に何が起きるか、またはどのメソッドがどの場合にその値を設定するかを 1〜2 文で書く"
  :sample "Each forwarding node decreases the ttl by 1. When it reaches 0, the packet is discarded, and a time exceeded ICMPv4 message is sent back; this avoids packets from being forwarded endlessly.")
(defrule member/bits -> :instruction "欄がいくつかの小さな部分（ビット、旗）に分かれているなら、部分 1 つにつき 1 項目で、値と意味を挙げる。分かれていなければ空にする"
  :sample "001 is MF (More Fragments). It is set for all fragments, except the last one. / 010 is DF (Don't Fragment)."
  :kind bullet)
