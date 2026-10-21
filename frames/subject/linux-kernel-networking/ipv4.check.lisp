;;; one check a method makes on a packet: what is checked, on what the rule rests, and everything that happens when the
;;; packet fails it (the packet, the sender, the statistics, the return value)
;;; members: the ihl/version and checksum checks of ip_rcv() (4/Sec3), the accept_source_route check (4/Sec5), the DF check of
;;;          ip_fragment() (4/Sec11), the lookup failure and strict route checks of ip_queue_xmit() (4/Sec10), the LRO, pkt_type,
;;;          ttl, strict route and MTU checks of ip_forward() (4/Sec15)
(defrule check -> :nucleus check/n :background check/rule :result check/fail :example check/code)
(defrule check/n -> :instruction "何を検査するかを、ヘッダやデータ構造の欄の名前で 1 文で書く"
  :sample "First a check is performed to see whether fragmentation is permitted,")
(defrule check/rule -> :instruction "その検査が何に基づくか（規格の節、ヘッダの欄の意味、設定の項目）を 1 文で書く。基づくものを書く必要が無ければ書かない"
  :sample "According to section 3.2.1.2 of RFC 1122, a host must verify the IPv4 header checksum on every received datagram and silently discard every datagram that has a bad checksum.")
(defrule check/fail -> :instruction "検査に落ちたとき、パケット、送り元への知らせ（ICMP の種類と code）、統計の欄、返す値がそれぞれどうなるかを 1 文で書く"
  :sample "and if not, a \"Destination Unreachable\" ICMPv4 message with code of fragmentation needed is sent back to the sender, the statistics (IPSTATS_MIB_FRAGFAILS) are updated, the packet is dropped, and an error code of -EMSGSIZE is returned:")
(defrule check/code -> :instruction "検査と、落ちたときの処理のコードを示す" :kind code-block)
