;;; one flow through a program (a usage scenario, a path data takes): what it does and from whose side, the components
;;; it involves, its entry methods, a mechanism met on the way, its figure (sequence diagram, path figure) read step by
;;; step and branch by branch, the design decisions it involves, the general concepts it shows, the operations it runs
;;; through with their code, the clients that start it, trying it out, and what the reader learned
;;; from: design.use-case.lisp (use-case), implementation.scenario.lisp (scenario), ipv4.path.lisp (path); a flow told
;;;       in a design has the design members, a flow told in code has the code members, and one told both ways has both
;;; links: links/explanation/explain-program.tsv (which rule of each integrated frame each rule here was made from)
(defrule flow -> flow/what flow/parts flow/entries flow/mechanism flow/figure flow/figure/img flow/interactions flow/branches
                 flow/decisions flow/concepts flow/operations flow/clients flow/try flow/end :heading "### {item}")
;; what the flow does, from whose side, and in what order it is read
(defrule flow/what -> :nucleus flow/what/n :elaboration-additional flow/what/shows :elaboration-additional flow/what/order)
(defrule flow/what/n -> :instruction "この流れが何をするか（誰の立場から何をする場面か、データをどこからどこへ渡す道筋か）を 1 文で書く"
  :sample "We now switch to the buyer's perspective, and explore what happens when a buyer needs to find a file. / The IPv4 layer provides the means for the layer above it, the transport layer (L4), to send packets by passing these packets to the link layer (L2).")
(defrule flow/what/shows -> :instruction "この流れで、入力の種類や使い手ごとの違いを示すなら、それを 1 文で書く。無ければ書かない"
  :sample "You'll see some differences between handling transmission of TCPv4 packets in IPv4 and handling transmission of UDPv4 packets in IPv4.")
(defrule flow/what/order -> :instruction "どの順に見ていくか（どの構成要素を先にし、どれを後に回すか）と、その理由を 1 文で書く。前の流れと同じなら書かない"
  :sample "We will defer the explanation of the client applications to the very end, as they only perform very simple invocations. The interesting code will mainly be in the services.")
;; which components take part, on which machines, and which steps are not coded by us (scenario/parts)
(defrule flow/parts -> :nucleus flow/parts/n :elaboration-additional flow/parts/not-ours)
(defrule flow/parts/n -> :instruction "この流れに関わる構成要素が、どの機械のどれかを 1 文で書く。構成要素が分かれていなければ段落ごと書かない"
  :sample "This scenario involves a client application in the buyer's machine and two services deployed in the broker's machine.")
(defrule flow/parts/not-ours -> :instruction "流れの手順のうち、このプログラムの外の構成要素が受け持つものと、それを誰が行うかを 1〜2 文で書く。無ければ書かない"
  :sample "Although step 5 involves the broker's index, this step is not performed by us. The broker's index automatically retrieves the data in the seller's local index because we configured the broker's index as the upstream index.")
;; the entry methods, who uses each, and the method that really does the work (path/entries)
(defrule flow/entries -> :nucleus flow/entries/n :elaboration-set-member flow/entries/each :elaboration-additional flow/entries/real :elaboration-additional flow/entries/bypass)
(defrule flow/entries/n -> :instruction "この流れの入口のメソッドがいくつあり、何という名前かを 1 文で書く。入口を個別に説明しないなら段落ごと書かない"
  :sample "There are two main methods for sending IPv4 packets from Layer 4, the transport layer:")
(defrule flow/entries/each -> :instruction "入口のメソッドごとに、それを使うのは誰か、その理由を 1〜2 文で書く。入口が 1 つなら書かない"
  :sample "The first one is the ip_queue_xmit() method, used by the transport protocols that handle fragmentation by themselves, like TCPv4. The second method is the ip_append_data() method, used by the transport protocols that do not handle fragmentation.")
(defrule flow/entries/real -> :instruction "入口のメソッドが自分では何をし（検査だけ、準備だけ）、実際の仕事をどのメソッドが行うかを 1〜2 文で書く"
  :sample "In fact, this method consists mostly of sanity checks. The real work is done in the ip_rcv_finish() method it invokes.")
(defrule flow/entries/bypass -> :instruction "入口のメソッドを通らない場合があれば、その例と、誰がそれを使うかを 1〜2 文で書く。無ければ書かない"
  :sample "There are cases where the dst_output() method is called directly; for example, when sending with a raw socket which uses IP_HDRINCL socket option.")
;; a mechanism met on the way, explained elsewhere (path/mechanism)
(defrule flow/mechanism -> :nucleus flow/mechanism/n :definition flow/mechanism/what :reason flow/mechanism/because :elaboration-additional flow/mechanism/answers)
(defrule flow/mechanism/n -> :instruction "流れの途中で何度も出てくる仕組みがあれば、その名前を 1 文で導入する。無ければ段落ごと書かない"
  :sample "In this chapter, you will encounter many invocations of the NF_HOOK macros; these are the netfilter hooks.")
(defrule flow/mechanism/what -> :instruction "その仕組みが何で、流れのどこに何か所あるかを 1 文で書く"
  :sample "The netfilter subsystem allows you to register callbacks in five points along the journey of a packet in the network stack.")
(defrule flow/mechanism/because -> :instruction "その仕組みがある理由を 1 文で書く" :sample "The reason for adding the netfilter hooks is to enable loading the netfilter kernel modules at runtime.")
(defrule flow/mechanism/answers -> :instruction "その仕組みの答えが入力に何をするか、以下ではどの前提で読むかを 1〜2 文で書く"
  :sample "When the registered netfilter hook method returns NF_DROP, the packet should be dropped. Let's assume for a moment that there are no netfilter callbacks registered in the NF_INET_PRE_ROUTING entry point.")
