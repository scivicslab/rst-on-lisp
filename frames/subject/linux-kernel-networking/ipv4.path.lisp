;;; subject: one path a packet takes through the protocol subsystem (receive, multicast receive, send, forward): its entry
;;;          method, what decides where the packet goes, the figure of the path, the methods walked through with their checks,
;;;          and what the reader learned
;;; made-from: doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p006-010 doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p011-015 / s-rx (4/Sec3 Receiving IPv4 Packets)
;;; made-from: doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p011-015 doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p016-020 / s-mc (4/Sec4 Receiving IPv4 Multicast Packets)
;;; made-from: doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p051-055 doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p056-060 doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p061-065 / s-tx (4/Sec10 Sending IPv4 Packets)
;;; made-from: doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p081-085 doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p086-090 / fwd (4/Sec15 Forwarding)
;;; members: p-rx-main p-rx-hooks p-rx-cond p-rx-figure p-rx-paths p-rx-points p-rx-checks p-rx-verdicts p-rx-dst p-rx-dst-more p-rx-lookup p-rx-exdev p-rx-options p-rx-end;
;;;          p-mc-entry p-mc-callback p-mc-procfs p-mc-mfc p-mc-finish p-mc-end; p-tx-what p-tx-two p-tx-push p-tx-direct p-tx-figure p-tx-paths p-qx* p-strict p-push
;;;          p-opts p-getfrag p-cork p-append p-probe p-setup p-real p-tx-end; the paragraphs of fwd
;;; children: each method walked through is a run of ipv4.code-step.lisp and ipv4.check.lisp copies
;;; left-out: none
(defrule path -> path/what path/entries path/mechanism path/figure path/figure/img path/branches path/walk path/end)
;; what the path does, and between which layers (p-tx-what, p-rx-main)
(defrule path/what -> :nucleus path/what/n :elaboration-additional path/what/shows)
(defrule path/what/n -> :instruction "この道筋がどの層からどの層へパケットを渡すのか、またはどのパケットを受け取るのかを 1 文で書く"
  :sample "The IPv4 layer provides the means for the layer above it, the transport layer (L4), to send packets by passing these packets to the link layer (L2).")
(defrule path/what/shows -> :instruction "この節で何を示し、プロトコルや使い手ごとの違いを示すかを 1 文で書く。無ければ書かない"
  :sample "You'll see some differences between handling transmission of TCPv4 packets in IPv4 and handling transmission of UDPv4 packets in IPv4.")
;; the entry methods, who uses each, and the method that really does the work (p-rx-main p-tx-two p-tx-push p-tx-direct)
(defrule path/entries -> :nucleus path/entries/n :elaboration-set-member path/entries/each :elaboration-additional path/entries/real :elaboration-additional path/entries/bypass)
(defrule path/entries/n -> :instruction "この道筋の入口のメソッドがいくつあり、何という名前かを 1 文で書く"
  :sample "There are two main methods for sending IPv4 packets from Layer 4, the transport layer:")
(defrule path/entries/each -> :instruction "入口のメソッドごとに、それを使うのはどのプロトコルか、その理由を 1〜2 文で書く"
  :sample "The first one is the ip_queue_xmit() method, used by the transport protocols that handle fragmentation by themselves, like TCPv4. The second method is the ip_append_data() method, used by the transport protocols that do not handle fragmentation, like the UDPv4 protocol or the ICMPv4 protocol.")
(defrule path/entries/real -> :instruction "入口のメソッドが自分では何をし（検査だけ、準備だけ）、実際の仕事をどのメソッドが行うかを 1〜2 文で書く"
  :sample "In fact, this method consists mostly of sanity checks. The real work is done in the ip_rcv_finish() method it invokes.")
(defrule path/entries/bypass -> :instruction "入口のメソッドを通らない場合があれば、その例と、誰がそれを使うかを 1〜2 文で書く。無ければ書かない"
  :sample "There are cases where the dst_output() method is called directly; for example, when sending with a raw socket which uses IP_HDRINCL socket option, there is no need to prepare an IPv4 header.")
