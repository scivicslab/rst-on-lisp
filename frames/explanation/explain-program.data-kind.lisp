;;; one kind of element a form of data can carry: its name and symbol, what it does, where it is specified, how to use it
;;; or why it is not used, and its sub-kinds
;;; from: ipv4.option-kind.lisp
(defrule element-kind -> :nucleus element-kind/n :elaboration-additional element-kind/what :background element-kind/spec
                         :elaboration-additional element-kind/use :concession element-kind/ignored :elaboration-set-member element-kind/subkinds)
(defrule element-kind/n -> :instruction "種類の名前と、プログラムでの記号を書く" :sample "Record Route (IPOPT_RR):")
(defrule element-kind/what -> :instruction "その種類が何をするか、途中で誰が何を書き足すかを 1〜2 文で書く" :sample "The route of a packet is recorded. Each router on the way adds its address.")
(defrule element-kind/spec -> :instruction "その種類を定めた規格の文書を、番号と題で 1 文で書く。無ければ書かない"
  :sample "The Timestamp option is specified in RFC 781, \"A Specification of the Internet Protocol (IP) Timestamp Option.\"")
(defrule element-kind/use -> :instruction "読み手がその種類を使う方法（コマンドとその引数）と、大きさの限界を 1〜2 文で書く。無ければ書かない"
  :sample "The command-line utility ping -R uses the Record Route IP Option. Note that the IPv4 header is only large enough for nine such routes.")
(defrule element-kind/ignored -> :instruction "実際には多くの相手がその種類を無視するか遮るなら、その理由とともに 1 文で書く。無ければ書かない"
  :sample "Many routers block the Loose Source Record Route (LSRR) and Strict Source Record Route (SSRR) options because of security reasons.")
(defrule element-kind/subkinds -> :instruction "その種類に下位の種類（旗の値など）があれば、1 項目に 1 つ、値と、そのとき何が書き足されるかを挙げる。無ければ空にする"
  :sample "0: Timestamp only (IPOPT_TS_TSONLY) — each router on the path adds its timestamp. / 1: Timestamps and addresses (IPOPT_TS_TSANDADDR) — each router adds its IPv4 address and its timestamp."
  :kind bullet)
