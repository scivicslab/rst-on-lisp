;;; subject: 4/Sec5 IP Options (with 4/Sec6 Timestamp Option, 4/Sec7 Record Route Option, 4/Sec8 IP Options and Fragmentation, and
;;;          Building IP Options): an optional part of a header, explained from why it exists to how the kernel parses, copies and
;;;          builds it
;;; made-from: doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p016-020 ... doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p051-055 / s-opt s-ts s-rr s-frag s-build
;;; members: p-opt-why p-opt-size p-opt-forms p-type-fig p-copied p-class-intro p-class p-class-linux p-number p-table p-names p-five-intro p-five
;;;          s-ts s-rr p-rest p-struct p-members p-rcv... p-compile p-compile-user p-compile-error p-compile-cb p-parm p-parm-points p-start ...
;;;          p-srr p-rcv-srr p-fwd p-frag... p-build p-fwd-opts
;;; children: each kind of option is one copy of ipv4.option-kind.lisp; each member of the kernel structure one copy of ipv4.struct-member.lisp;
;;;          each walked-through method a copy of ipv4.path-method.lisp
;;; left-out: none
(defrule options -> o/rare o/size o/forms o/type o/type/img o/type-parts o/table-intro o/table o/kinds-intro kinds o/struct o/struct/code members methods o/end)
;; why the part exists, why it is rarely used, and when it helps (p-opt-why)
(defrule o/rare -> :nucleus o/rare/n :rhetorical-question o/rare/q :example o/rare/ex)
(defrule o/rare/n -> :instruction "ヘッダのこの部分が省略できること、あまり使われない理由を 1 文で書く"
  :sample "The IP options field of the IPv4 header is optional and is not often used for security reasons and because of processing overhead.")
(defrule o/rare/q -> :instruction "それでも役に立つ場面を問う 1 文を書く" :sample "Which options might be helpful?")
(defrule o/rare/ex -> :instruction "読み手が困っている具体的な場面と、そこで使う選択肢を 1〜2 文で書く"
  :sample "Suppose, for example, that your packets are being dropped by a certain firewall. You may be able to specify a different route with the Strict or Loose Source Routing options.")
;; how many, how big, why that limit, how they are put together, where they are defined (p-opt-size)
(defrule o/size -> :nucleus o/size/n :elaboration-additional o/size/limits :reason o/size/because :elaboration-additional o/size/concat :elaboration-additional o/size/specs)
(defrule o/size/n -> :instruction "ヘッダに選択肢がいくつ入りうるかを 1 文で書く" :sample "The IPv4 header may contain zero, one, or more options.")
(defrule o/size/limits -> :instruction "選択肢が無いときと最大のときの大きさを 1 文で書く" :sample "The IPv4 header size is 20 bytes when there are no options. The length of the IP options field can be 40 bytes at most.")
(defrule o/size/because -> :instruction "その最大がどの欄のどの幅と単位から来るかを 1〜2 文で書く"
  :sample "The reason the IPv4 maximum length is 60 bytes is because the IPv4 header length is a 4-bit field, which expresses the length in multiples of 4 bytes.")
(defrule o/size/concat -> :instruction "複数の選択肢をどう並べ、境界をどう揃えるかを 1 文で書く"
  :sample "When using more than one option, options are simply concatenated one after the other. The IPv4 header must be aligned to a 4-byte boundary, so sometimes padding is needed.")
(defrule o/size/specs -> :instruction "選択肢を定めた規格の文書を番号で挙げる" :sample "The following RFCs discuss IP options: 781 (Timestamp Option), 791, 1063, 1108, 1393, and 2113.")
;; the forms of an option, and the layout of a multibyte one (p-opt-forms)
(defrule o/forms -> :instruction "選択肢の形がいくつあるかと、形ごとに何から成るかを 1 項目に 1 つ挙げる。長い形の欄は字下げした項目にする"
  :sample "Single byte option (option type): The \"End of Option List\" and \"No Operation\" are the only single byte options. / Multibyte option: after the option type byte there are three fields: Length (1 byte), Pointer (1 byte), Option data."
  :kind bullet)