;; the figure of the flow (use-case/seq, scenario/follow/fig, path/figure)
(defrule flow/figure -> :nucleus flow/figure/n :elaboration-additional flow/figure/decides)
(defrule flow/figure/n -> :instruction "流れの図（シーケンス図、道筋の図）を指し、何を描いているかを 1 文で書く。設計の図と突き合わせて読むなら、どの図かを書く"
  :sample "Figure 23.8 shows the sequence diagram for this use case: / Figure 4-2 shows the receiving path (Rx) of a packet received by the network driver. / You should review Figure 23.7 to see how the sequence of events described here matches the one shown in the sequence diagram.")
(defrule flow/figure/decides -> :instruction "流れの行き先が分かれるなら、どこへ分かれ、何がそれを決めるかを 1〜2 文で書く。分かれなければ書かない"
  :sample "This packet can either be delivered to the local machine or be forwarded to another host. It is the lookup in the routing table that determines which of these two options will take place.")
(defrule flow/figure/img -> :instruction "流れの図を示す。シーケンス図なら矢印の番号を次の手順の番号と合わせる。道筋の図ならメソッドを箱、呼び出しを矢印にする。前に示した図と同じなら空にする" :kind image)
;; the interactions of a sequence diagram, one arrow at a time (use-case/steps)
(defrule flow/interactions -> :instruction "シーケンス図の矢印 1 本を 1 項目にして、起きる順に挙げる。項目ごとに、どの構成要素がどの構成要素のどの操作を、何を渡して呼ぶかを書き、その結果できるものや変わるものがあれば添える。シーケンス図が無ければ空にする"
  :sample "The FindFile client invokes the Find operation on the FileBuy Broker, which is deployed on the broker's container. / If there is at least one entry returned from the search, FileBuy Broker creates a File Order resource. / FileBuy Broker then returns the File Order EPR along with the cost of the file to the FindFile client."
  :kind number)
;; the figure read branch by branch, and the object that decides the branch (path/branches)
(defrule flow/branches -> :nucleus flow/branches/n :elaboration-process-step flow/branches/each :elaboration-additional flow/branches/object)
(defrule flow/branches/n -> :instruction "図の入口のメソッドを 1 文で指す。行き先が分かれなければ段落ごと書かない"
  :sample "The packet is received by the IPv4 protocol handler, the ip_rcv() method (see the upper left side of the figure).")
(defrule flow/branches/each -> :instruction "行き先ごとに、入力がどのメソッドを順に通るかを 1〜2 文で書く"
  :sample "If the packet is destined for the local host, it will first reach the ip_local_deliver() method, and subsequently it will reach the ip_local_deliver_finish() method. When the packet is to be forwarded, it will be handled by the ip_forward() method.")
(defrule flow/branches/object -> :instruction "行き先を決めるデータ構造が何で、誰がそれを作り、その中のどの値が次に呼ぶメソッドを決めるかを 1〜2 文で書く"
  :sample "dst is an instance of dst_entry (include/net/dst.h) and represents the result of a lookup in the routing subsystem. The lookup in the routing subsystem also sets the input and/or the output callbacks of the dst.")
;; the design decisions the flow involves (use-case/details)
(defrule flow/decisions -> :instruction "この流れに関わる設計上の決定を、1 行に 1 つ、決めた事柄の名前（資源の作り方、資源の永続化、構成要素の組み立て方など）で挙げる。設計を説明しないなら空にする"
  :frame "explain-program.decision.lisp" :heading "#### Design details")
;; the general concepts the flow shows (use-case/concepts)
(defrule flow/concepts -> :instruction "この流れから言える一般的な考え方を、1 行に 1 つ挙げる。このプログラムに限らない考え方だけを挙げる。無ければ空にする"
  :frame "explain-program.concept.lisp" :heading "#### General concepts")
;; the operations, in the order the flow runs through them (scenario/operations, path/walk)
(defrule flow/operations -> :instruction "この流れで呼ばれる操作やメソッドを、流れが通る順に、1 行に 1 つ「構成要素の名前: 操作の名前」かメソッドの名前で挙げる。コードを説明しないなら空にする"
  :frame "explain-program.operation.lisp")
;; the clients that start the flow (scenario/clients)
(defrule flow/clients -> :instruction "この流れを始めるクライアントを 1 行に 1 つ挙げる。独立のクライアントが無ければ空にする"
  :frame "explain-program.client.lisp")
;; trying the flow out (scenario/try)
(defrule flow/try -> :instruction "この流れを実際に動かして確かめる手順を説明する。動かして見せないなら空にする"
  :include "explain-program.trying.lisp" :heading "#### Trying it out")
;; what the reader learned, and what comes next (path/end)
(defrule flow/end -> :summary-n flow/end/learned :nucleus flow/end/next)
(defrule flow/end/learned -> :instruction "この流れで読み手が何を知ったかを、流れの段階の名前を並べて 1〜2 文でまとめる。まとめを書かないなら段落ごと書かない"
  :sample "In this section you learned about the various stages in the reception of IPv4 packets: the sanity checks performed, the lookup in the routing subsystem, the ip_rcv_finish() method which performs the actual work.")
(defrule flow/end/next -> :instruction "この流れで扱えなかった場合と、それを扱う次の節を 1 文で書く"
  :sample "When the packet length is higher than the network device MTU, the packet can't be sent as is. The next section covers fragmentation in the Tx path and how it is handled.")
