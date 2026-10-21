;;; one kind of the options a header can carry: its name and symbol, what it does, where it is specified, how it is used
;;; or why it is not, and (for a kind explained in depth) its layout for each of its sub-types
;;; members: the items of p-five and p-rest (4/Sec5), Timestamp Option (4/Sec6), Record Route Option (4/Sec7)
(defrule kind -> :nucleus kind/n :elaboration-additional kind/what :background kind/spec :elaboration-additional kind/use :concession kind/ignored
                 :elaboration-set-member kind/layouts)
(defrule kind/n -> :instruction "選択肢の名前と、カーネルでの記号を書く" :sample "Record Route (IPOPT_RR):")
(defrule kind/what -> :instruction "その選択肢が何をするか、通る機械のそれぞれが何を書き足すかを 1〜2 文で書く"
  :sample "The route of a packet is recorded. Each router on the way adds its address.")
(defrule kind/spec -> :instruction "その選択肢を定めた規格の文書を、番号と題で 1 文で書く。無ければ書かない"
  :sample "The Timestamp option is specified in RFC 781, \"A Specification of the Internet Protocol (IP) Timestamp Option.\"")
(defrule kind/use -> :instruction "読み手がその選択肢を付けたパケットを送る方法（コマンドとその引数）と、大きさの限界を 1〜2 文で書く。無ければ書かない"
  :sample "The command-line utility ping -R uses the Record Route IP Option. Note that the IPv4 header is only large enough for nine such routes.")
(defrule kind/ignored -> :instruction "実際には多くの機械がその選択肢を無視するか遮るなら、その理由とともに 1 文で書く。無ければ書かない"
  :sample "Many routers block the Loose Source Record Route (LSRR) and Strict Source Record Route (SSRR) options because of security reasons.")
(defrule kind/layouts -> :instruction "その選択肢に下位の種類（旗の値など）があれば、1 項目に 1 つ、値と、そのとき各機械が書き足すものを挙げる。無ければ空にする"
  :sample "0: Timestamp only (IPOPT_TS_TSONLY) — each router on the path adds its timestamp. / 1: Timestamps and addresses (IPOPT_TS_TSANDADDR) — each router adds its IPv4 address and its timestamp. / 3: Timestamps of specified hops only (IPOPT_TS_PRESPEC)."
  :kind bullet)