;; the type byte and its parts (p-type-fig p-copied p-class p-class-linux p-number)
(defrule o/type -> :nucleus o/type/n)
(defrule o/type/n -> :instruction "選択肢の種類を表す 1 バイトの図を指す" :sample "In Figure 4-3 the Option type is shown.")
(defrule o/type/img -> :instruction "種類のバイトをビットの部分に分けた図を示す" :kind image)
(defrule o/type-parts -> :instruction "種類のバイトの部分を、1 項目に 1 つ、値ごとの意味と、カーネルでそれを調べるマクロや使う場所とともに挙げる"
  :sample "copied flag: when set, the option should be copied in all fragments; the IPOPT_COPIED macro checks it, and ip_options_fragment() uses it. / option class: 00 control, 01 reserved1, 10 debugging and measurement, 11 reserved2; in Linux only IPOPT_TIMESTAMP is of class 10. / option number: 0–31, not all used by Linux."
  :kind bullet)
;; the table of every option (p-table-intro p-table p-names)
(defrule o/table-intro -> :nucleus o/table-intro/n :elaboration-additional o/table-intro/names)
(defrule o/table-intro/n -> :instruction "選択肢の一覧表を、どの欄で並べたかとともに導入する" :sample "Table 4-1 shows all options according to their Linux symbol, option number, option class, and copied flag.")
(defrule o/table-intro/names -> :instruction "記号を宣言したファイルと、カーネルに無い選択肢の一覧の置き場所を 1〜2 文で書く"
  :sample "The option names (IPOPT_*) declarations are in include/uapi/linux/ip.h. The Linux network stack does not include all the IP options.")
(defrule o/table -> :instruction "選択肢 1 つにつき 1 行で、記号、番号、種類、copied 旗、説明を並べた表。1 行目は見出しの行" :kind table)
;; the kinds one by one (p-five s-ts s-rr p-rest)
(defrule o/kinds-intro -> :nucleus o/kinds-intro/n)
(defrule o/kinds-intro/n -> :instruction "選択肢を 1 つずつ説明し、どれを詳しく説明するかを 1 文で書く"
  :sample "I will describe the five options shortly, and then describe the Timestamp Option and the Record Route option in depth:")
(defrule kinds -> :instruction "選択肢を、表の順に、1 行に 1 つ名前で挙げる" :frame "ipv4.option-kind.lisp")
;; the kernel structure for the parsed options, member by member (p-struct p-members)
(defrule o/struct -> :nucleus o/struct/n)
(defrule o/struct/n -> :instruction "カーネルで選択肢を表すデータ構造の名前を 1 文で書く" :sample "IP options are represented in Linux by the ip_options structure:")
(defrule o/struct/code -> :instruction "そのデータ構造の定義を、ファイルの道筋を添えて示す" :kind code-block)
(defrule members -> :instruction "そのデータ構造の欄を、定義の順に、1 行に 1 つ欄の名前で挙げる" :frame "ipv4.struct-member.lisp")
;; the methods that parse, check, copy and build the options (ip_rcv_options, ip_options_compile, ip_options_rcv_srr, ip_options_fragment, ip_options_build)
(defrule methods -> :instruction "選択肢を受け取って解析し、確かめ、断片に写し、書き戻すメソッドを、呼ばれる順に、1 行に 1 つ挙げる" :frame "ipv4.path-method.lisp")
;; what the section taught, and what comes next (p-frag-end p-rx-done)
(defrule o/end -> :summary-n o/end/learned :nucleus o/end/next)
(defrule o/end/learned -> :instruction "この節で読み手が何を知ったかを、メソッドの名前で 1 文でまとめる"
  :sample "In this section you have learned how the ip_rcv_options() handles the reception of packets with IP options and how IP options are parsed by the ip_options_compile() method.")
(defrule o/end/next -> :instruction "次の節が何を扱うかを 1 文で書く" :sample "The next section talks about the Tx path—what happens when IPv4 packets are sent.")
