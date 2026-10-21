;;; one form of data the program reads or writes (a header, an optional part of it, a file format, a message): where it
;;; sits, its size and why, its forms, its figure, what it holds, its table of kinds and each kind, the structure that
;;; represents it and each member, the methods that parse, check and build it, and what the reader learned
;;; from: ipv4.header.lisp (header), ipv4.ip-options.lisp (options); the members of both, one member where the meaning is the same
(defrule data-format -> d/optional d/layout d/size d/forms d/figure d/figure/img d/type-parts d/holds d/table-intro d/table
                        d/kinds-intro kinds d/struct d/struct/code members methods d/end :heading "### {item}")
;; why an optional part exists, why it is rarely used, and when it helps (options o/rare)
(defrule d/optional -> :nucleus d/optional/n :rhetorical-question d/optional/q :example d/optional/ex)
(defrule d/optional/n -> :instruction "このデータが省略できる部分なら、あまり使われない理由とともに 1 文で書く。いつもあるなら段落ごと書かない"
  :sample "The IP options field of the IPv4 header is optional and is not often used for security reasons and because of processing overhead.")
(defrule d/optional/q -> :instruction "それでも役に立つ場面を問う 1 文を書く" :sample "Which options might be helpful?")
(defrule d/optional/ex -> :instruction "読み手が困っている具体的な場面と、そこで使うものを 1〜2 文で書く"
  :sample "Suppose, for example, that your packets are being dropped by a certain firewall. You may be able to specify a different route with the Strict or Loose Source Routing options.")
;; where the data sits, its sizes, what follows it, and why the reader must learn it first (header p-layout)
(defrule d/layout -> :nucleus d/layout/n :elaboration-additional d/layout/max :elaboration-additional d/layout/after :purpose d/layout/first)
(defrule d/layout/n -> :instruction "どの入力や出力がこのデータで始まるか（どこに置かれるか）と、最小の大きさを 1 文で書く。省略できる部分なら段落ごと書かない"
  :sample "Every IPv4 packet starts with an IP header, which is at least 20 bytes long.")
(defrule d/layout/max -> :instruction "どんなときに大きくなり、最大でいくつになるかを 1 文で書く。大きさが決まっていれば書かない" :sample "If IP options are used, the IPv4 header can be up to 60 bytes.")
(defrule d/layout/after -> :instruction "このデータの後ろに何がどの順に続くかを 1 文で書く" :sample "After the IP header, there is the transport header (TCP header or UDP header, for example), and after it is the payload data.")
(defrule d/layout/first -> :instruction "プログラムを理解するには先にこのデータの作りを知る必要がある、と 1 文で書く。必要でなければ書かない" :sample "To understand the IPv4 protocol, you must first learn how the IPv4 header is built.")
;; how many, how big, why that limit, how they are put together, where they are defined (options o/size)
(defrule d/size -> :nucleus d/size/n :elaboration-additional d/size/limits :reason d/size/because :elaboration-additional d/size/concat :elaboration-additional d/size/specs)
(defrule d/size/n -> :instruction "このデータの要素がいくつ入りうるかを 1 文で書く。要素の数が決まっていれば段落ごと書かない" :sample "The IPv4 header may contain zero, one, or more options.")
(defrule d/size/limits -> :instruction "要素が無いときと最大のときの大きさを 1 文で書く" :sample "The IPv4 header size is 20 bytes when there are no options. The length of the IP options field can be 40 bytes at most.")
(defrule d/size/because -> :instruction "その最大がどの欄のどの幅と単位から来るかを 1〜2 文で書く"
  :sample "The reason the IPv4 maximum length is 60 bytes is because the IPv4 header length is a 4-bit field, which expresses the length in multiples of 4 bytes.")
(defrule d/size/concat -> :instruction "複数の要素をどう並べ、境界をどう揃えるかを 1 文で書く"
  :sample "When using more than one option, options are simply concatenated one after the other. The IPv4 header must be aligned to a 4-byte boundary, so sometimes padding is needed.")
(defrule d/size/specs -> :instruction "このデータを定めた規格の文書を番号で挙げる。無ければ書かない" :sample "The following RFCs discuss IP options: 781 (Timestamp Option), 791, 1063, 1108, 1393, and 2113.")
;; the forms an element can take (options o/forms)
(defrule d/forms -> :instruction "要素の形がいくつあるかと、形ごとに何から成るかを 1 項目に 1 つ挙げる。長い形の欄は字下げした項目にする。形が 1 つなら空にする"
  :sample "Single byte option (option type): The \"End of Option List\" and \"No Operation\" are the only single byte options. / Multibyte option: after the option type byte there are three fields: Length (1 byte), Pointer (1 byte), Option data."
  :kind bullet)
;; the figure and the parts it shows (header p-figure, options o/type)
(defrule d/figure -> :nucleus d/figure/n)
(defrule d/figure/n -> :instruction "データの図を指し、データがどの部分に分かれ、それぞれ何バイトかを 1 文で書く"
  :sample "In Figure 4-1 you can see the IPv4 header, which consists of two parts: the first part of 20 bytes is the basic IPv4 header, and after it there is the IP options part, which can be from 0 to 40 bytes in length. / In Figure 4-3 the Option type is shown.")
