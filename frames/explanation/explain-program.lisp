;;; use: Explains one program (a system of services, a subsystem of a kernel, a library, an application): what it is and
;;;      what kind of program it is, the data it handles, how input reaches it, the flows through it with their design
;;;      decisions and their code, the transformations it does and undoes, where its parts run, how to set it up and try it,
;;;      the decisions about security, what the design teaches, and a quick reference.
;;; integrates: subject/filebuy-application/design.lisp (Globus Toolkit 4, 23 Design)
;;; integrates: subject/filebuy-application/implementation.lisp (Globus Toolkit 4, 24 Implementation)
;;; integrates: subject/linux-kernel-networking/ipv4.lisp (Linux Kernel Networking, 4 IPv4)
;;; how: the members are the union of the members of the integrated frames, not their intersection. Members with the
;;;      same meaning are one member here; a member only one frame has is kept. A program fills the members that apply to
;;;      it and leaves the others empty.
;;; roles (role: design / implementation / ipv4; - = the frame has no such member):
;;;   p-prev:        -                      / p-roadmap/design      / p-prev
;;;   p-plan:        p-plan                 / p-roadmap             / p-covers
;;;   p-what:        the-system p-system-what / -                   / p-what p-functions
;;;   p-spec:        -                      / -                     / p-spec
;;;   p-tasks:       -                      / -                     / p-tasks
;;;   p-scale:       the-system p-system-scale / -                  / -
;;;   p-easy p-new:  -                      / p-easy p-new          / -
;;;   p-code-dirs:   -                      / p-code-dirs(-list)    / -
;;;   p-versions:    -                      / p-versions            / -
;;;   kind:          s-concept              / -                     / -
;;;   data:          -                      / -                     / header, options
;;;   hook:          -                      / -                     / initialization
;;;   p-cases:       use-cases-of-system p-cases p-cases-plan / -   / -
;;;   flows:         use-case               / scenario              / path (receiving, sending, forwarding)
;;;   transforms:    -                      / -                     / packet-transform (fragmentation, defragmentation)
;;;   deployment:    s-deploy               / -                     / -
;;;   setting-up:    -                      / setting-up            / -
;;;   security:      s-security             / -                     / -
;;;   lessons:       s-lessons              / -                     / -
;;;   summary:       -                      / -                     / summary
;;;   quick-ref:     -                      / -                     / quick-reference
(in-package :rst)
(defdocument ExplainProgramFrame)

(defrule document -> title sections)
(defrule title -> :instruction "説明するプログラムの名前を題にする。設計だけ、実装だけを説明するなら、その語を添える")
(defrule sections -> s1)
;; The nucleus is what the program is and does (p-what). Every other part says, by its relation, what it does for
;; the nucleus. A part marked :rank secondary is far from the nucleus by its relation: it is about the text or the
;; reader rather than the program (p-prev, code-reading, code-whereabouts, setting-up), adds a side fact
;; (p-spec, p-scale, security, quick-ref), or evaluates or restates (lessons, summary). It can be left out.
;;   steps from the nucleus  part
;;   0                       p-what
;;   1                       orientation (p-plan), kind, data-sections, behaviour (flow-sections), conditional-tasks (p-tasks),
;;                           deployment; secondary: p-spec, p-scale, code-whereabouts, security, lessons, summary, quick-ref
;;   2                       hook, p-cases, transform-sections; secondary: p-prev, code-reading, setting-up
(defrule s1 -> program :heading "## Program")
(defrule program -> :background orientation :nucleus p-what
                    :elaboration-additional p-spec :elaboration-additional p-scale
                    :background kind :elaboration-object-attribute data-sections
                    :elaboration-part-whole behaviour :elaboration-part-whole conditional-tasks
                    :elaboration-object-attribute deployment :elaboration-additional code-whereabouts
                    :elaboration-additional security :evaluation-s lessons :summary-s summary
                    :elaboration-additional quick-ref)
