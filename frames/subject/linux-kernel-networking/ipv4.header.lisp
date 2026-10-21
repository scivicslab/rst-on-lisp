;;; subject: linux-kernel-networking 4/Sec1 IPv4 Header: the header a protocol puts at the front of every packet, and the
;;;          kernel structure that represents it, explained member by member
;;; made-from: doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p001-005 / s-header (with the end of the section from pages 6-10)
;;; members: p-layout p-figure p-holds p-struct p-members-intro p-ihl p-members p-header-end
;;; children: each member is one copy of ipv4.struct-member.lisp
;;; left-out: none
(defrule header -> p-layout p-figure p-figure/img p-holds p-struct p-struct/code members p-end)
;; where the header sits in a packet, its sizes, and why the reader must learn it first (p-layout)
(defrule p-layout -> :nucleus p-layout/n :elaboration-additional p-layout/max :elaboration-additional p-layout/after :purpose p-layout/first)
(defrule p-layout/n -> :instruction "どのパケットもこのヘッダで始まることと、ヘッダの最小の大きさを 1 文で書く" :sample "Every IPv4 packet starts with an IP header, which is at least 20 bytes long.")
(defrule p-layout/max -> :instruction "どんなときに大きくなり、最大でいくつになるかを 1 文で書く。大きさが決まっていれば書かない" :sample "If IP options are used, the IPv4 header can be up to 60 bytes.")
(defrule p-layout/after -> :instruction "ヘッダの後ろに何がどの順に続くかを 1 文で書く" :sample "After the IP header, there is the transport header (TCP header or UDP header, for example), and after it is the payload data.")
(defrule p-layout/first -> :instruction "プロトコルを理解するには先にヘッダの作りを知る必要がある、と 1 文で書く" :sample "To understand the IPv4 protocol, you must first learn how the IPv4 header is built.")
;; the figure, and the parts it shows (p-figure)
(defrule p-figure -> :nucleus p-figure/n)
(defrule p-figure/n -> :instruction "ヘッダの図を指し、ヘッダがどの部分に分かれ、それぞれ何バイトかを 1 文で書く"
  :sample "In Figure 4-1 you can see the IPv4 header, which consists of two parts: the first part of 20 bytes is the basic IPv4 header, and after it there is the IP options part, which can be from 0 to 40 bytes in length.")
(defrule p-figure/img -> :instruction "ヘッダの各欄をビットの位置で描いた図を示す" :kind image)
;; what the header holds, what the kernel decides from it, and how many members (p-holds)
(defrule p-holds -> :nucleus p-holds/n :elaboration-additional p-holds/count :elaboration-additional p-holds/where)
(defrule p-holds/n -> :instruction "ヘッダが持つ情報で、カーネルがパケットの扱いの何を決めるかを、主な欄を挙げて 1 文で書く"
  :sample "The IPv4 header consists of information that defines how a packet should be handled by the kernel network stack: the protocol being used, the source and destination address, the checksum, the identification (id) of the packet that is needed for fragmentation, the ttl that helps avoiding packets being forwarded endlessly because of some error, and more.")
(defrule p-holds/count -> :instruction "欄がいくつあり、どれが省略できるかを 1 文で書く"
  :sample "This information is stored in 13 members of the IPv4 header (the 14th member, IP Options, which is an extension to the IPv4 header, is optional).")
(defrule p-holds/where -> :instruction "カーネルでヘッダを表すデータ構造の名前と、欄の説明がこの後のどこにあるか、省略できる部分の説明がどの節にあるかを 1〜2 文で書く"
  :sample "The IPv4 header is represented by the iphdr structure. The IP options and their use are described in the \"IP Options\" section later in this chapter.")
;; the kernel structure, and what happens when its content is wrong (p-struct)
(defrule p-struct -> :nucleus p-struct/n :consequence-s p-struct/wrong)
(defrule p-struct/n -> :instruction "欄のうち、いつもあるものと省略できるものを 1 文で書く" :sample "All members always exist—except for the last one, the IP options, which is optional.")
(defrule p-struct/wrong -> :instruction "欄の中身がおかしいとき、カーネルがパケットをどうするかを、具体的な欄の例で 1 文で書く"
  :sample "The packet is discarded when there is some problem (for example, if the version, which is the first member, is not 4, or if the checksum is incorrect).")
(defrule p-struct/code -> :instruction "カーネルのデータ構造の定義を、定義のあるファイルの道筋を添えて示す" :kind code-block)
;; the members, one by one, in the order of the structure (p-ihl p-members)
(defrule members -> :instruction "データ構造の欄を、定義の順に、1 行に 1 つ欄の名前で挙げる" :frame "ipv4.struct-member.lisp")
;; what the section taught, and what comes next (p-header-end)
(defrule p-end -> :summary-n p-end/learned :nucleus p-end/next)
(defrule p-end/learned -> :instruction "この節で読み手が何を知ったかを 1 文でまとめる" :sample "In this section you have learned about the various IPv4 header members and their purposes.")
(defrule p-end/next -> :instruction "次の節が何を扱い、それがこの節のヘッダとどうつながるかを 1 文で書く"
  :sample "The initialization of the IPv4 protocol, which sets the callback to be invoked when receiving an IPv4 header, is discussed in the next section.")