(defrule d/figure/img -> :instruction "データの各欄をビットやバイトの位置で描いた図を示す" :kind image)
(defrule d/type-parts -> :instruction "図の欄のうち、いくつかの部分に分かれているものがあれば、部分 1 つにつき 1 項目で、値ごとの意味と、プログラムでそれを調べるマクロや使う場所を挙げる。無ければ空にする"
  :sample "copied flag: when set, the option should be copied in all fragments; the IPOPT_COPIED macro checks it. / option class: 00 control, 01 reserved1, 10 debugging and measurement, 11 reserved2. / option number: 0–31, not all used by Linux."
  :kind bullet)
;; what the data holds, what the program decides from it, how many members, and the structure that represents it (header p-holds)
(defrule d/holds -> :nucleus d/holds/n :elaboration-additional d/holds/count :elaboration-additional d/holds/where)
(defrule d/holds/n -> :instruction "データが持つ情報で、プログラムが入力の扱いの何を決めるかを、主な欄を挙げて 1 文で書く"
  :sample "The IPv4 header consists of information that defines how a packet should be handled by the kernel network stack: the protocol being used, the source and destination address, the checksum, the ttl, and more.")
(defrule d/holds/count -> :instruction "欄がいくつあり、どれが省略できるかを 1 文で書く"
  :sample "This information is stored in 13 members of the IPv4 header (the 14th member, IP Options, which is an extension to the IPv4 header, is optional).")
(defrule d/holds/where -> :instruction "プログラムでこのデータを表すデータ構造の名前と、省略できる部分の説明がどこにあるかを 1〜2 文で書く"
  :sample "The IPv4 header is represented by the iphdr structure. The IP options and their use are described in the \"IP Options\" section later in this chapter.")
;; the table of every kind (options o/table-intro o/table)
(defrule d/table-intro -> :nucleus d/table-intro/n :elaboration-additional d/table-intro/names)
(defrule d/table-intro/n -> :instruction "要素の種類の一覧表を、どの欄で並べたかとともに導入する。種類が無ければ段落ごと書かない"
  :sample "Table 4-1 shows all options according to their Linux symbol, option number, option class, and copied flag.")
(defrule d/table-intro/names -> :instruction "種類の記号を宣言したファイルと、プログラムが扱わない種類があればそれを 1〜2 文で書く"
  :sample "The option names (IPOPT_*) declarations are in include/uapi/linux/ip.h. The Linux network stack does not include all the IP options.")
(defrule d/table -> :instruction "種類 1 つにつき 1 行で、記号、番号、分類、説明を並べた表。1 行目は見出しの行。種類が無ければ空にする" :kind table)
(defrule d/kinds-intro -> :nucleus d/kinds-intro/n)
(defrule d/kinds-intro/n -> :instruction "種類を 1 つずつ説明し、どれを詳しく説明するかを 1 文で書く。種類が無ければ段落ごと書かない"
  :sample "I will describe the five options shortly, and then describe the Timestamp Option and the Record Route option in depth:")
(defrule kinds -> :instruction "要素の種類を、表の順に、1 行に 1 つ名前で挙げる。無ければ空にする" :frame "explain-program.data-kind.lisp")
;; the structure in the program, and what happens when its content is wrong (header p-struct, options o/struct)
(defrule d/struct -> :nucleus d/struct/n :consequence-s d/struct/wrong)
(defrule d/struct/n -> :instruction "プログラムでこのデータを表すデータ構造の名前と、欄のうちいつもあるものと省略できるものを 1 文で書く"
  :sample "All members always exist—except for the last one, the IP options, which is optional. / IP options are represented in Linux by the ip_options structure:")
(defrule d/struct/wrong -> :instruction "欄の中身がおかしいとき、プログラムが入力をどうするかを、具体的な欄の例で 1 文で書く。言うことが無ければ書かない"
  :sample "The packet is discarded when there is some problem (for example, if the version, which is the first member, is not 4, or if the checksum is incorrect).")
(defrule d/struct/code -> :instruction "データ構造の定義を、定義のあるファイルの道筋を添えて示す" :kind code-block)
(defrule members -> :instruction "データ構造の欄を、定義の順に、1 行に 1 つ欄の名前で挙げる" :frame "explain-program.member.lisp")
;; the methods that parse, check, copy and build the data (options methods)
(defrule methods -> :instruction "このデータを受け取って解析し、確かめ、写し、組み立てるメソッドを、呼ばれる順に、1 行に 1 つ挙げる。流れの説明で扱うなら空にする"
  :frame "explain-program.operation.lisp")
;; what the reader learned, and what comes next (header p-end, options o/end)
(defrule d/end -> :summary-n d/end/learned :nucleus d/end/next)
(defrule d/end/learned -> :instruction "読み手がこのデータについて何を知ったかを 1 文でまとめる"
  :sample "In this section you have learned about the various IPv4 header members and their purposes.")
(defrule d/end/next -> :instruction "次の節が何を扱い、それがこのデータとどうつながるかを 1 文で書く"
  :sample "The initialization of the IPv4 protocol, which sets the callback to be invoked when receiving an IPv4 header, is discussed in the next section.")