(defrule orientation -> :background p-prev :nucleus p-plan)
(defrule data-sections -> data)
(defrule behaviour -> :background hook :background code-reading :enablement setting-up :background p-cases :nucleus flow-sections)
(defrule flow-sections -> flows)
(defrule conditional-tasks -> :nucleus p-tasks :elaboration-general-specific transform-sections)
(defrule transform-sections -> transforms)
(defrule code-reading -> :nucleus p-easy :elaboration-additional p-new :rank secondary)
(defrule code-whereabouts -> :nucleus p-code-dirs :elaboration-set-member p-code-dirs-list :elaboration-additional p-versions :rank secondary)

;; where this explanation stands against what the reader has read (ipv4 p-prev, implementation p-roadmap/design)
(defrule p-prev -> :background p-prev/before :nucleus p-prev/n :rank secondary)
(defrule p-prev/before -> :instruction "読み手が前に読んだもの（前の章、同じプログラムの設計）が何を扱ったかを 1 文で書く。つながりが無ければ段落ごと書かない"
  :sample "Chapter 3 deals with the implementation of the ICMP protocol in IPv4 and in IPv6. / After seeing the design of the FileBuy application, we are now ready to see its implementation.")
(defrule p-prev/n -> :instruction "前に読んだものが、この説明の中でどう使われるかを 1 文で書く"
  :sample "This chapter, which deals with the IPv4 protocol, shows how ICMP messages are used for reporting Internet protocol errors under certain circumstances.")

;; what this explanation presents, in what order, and how to read it (design p-plan, implementation p-roadmap, ipv4 p-covers)
(defrule p-plan -> :nucleus p-plan/n :elaboration-process-step p-plan/order :antithesis p-plan/not :elaboration-additional p-plan/read)
(defrule p-plan/n -> :instruction "この説明がどのプログラムの何（設計、実装、ある部分）を示すのかを 1 文で書く"
  :sample "In this chapter we present an overview of the design of FileBuy. / This chapter describes the IPv4 Linux implementation: receiving and sending IPv4 packets, including multicast packets, IPv4 forwarding, and handling IPv4 options.")
(defrule p-plan/order -> :instruction "何をどの順に扱うか（種類の考え方、どの図法で何個の流れをたどるか、最後に何を扱うか）を 1〜2 文で書く"
  :sample "FileBuy is a resource brokering system, and so we begin with a conceptual overview of resource brokering. Then, using a simplified form of UML, we walk through three usage scenarios of the system.")
(defrule p-plan/not -> :instruction "コードの動作を全部は説明しないなら、それを 1 文で書く。全部説明するなら書かない"
  :sample "This chapter is meant as a roadmap to the FileBuy code, and not a comprehensive explanation of every single action that takes place in the implementation.")
(defrule p-plan/read -> :instruction "コードを手元に開いて読む必要があれば、それを 1 文で勧める。無ければ書かない"
  :sample "As such, this chapter is meant to be read with the FileBuy code in front of you.")

;; what the program is, what it does, and between whom (design p-system-what, ipv4 p-what p-functions)
(defrule p-what -> :nucleus p-what/n :elaboration-additional p-what/role :elaboration-additional p-what/does
                   :elaboration-object-attribute p-what/roles :elaboration-additional p-what/objects :elaboration-additional p-what/elsewhere)
(defrule p-what/n -> :instruction "このプログラムが何であるかを、正式な名前とともに、誰と誰の間で何をするものかで 1 文で書く"
  :sample "The IPv4 protocol (Internet Protocol version 4) is one of the core protocols of today's standards-based Internet / FileBuy is a resource brokering system that enables buyers to purchase files from sellers linked by a wide-area network.")
(defrule p-what/role -> :instruction "それが世の中や大きなシステムのどれだけの部分を担っているかを 1 文で書く。言うことが無ければ書かない"
  :sample "and routes most of the traffic on the Internet.")
