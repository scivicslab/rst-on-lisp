;;; subject: linux-kernel-networking 4 IPv4: one protocol subsystem of the kernel, explained from its data on the wire to
;;;          the paths a packet takes through it
;;; made-from: doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p001-005 / ch4
;;; members: p-prev p-what p-rfc p-functions p-covers p-frag
;;; children (:include, in the chapter's order): 4/Sec1 ipv4.header.lisp, 4/Sec2 ipv4.initialization.lisp, 4/Sec3 and 4/Sec4 ipv4.path.lisp,
;;;          4/Sec5-4/Sec8 ipv4.ip-options.lisp, 4/Sec10 ipv4.path.lisp, 4/Sec11-4/Sec14 ipv4.packet-transform.lisp (twice), 4/Sec15 ipv4.path.lisp,
;;;          4/Sec16 ipv4.summary.lisp, 4/Sec17 ipv4.quick-reference.lisp
;;; left-out: none
(in-package :rst)
(defdocument Ipv4Frame)

(defrule document -> title sections)
(defrule title -> :instruction "説明するサブシステムが扱うプロトコルの名前を題にする")
(defrule sections -> s1)
(defrule s1 -> p-prev p-what p-spec p-functions p-covers p-tasks header initialization receiving receiving-mc options sending fragmentation defragmentation forwarding summary quick-reference
              :heading "## IPv4")

;; where the chapter stands against the previous one (p-prev)
(defrule p-prev -> :background p-prev/before :nucleus p-prev/n)
(defrule p-prev/before -> :instruction "前の章が何を扱ったかを 1 文で書く。この章とつながりが無ければ書かない" :sample "Chapter 3 deals with the implementation of the ICMP protocol in IPv4 and in IPv6.")
(defrule p-prev/n -> :instruction "前の章で扱ったものが、この章の主題の中でどう使われるかを 1 文で書く"
  :sample "This chapter, which deals with the IPv4 protocol, shows how ICMP messages are used for reporting Internet protocol errors under certain circumstances.")
;; what the subject is, its place, and where it is defined (p-what p-rfc)
(defrule p-what -> :nucleus p-what/n :elaboration-additional p-what/role)
(defrule p-what/n -> :instruction "主題のプロトコルが何であるかを、正式な名前とともに 1 文で書く" :sample "The IPv4 protocol (Internet Protocol version 4) is one of the core protocols of today's standards-based Internet")
(defrule p-what/role -> :instruction "それが世の中のどれだけの部分を担っているかを 1 文で書く" :sample "and routes most of the traffic on the Internet.")
(defrule p-spec -> :nucleus p-spec/n)
(defrule p-spec/n -> :instruction "主題の基本の定義がどの規格の文書にあるかを、文書の番号と題と年で 1 文で書く" :sample "The base definition is in RFC 791, \"Internet Protocol,\" from 1981.")
;; what the subject does, and which other chapters cover which part (p-functions)
(defrule p-functions -> :nucleus p-functions/n :elaboration-additional p-functions/more :elaboration-additional p-functions/elsewhere)
(defrule p-functions/n -> :instruction "主題が提供する一番の働きを 1 文で書く" :sample "The IPv4 protocol provides an end-to-end connectivity between any two hosts.")
(defrule p-functions/more -> :instruction "ほかの大事な働きを 1 文で書く" :sample "Another important function of the IP layer is forwarding packets (also called routing) and managing tables that store routing information.")
(defrule p-functions/elsewhere -> :instruction "その働きのうち、別の章で扱うものと、その章を 1 文で書く" :sample "Chapters 5 and 6 discuss IPv4 routing.")
;; what this chapter covers, and the tasks that need explaining (p-covers p-frag)
(defrule p-covers -> :nucleus p-covers/n)
(defrule p-covers/n -> :instruction "この章が扱う実装の範囲を、コロンの後に並べて 1 文で書く"
  :sample "This chapter describes the IPv4 Linux implementation: receiving and sending IPv4 packets, including multicast packets, IPv4 forwarding, and handling IPv4 options.")
(defrule p-tasks -> :condition p-tasks/when :nucleus p-tasks/n :elaboration-additional p-tasks/reverse :elaboration-additional p-tasks/also)
(defrule p-tasks/when -> :instruction "範囲の並びに入っていないが、ある条件で必要になる仕事があれば、その条件を 1 文で書く。無ければ段落ごと書かない"
  :sample "There are cases when the packet to be sent is bigger than the MTU of the outgoing interface;")
(defrule p-tasks/n -> :instruction "その条件で何をしなければならないかを 1 文で書く" :sample "in such cases the packet should be fragmented into smaller fragments.")
(defrule p-tasks/reverse -> :instruction "受け取る側でその逆に何をし、結果が何と一致しなければならないかを 1 文で書く"
  :sample "When fragmented packets are received, they should be assembled into one big packet, which should be identical to the packet that was sent before it was fragmented.")
(defrule p-tasks/also -> :instruction "それらもこの章で扱うと 1 文で書く" :sample "These are also important tasks of the IPv4 protocol discussed in this chapter.")

;; 4/Sec1 and 4/Sec2
(defrule header -> :instruction "パケットの先頭のヘッダを、カーネルのデータ構造とともに説明する" :include "ipv4.header.lisp" :heading "### Header")
(defrule initialization -> :instruction "このプロトコルの受け取り口をカーネルに登録するところを説明する" :include "ipv4.initialization.lisp" :heading "### Initialization")
;; 4/Sec3-4/Sec17, in the chapter's order
(defrule receiving -> :instruction "受け取ったパケットの道筋を説明する" :include "ipv4.path.lisp" :heading "### Receiving packets")
(defrule receiving-mc -> :instruction "特別な宛先（マルチキャスト）のパケットを受け取る道筋を説明する。無ければ空にする" :include "ipv4.path.lisp" :heading "### Receiving multicast packets")
(defrule options -> :instruction "ヘッダの省略できる部分（選択肢）を、解析と組み立てまで説明する" :include "ipv4.ip-options.lisp" :heading "### Options")
(defrule sending -> :instruction "パケットを送る道筋を説明する" :include "ipv4.path.lisp" :heading "### Sending packets")
(defrule fragmentation -> :instruction "大きすぎるパケットを分ける変換を説明する" :include "ipv4.packet-transform.lisp" :heading "### Fragmentation")
(defrule defragmentation -> :instruction "分けられたパケットを組み立て直す変換を説明する" :include "ipv4.packet-transform.lisp" :heading "### Defragmentation")
(defrule forwarding -> :instruction "受け取ったパケットを別の口から送り出す道筋を説明する" :include "ipv4.path.lisp" :heading "### Forwarding")
(defrule summary -> :instruction "章をまとめる" :include "ipv4.summary.lisp" :heading "### Summary")
(defrule quick-reference -> :instruction "章で出てきたメソッドとマクロの早見表を作る" :include "ipv4.quick-reference.lisp" :heading "### Quick reference")
