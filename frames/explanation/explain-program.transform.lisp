;;; one transformation the program does in one direction and undoes in the other (fragmentation and defragmentation,
;;; compression and decompression): why it is needed, which method does it and from where, its arguments, the data
;;; structure it is built on, its outline, its time limit, its variant paths, its methods walked through, and what the
;;; reader learned
;;; from: ipv4.packet-transform.lisp
(defrule transform -> t/need t/args t/args/list t/structure t/structure/code t/outline t/limit variants methods t/end :heading "### {item}")
(defrule t/need -> :background t/need/limit :nucleus t/need/n :elaboration-additional t/need/where :elaboration-additional t/need/reverse)
(defrule t/need/limit -> :instruction "この変換が要る原因になる限界（大きさ、順序）を、具体的な値で 1〜2 文で書く。変換の定義から始めるなら書かない"
  :sample "The network interface has a limit on the size of a packet. Usually in 10/100/1000 Mb/s Ethernet networks, it is 1500 bytes.")
(defrule t/need/n -> :instruction "変換が何をするかを 1 文で書く" :sample "Defragmentation is the process of reassembling all the fragments of a packet, which all have the same id in the IPv4 header, into one buffer.")
(defrule t/need/where -> :instruction "変換を行うメソッドとそのファイル、どのメソッドから呼ばれるかを 1 文で書く"
  :sample "The main method that handles defragmentation in the Rx path is ip_defrag() (net/ipv4/ip_fragment.c), which is called from ip_local_deliver().")
(defrule t/need/reverse -> :instruction "逆の変換をどこで誰が行うか、ほかにこの変換が要る場所を 1 文で書く。無ければ書かない"
  :sample "There are other places where defragmentation might be needed, such as in firewalls, where the content of the packet should be known in order to be able to inspect it.")
(defrule t/args -> :nucleus t/args/n :elaboration-additional t/args/each)
(defrule t/args/n -> :instruction "メソッドの宣言を示すか、メソッドがいくつの引数を取るかを 1 文で書く" :sample "The ip_defrag() method has two arguments:")
(defrule t/args/each -> :instruction "引数ごとに、何を渡すかを 1〜2 文で書く。値に選択肢があれば、その一覧を次に挙げると言う"
  :sample "the first is the SKB and the second is a 32-bit field which indicates the point where the method was invoked. Its value can be the following:")
(defrule t/args/list -> :instruction "引数が取る値を、1 項目に 1 つ、どこから呼ばれたときの値かとともに挙げる。値の選択肢が無ければ空にする"
  :sample "IP_DEFRAG_LOCAL_DELIVER when it was called from ip_local_deliver(). / IP_DEFRAG_CALL_RA_CHAIN when it was called from ip_call_ra_chain()." :kind bullet)
(defrule t/structure -> :nucleus t/structure/n :elaboration-additional t/structure/key :comparison t/structure/shared)
(defrule t/structure/n -> :instruction "変換を支えるデータ構造が何かを 1 文で書く。無ければ段落ごと書かない" :sample "The implementation of defragmentation is based on a hash table of ipq objects.")
(defrule t/structure/key -> :instruction "そのデータ構造を何で引くかを 1 文で書く" :sample "The hash function (ipqhashfn) has four arguments: fragment id, source address, destination address, and protocol:")
(defrule t/structure/shared -> :instruction "その仕組みを別の版や別のプログラムと共有していれば、それを 1 文で書く。無ければ書かない" :sample "Note that the logic of IPv4 defragmentation is shared with its IPv6 counterpart.")
(defrule t/structure/code -> :instruction "データ構造の定義を示す。上の段落を書かなければ空にする" :kind code-block)
(defrule t/outline -> :nucleus t/outline/n :elaboration-process-step t/outline/steps :elaboration-additional t/outline/errors)
(defrule t/outline/n -> :instruction "メソッドの長さを 1 文で言う。あらましを書かないなら段落ごと書かない" :sample "The ip_defrag() method is quite short.")
(defrule t/outline/steps -> :instruction "メソッドがどのメソッドをどの順に呼ぶかを、3〜5 文で書く"
  :sample "First it makes sure there is enough memory by calling the ip_evictor() method. Then it tries to find an ipq for the SKB by calling the ip_find() method. Then it calls the ip_frag_queue() method to add the fragment to a linked list of fragments.")
(defrule t/outline/errors -> :instruction "途中で失敗したとき、統計と返す値がどうなるかを 1〜2 文で書く"
  :sample "If the size of the new packet exceeds the highest permitted size (which is 65535), the ip_frag_reasm() method updates the statistics (IPSTATS_MIB_REASMFAILS) and returns -E2BIG.")
(defrule t/limit -> :nucleus t/limit/n :otherwise t/limit/expired :enablement t/limit/set)
(defrule t/limit/n -> :instruction "変換に時間の限りがあれば 1 文で書く。無ければ段落ごと書かない" :sample "Constructing a packet from all its fragments should be done in a specified time interval.")
(defrule t/limit/expired -> :instruction "限りを過ぎたときに何が起き、誰に何が知らされるかを 1 文で書く"
  :sample "If it's not completed within that interval, the ip_expire() method will send an ICMPv4 message of \"Time Exceeded\" with \"Fragment Reassembly Time Exceeded\" code.")
(defrule t/limit/set -> :instruction "限りを設定する項目と既定の値を 1 文で書く" :sample "The defragmentation time interval can be set by the following procfs entry: /proc/sys/net/ipv4/ipfrag_time. It is 30 seconds by default.")
(defrule variants -> :instruction "変換のメソッドに道筋が複数あれば、1 行に 1 つ道筋の名前で挙げる。無ければ空にする" :frame "explain-program.variant.lisp")
(defrule methods -> :instruction "変換のメソッドと、それが呼ぶメソッドを、呼ばれる順に、1 行に 1 つ挙げる" :frame "explain-program.operation.lisp")
(defrule t/end -> :summary-n t/end/learned :nucleus t/end/next)
(defrule t/end/learned -> :instruction "この変換について読み手が何を知ったかを 1 文でまとめる"
  :sample "This section dealt with the implementation of slow path in fragmentation, and this ends the discussion of fragmentation in the Tx path.")
(defrule t/end/next -> :instruction "次の節が何を扱い、この節とどうつながるかを 1 文で書く" :sample "The next section discusses defragmentation—the opposite of fragmentation.")
