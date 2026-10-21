;;; subject: linux-kernel-networking 4/Sec2 IPv4 Initialization: how a protocol subsystem registers its entry point with
;;;          the kernel, so that packets of that protocol reach its methods
;;; made-from: doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p006-010 / s-init
;;; members: p-init-which p-init-does p-init-paths
;;; left-out: none
(defrule initialization -> p-which p-code/handler p-code/init p-does p-next)
;; which packets belong to the protocol, the rule every protocol follows, and why the section is here (p-init-which)
(defrule p-which -> :nucleus p-which/n :elaboration-additional p-which/rule :purpose p-which/so)
(defrule p-which/n -> :instruction "どのパケットがこのプロトコルのものかを、それを見分ける値と、その値がパケットのどこにあるかで 1 文で書く"
  :sample "IPv4 packets are packets with Ethernet type 0x0800 (Ethernet type is stored in the first two bytes of the 14-byte Ethernet header).")
(defrule p-which/rule -> :instruction "どのプロトコルも、ネットワークスタックに扱わせるために何を定義し登録しなければならないかを 1 文で書く"
  :sample "Each protocol should define a protocol handler, and each protocol should be initialized so that the network stack can handle packets that belong to this protocol.")
(defrule p-which/so -> :instruction "この節を読むと、受け取ったパケットがなぜこのプロトコルのメソッドに届くかが分かる、と 1 文で書く"
  :sample "So that you understand what causes received IPv4 packets to be handled by IPv4 methods, this section describes the registration of the IPv4 protocol handler:")
(defrule p-code/handler -> :instruction "受け取り口を表すデータ構造の定義を示す。見分ける値と、呼ばれるメソッドの欄を含める" :kind code-block)
(defrule p-code/init -> :instruction "それを登録する初期化のメソッドを、登録の呼び出し以外を省いて、ファイルの道筋を添えて示す" :kind code-block)
;; what the registering call does, where the identifying value is defined, and when the initialization runs (p-init-does)
(defrule p-does -> :nucleus p-does/n :elaboration-additional p-does/value :elaboration-additional p-does/when)
(defrule p-does/n -> :instruction "登録の呼び出しが、どのメソッドを何の受け取り口として加えるかを 1 文で書く" :sample "The dev_add_pack() method adds the ip_rcv() method as a protocol handler for IPv4 packets.")
(defrule p-does/value -> :instruction "見分ける値の定数の名前と、それを定義したファイルを 1 文で書く"
  :sample "These are packets with Ethernet type 0x0800 (ETH_P_IP, defined in include/uapi/linux/if_ether.h).")
(defrule p-does/when -> :instruction "初期化のメソッドがほかに何をし、いつ呼ばれるかを 1 文で書く" :sample "The inet_init() method performs various IPv4 initializations and is called during the boot phase.")
;; the paths the subsystem divides into, what the reader now knows, and which path comes next (p-init-paths)
(defrule p-next -> :nucleus p-next/n :summary-n p-next/learned :elaboration-additional p-next/order)
(defrule p-next/n -> :instruction "サブシステムの主な働きが、どの道筋に分かれるかを 1 文で書く" :sample "The main functionality of the IPv4 protocol is divided into the Rx (receive) path and the Tx (transmit) path.")
(defrule p-next/learned -> :instruction "この節で読み手が何を知ったかを、受け取り口のメソッドの名前で 1 文でまとめる"
  :sample "Now that you learned about the registration of the IPv4 protocol handler, you know which protocol handler manages IPv4 packets (the ip_rcv callback) and how this protocol handler is registered.")
(defrule p-next/order -> :instruction "次にどの道筋を読み、もう一方はどの節で読むかを 1〜2 文で書く"
  :sample "You are ready now to start to learn about the IPv4 Rx path and how received IPv4 packets are handled. The Tx path is described in a later section, \"Sending IPv4 Packets.\"")