(defrule p-what/does -> :instruction "このプログラムが提供する一番の働きと、ほかの大事な働きを 1〜2 文で書く"
  :sample "The IPv4 protocol provides an end-to-end connectivity between any two hosts. Another important function of the IP layer is forwarding packets (also called routing) and managing tables that store routing information.")
(defrule p-what/roles -> :instruction "このプログラムの参加者が、後で説明する種類のシステムのどの役割に当たるかを 1〜2 文で書く。種類を説明しないなら書かない"
  :sample "In our system the sellers represent resource producers and the buyers represent resource consumers. Interactions between the two are mediated by the FileBuyBroker.")
(defrule p-what/objects -> :instruction "このプログラムが扱う対象が、ふつう思われるものと違うなら、それが何かを 1 文で書く。違わなければ書かない"
  :sample "The \"resources\" in a FileBuy VO are not CPUs nor storage capacity, but data files.")
(defrule p-what/elsewhere -> :instruction "働きのうち、この説明では扱わず別の章や文書で扱うものと、その場所を 1 文で書く。無ければ書かない"
  :sample "Chapters 5 and 6 discuss IPv4 routing.")

;; where the program is defined (ipv4 p-spec)
(defrule p-spec -> :nucleus p-spec/n :rank secondary)
(defrule p-spec/n -> :instruction "このプログラムが実装している規格や仕様の文書があれば、番号と題と年で 1 文で書く。無ければ段落ごと書かない"
  :sample "The base definition is in RFC 791, \"Internet Protocol,\" from 1981.")

;; tasks needed only under a condition (ipv4 p-tasks)
(defrule p-tasks -> :condition p-tasks/when :nucleus p-tasks/n :elaboration-additional p-tasks/reverse :elaboration-additional p-tasks/also)
(defrule p-tasks/when -> :instruction "ふだんの働きの並びに入っていないが、ある条件で必要になる仕事があれば、その条件を 1 文で書く。無ければ段落ごと書かない"
  :sample "There are cases when the packet to be sent is bigger than the MTU of the outgoing interface;")
(defrule p-tasks/n -> :instruction "その条件で何をしなければならないかを 1 文で書く" :sample "in such cases the packet should be fragmented into smaller fragments.")
(defrule p-tasks/reverse -> :instruction "相手の側でその逆に何をし、結果が何と一致しなければならないかを 1 文で書く。逆の仕事が無ければ書かない"
  :sample "When fragmented packets are received, they should be assembled into one big packet, which should be identical to the packet that was sent before it was fragmented.")
(defrule p-tasks/also -> :instruction "それらもこの説明で扱うと 1 文で書く" :sample "These are also important tasks of the IPv4 protocol discussed in this chapter.")

;; how many of each participant one deployment has (design p-system-scale)
(defrule p-scale -> :nucleus p-scale/n :example p-scale/fig :rank secondary)
(defrule p-scale/n -> :instruction "1 つの配置に各参加者がどれだけいるかを 1 文で書き、図を指す。参加者が分かれていなければ段落ごと書かない"
  :sample "A FileBuy VO is made up of one broker and (potentially) hundreds of buyers, sellers, and files.")
(defrule p-scale/fig -> :instruction "参加者の配置を描いた図を示す" :kind image)

;; what of the code the reader can already read, and what is new (implementation p-easy p-new)
(defrule p-easy -> :nucleus p-easy/n :elaboration-additional p-easy/appeal :comparison p-easy/before)
(defrule p-easy/n -> :instruction "コードの大半が、何を読んでいれば読めるかを 1 文で書く。読み手の前提を言う必要が無ければ段落ごと書かない"
  :sample "Most of the code should be easy to read if you have read all the previous chapters (or, at the very least, the Java WS Core chapters).")
(defrule p-easy/appeal -> :instruction "このコードの見どころ（設計の図がコードのどこにどう現れるか）を 1 文で書く"
  :sample "The main appeal of this code is that it involves several services interacting with each other, so it'll be interesting to see how the sequence diagrams in the previous chapter translate to code.")