;; a mechanism met on the way, which other chapters explain (p-rx-hooks p-rx-cond p-rx-verdicts)
(defrule path/mechanism -> :nucleus path/mechanism/n :definition path/mechanism/what :reason path/mechanism/because :elaboration-additional path/mechanism/answers)
(defrule path/mechanism/n -> :instruction "道筋の途中で何度も出てくる仕組みがあれば、その名前を 1 文で導入する。無ければ段落ごと書かない"
  :sample "In this chapter, you will encounter many invocations of the NF_HOOK macros; these are the netfilter hooks.")
(defrule path/mechanism/what -> :instruction "その仕組みが何で、道筋のどこに何か所あるかを 1 文で書く"
  :sample "The netfilter subsystem allows you to register callbacks in five points along the journey of a packet in the network stack.")
(defrule path/mechanism/because -> :instruction "その仕組みがある理由を 1 文で書く" :sample "The reason for adding the netfilter hooks is to enable loading the netfilter kernel modules at runtime.")
(defrule path/mechanism/answers -> :instruction "その仕組みの答えがパケットに何をするか、以下ではどの前提で読むかを 1〜2 文で書く"
  :sample "When the registered netfilter hook method returns NF_DROP, the packet should be dropped. Let's assume for a moment that there are no netfilter callbacks registered in the NF_INET_PRE_ROUTING entry point.")
;; the figure of the path (p-rx-figure p-tx-figure)
(defrule path/figure -> :nucleus path/figure/n :elaboration-additional path/figure/decides)
(defrule path/figure/n -> :instruction "道筋の図を指し、何を描いているかを 1 文で書く" :sample "Figure 4-2 shows the receiving path (Rx) of a packet received by the network driver.")
(defrule path/figure/decides -> :instruction "パケットの行き先が分かれるなら、どこへ分かれ、何がそれを決めるかを 1〜2 文で書く"
  :sample "This packet can either be delivered to the local machine or be forwarded to another host. It is the lookup in the routing table that determines which of these two options will take place.")
(defrule path/figure/img -> :instruction "メソッドを箱、呼び出しを矢印にした道筋の図を示す" :kind image)
;; the figure read method by method, and the object that decides the branch (p-rx-paths p-rx-dst p-mc-callback)
(defrule path/branches -> :nucleus path/branches/n :elaboration-process-step path/branches/each :elaboration-additional path/branches/object)
(defrule path/branches/n -> :instruction "図の入口のメソッドを 1 文で指す" :sample "The packet is received by the IPv4 protocol handler, the ip_rcv() method (see the upper left side of the figure).")
(defrule path/branches/each -> :instruction "行き先ごとに、パケットがどのメソッドを順に通るかを 1〜2 文で書く"
  :sample "If the packet is destined for the local host, it will first reach the ip_local_deliver() method, and subsequently it will reach the ip_local_deliver_finish() method. When the packet is to be forwarded, it will be handled by the ip_forward() method.")
(defrule path/branches/object -> :instruction "行き先を決めるデータ構造が何で、誰がそれを作り、その中のどの値が次に呼ぶメソッドを決めるかを 1〜2 文で書く"
  :sample "dst is an instance of dst_entry (include/net/dst.h) and represents the result of a lookup in the routing subsystem. The lookup in the routing subsystem also sets the input and/or the output callbacks of the dst.")
;; the methods walked through, in order: each a run of code steps and checks
(defrule path/walk -> :instruction "道筋のメソッドを、パケットが通る順に、1 行に 1 つメソッドの名前で挙げる" :frame "ipv4.path-method.lisp")
;; what the section taught, and what comes next (p-rx-end p-mc-end p-tx-end)
(defrule path/end -> :summary-n path/end/learned :nucleus path/end/next)
(defrule path/end/learned -> :instruction "この節で読み手が何を知ったかを、道筋の段階の名前を並べて 1〜2 文でまとめる"
  :sample "In this section you learned about the various stages in the reception of IPv4 packets: the sanity checks performed, the lookup in the routing subsystem, the ip_rcv_finish() method which performs the actual work.")
(defrule path/end/next -> :instruction "この道筋で扱えなかった場合（大きすぎる、特別な宛先）と、それを扱う次の節を 1 文で書く"
  :sample "When the packet length is higher than the network device MTU, the packet can't be sent as is. The next section covers fragmentation in the Tx path and how it is handled.")