(defrule p-easy/before -> :instruction "読み手が前に見た例とどこが違うかを 1 文で書く。違いが無ければ書かない" :sample "In all the MathService examples control never flowed from one service to another.")
(defrule p-new -> :nucleus p-new/n)
(defrule p-new/n -> :instruction "読み手が初めて見るコードが何に関わるものかを 1 文で書き、それは説明すると言う。無ければ段落ごと書かない"
  :sample "Even so, there are a few bits and pieces of code that are completely new, especially those that deal with the GT4 Index Service, and we will provide an explanation for those.")

;; where the code is (implementation p-code-dirs p-code-dirs-list)
(defrule p-code-dirs -> :nucleus p-code-dirs/n)
(defrule p-code-dirs/n -> :instruction "コード全体をどこから手に入れられるかを書き、構成要素ごとの置き場所を挙げると言う。置き場所を部分ごとに説明するなら段落ごと書かない"
  :sample "A complete implementation is available for download at the book's website. Each of the four services explained in the previous chapter can be found in the following directories:")
(defrule p-code-dirs-list -> :instruction "構成要素 1 つにつき 1 項目で、名前と置き場所のディレクトリを挙げる。インターフェースの定義の置き場所も含める。上の段落を書かなければ空にする"
  :sample "File Broker service: $EXAMPLES_DIR/org/globus/examples/services/filebuy/broker/ / the WSDL files: $EXAMPLES_DIR/schema/examples/filebuy/"
  :kind bullet)

;; which version of the code, and what it needs to run (implementation p-versions)
(defrule p-versions -> :nucleus p-versions/n :reason p-versions/because)
(defrule p-versions/n -> :instruction "このコードの版と、動かすのに要る土台の最低の版を 1〜2 文で書く。版の決まりが無ければ段落ごと書かない"
  :sample "The version of FileBuy described in this chapter is version 1.0. The FileBuy application requires at least version 4.0.1 of the toolkit.")
(defrule p-versions/because -> :instruction "それより前の版では何が起きるかを 1 文で書く" :sample "A small bug in GT4.0.0 prevents some of the code from compiling and running correctly.")

;; the kind of system the program belongs to (design s-concept)
(defrule kind -> :instruction "このプログラムが属する種類のシステムを、構成要素とそのやりとりで説明する。種類を説明する必要が無ければ空にする"
  :include "explain-program.kind.lisp" :heading "### The kind of system")

;; the data the program reads and writes (ipv4 header, options)
(defrule data -> :instruction "このプログラムが読み書きするデータの形式（ヘッダ、その省略できる部分、ファイルの形式、メッセージ）を、1 行に 1 つ、説明する順に挙げる。説明しなければ空にする"
  :frame "explain-program.data.lisp")

;; how input reaches the program (ipv4 initialization)
(defrule hook -> :instruction "このプログラムが土台（カーネル、入れ物、フレームワーク）に自分を登録し、入力が自分のメソッドに届くようにするところを説明する。説明しなければ空にする"
  :include "explain-program.hook.lisp" :heading "### Initialization")

;; the flows taken up, and how each is told (design p-cases p-cases-plan)
(defrule p-cases -> :nucleus p-cases/n :example p-cases/fig :elaboration-process-step p-cases/plan)
(defrule p-cases/n -> :instruction "たどる流れ（利用場面、道筋）を、番号を付けて 1 文で挙げ、全体の図があれば指す。流れが 1 つなら段落ごと書かない"
  :sample "We consider three key use cases of the system: (1) advertising a file, (2) finding a file and (3) purchasing a file (Figure 23.6). / The main functionality of the IPv4 protocol is divided into the Rx (receive) path and the Tx (transmit) path.")
(defrule p-cases/fig -> :instruction "流れの全体を描いた図（ユースケース図）を示す。無ければ空にする" :kind image)
(defrule p-cases/plan -> :instruction "各流れを何の順に説明するか（やりとりの順、設計上の決定、一般的な考え方）を 1〜2 文で書く。流れごとに違えば書かない"
  :sample "We begin by walking through the sequence of component interactions for each use case. A brief explanation of key design decisions follows. Then each use case study concludes with highlights of important general concepts.")

;; the flows, one by one (design use-case, implementation scenario, ipv4 path)
(defrule flows -> :instruction "このプログラムを通る流れ（利用場面、データの道筋）を、1 行に 1 つ、説明する順に、流れの名前で挙げる"
  :frame "explain-program.flow.lisp")

;; transformations done one way and undone the other (ipv4 packet-transform)
(defrule transforms -> :instruction "このプログラムが一方の向きで行い、他方の向きで元に戻す変換（分割と組み立て直し、圧縮と展開、暗号化と復号）を、1 行に 1 つ挙げる。無ければ空にする"
  :frame "explain-program.transform.lisp")

;; where the parts run (design deployment)
(defrule deployment -> p-deploy-hosts p-deploy-fig :heading "### Deployment")
(defrule p-deploy-hosts -> :nucleus p-deploy-hosts/n :comparison p-deploy-hosts/before :elaboration-set-member p-deploy-hosts/platforms)
(defrule p-deploy-hosts/n -> :instruction "このプログラムを何台の機械やプロセスに分けて置くかが、読み手が前に見た例とどう違うかを 1 文で書く。1 か所で動くなら節ごと書かない"
  :sample "Unlike the MathService example seen throughout the book, the deployment of FileBuy is more complex as it involves multiple hosts.")
(defrule p-deploy-hosts/before -> :instruction "前に見た例ではどう配置していたかを 1 文で書く。比べる例が無ければ書かない"
  :sample "With MathService, we were quite content to deploy the service on our local container, and invoke it from our own machine.")
(defrule p-deploy-hosts/platforms -> :instruction "何種類の機械に分けて置くかを、種類の名前とともに 1 文で書く"
  :sample "FileBuy is intended to be deployed across three types of platforms: the buyer, the broker, and the seller.")
(defrule p-deploy-fig -> :nucleus p-deploy-fig/n :elaboration-additional p-deploy-fig/legend :example p-deploy-fig/fig)
(defrule p-deploy-fig/n -> :instruction "配置図が何を示すかを 1 文で書く" :sample "Figure 23.10 contains an overview of the components deployed on each platform, and the relationship between each component.")
(defrule p-deploy-fig/legend -> :instruction "配置図の線の種類ごとに、何を表すかを 1 文で書く" :sample "The straight arrows represent communication dependencies, while the dotted arrows represent creation of WS-Resources.")
(defrule p-deploy-fig/fig -> :instruction "配置図を示す" :kind image)

;; what to prepare before any flow can be tried (implementation setting-up)
(defrule setting-up -> :instruction "どの流れを試すより前に用意しておくもの（機械、入れるもの、設定）を説明する。用意が要らなければ空にする"
  :include "explain-program.setting-up.lisp" :heading "### Setting up" :rank secondary)

;; the security decisions (design s-security)
(defrule security -> p-sec-matters p-sec-tradeoff security-decisions :heading "### Security" :rank secondary)
(defrule p-sec-matters -> :nucleus p-sec-matters/n :reason p-sec-matters/because)
(defrule p-sec-matters/n -> :instruction "このプログラムで安全性がなぜ大事かを、参加者の性質から 1〜2 文で書く。安全性を論じないなら節ごと書かない"
  :sample "Security is a primary concern in the context of Grid computing, as Grid-based collaborations involve people from multiple administrative domains sharing important resources.")
(defrule p-sec-matters/because -> :instruction "参加者が協力していても守る必要がある理由を 1 文で書く"
  :sample "While participants in a VO agree in principle to work together, that openness increases the importance of protecting the system from naive or intentional misuse.")
(defrule p-sec-tradeoff -> :background p-sec-tradeoff/q :nucleus p-sec-tradeoff/n :elaboration-additional p-sec-tradeoff/challenge)
(defrule p-sec-tradeoff/q -> :instruction "すべての安全機構を使えばよいのでは、という問いを 1 文で立てる" :sample "So why not lock everything down with a full complement of security mechanisms?")
(defrule p-sec-tradeoff/n -> :instruction "そうしない理由（安全機構が何を犠牲にするか）を 1 文で答える" :sample "The answer is simple: runtime security adversely affects performance.")
(defrule p-sec-tradeoff/challenge -> :instruction "だから設計者が何と何を釣り合わせ、何で決めるかを 1〜2 文で書く"
  :sample "The challenge for the system designer is to minimize the potential for exploits while at the same time optimizing for performance.")
(defrule security-decisions -> :instruction "このプログラムで下した安全上の決定を、1 行に 1 つ、決める事柄の名前（認証、通信の秘匿と完全性、認可、監査など）で挙げる"
  :frame "explain-program.decision.lisp" :heading "#### Security decisions")

;; what the design teaches (design s-lessons)
(defrule lessons -> :instruction "この設計から読み手が持ち帰るべき設計の原則を、1 行に 1 つ挙げる。無ければ空にする"
  :frame "explain-program.lesson.lisp" :heading "### Summing up" :rank secondary)

;; what the explanation covered (ipv4 summary)
(defrule summary -> summary/p :heading "### Summary" :rank secondary)
(defrule summary/p -> :nucleus summary/n :elaboration-additional summary/parts :elaboration-additional summary/special :elaboration-additional summary/next)
(defrule summary/n -> :instruction "この説明が扱ったことを、プログラムと、その中で説明したデータで 1 文で書く。まとめを書かないなら節ごと書かない"
  :sample "This chapter dealt with the IPv4 protocol—how an IPv4 packet is built, the IPv4 header structure and IP options, and how they are handled.")
(defrule summary/parts -> :instruction "説明した流れ（登録、受信、送信、利用場面）を、読み手が知ったこととして 1〜2 文で並べる"
  :sample "You learned how the IPv4 protocol handler is registered. You also learned about the Rx path and about the Tx path in IPv4.")
(defrule summary/special -> :instruction "特別な場合として扱ったことを、なぜ要るかとともに 1〜3 文で書く。無ければ書かない"
  :sample "There are cases when packets are larger than the network interface MTU, and as a result they can't be sent without being fragmented on the sender side and later defragmented on the receiver side.")
(defrule summary/next -> :instruction "次に何を読むとよいか、この後に何が続くかを 1〜2 文で書く"
  :sample "The next chapter discusses the IPv4 routing subsystem. The \"Quick Reference\" section that follows covers the top methods that are related to the topics discussed in this chapter.")

;; the methods and macros, each with what it does (ipv4 quick-reference)
(defrule quick-ref -> qr/intro qr-methods qr-macros :heading "### Quick reference" :rank secondary)
(defrule qr/intro -> :nucleus qr/intro/n)
(defrule qr/intro/n -> :instruction "説明で出てきた大事なメソッドやマクロを短く並べて終える、と 1 文で書く。早見表を作らないなら節ごと書かない"
  :sample "I conclude this chapter with a short list of important methods and macros of the IPv4 subsystem that were mentioned in this chapter.")
(defrule qr-methods -> :instruction "説明で出てきたメソッドを、文脈の順に、1 行に 1 つ名前で挙げる" :frame "explain-program.reference-entry.lisp" :heading "#### Methods")
(defrule qr-macros -> :instruction "説明で出てきたマクロや定数を、1 行に 1 つ名前で挙げる。無ければ空にする" :frame "explain-program.reference-entry.lisp" :heading "#### Macros")
