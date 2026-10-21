;;; use: Writes a request letter: what the requester is about to do and what it asks the receiver to set up before
;;;      that, the scope the requests serve, and each request with what to run or add, what to do along with it,
;;;      and the conditions on it, each with its reason.
;;; made-from: the request letter sent for the k8s-pups-with-audit deployment (an e-mail to the team that runs Vault
;;;            and HAProxy), put into rst-on-lisp meaning structure; the samples name the account and the machine
;;;            by placeholders
;;; members: p-overview p-overview/list p-scope p-detail; per request p-run p-run/code p-token p-routes p-routes/list p-rules
;;; integrates: RequestDocumentTemplate_261019_oo01 (a template written before any request letter was taken apart; its
;;;             parts that the letter does not have are kept, each left empty when it does not apply):
;;;   overview/cannot     the reason the requester cannot do the work itself
;;;   background       what the requester's system is, who uses it, and what stops without the receiver's work
;;;   request/act/after, request/reason (in the sub-frame)
;;;   s-confirm        what the requester checks when the receiver reports the work done
;;;   s-contact        whom to tell, and how, when something is unclear or a value must change (:rank secondary)
;;; left-out: none
;;; nucleus: what the requester asks for (overview/n). The plan is its background; the list of requests, the scope
;;;          and each request elaborate it. The pointers to the attached document are :rank secondary.
(in-package :rst)
(defdocument RequestLetterFrame)

(defrule document -> title sections)
(defrule title -> :instruction "頼む設定や作業を名詞句にし、「〜のお願い」の形で題にする" :sample "k8s-pups-with-audit の配備前の設定のお願い")
(defrule sections -> s-overview s-background requests s-confirm s-contact)

;; what the requester is about to do, what it asks for, the list of requests, the scope, and where the details are
(defrule s-overview -> overview :heading "## 依頼の概要")
(defrule overview -> :background overview/plan :nucleus overview/n :reason overview/cannot :elaboration-set-member overview/list
                     :elaboration-additional scope :elaboration-additional detail)
(defrule overview/plan -> :instruction "頼む側がこれから何をするのか（どこに何を配備する、何を始める）を 1 文で書く"
  :sample "個人ゲノム解析区画の Kubernetes（<計算機> の k0s）に、新しいサービス k8s-pups-with-audit を配備します。")
(defrule overview/n -> :instruction "それの前に（またはそのために）宛先にいくつのお願いがあるかを、「〜をお願いします」の形で 1 文で書く。宛先が宛名などで分からないなら、宛先（チーム名や担当）も書く"
  :sample "配備の前に、次の2つの設定をお願いします。")
(defrule overview/cannot -> :instruction "頼む側が自分でその作業を行えない理由（権限が無い、宛先の管理するシステムである）を 1 文で書く。宛先にとって明らかなら書かない")
(defrule overview/list -> :instruction "お願いを 1 項目に 1 つ、宛先のどのシステムに何を作るか足すかで挙げる"
  :sample "Vault に、このサービス専用の置き場、ポリシー、ロール、シークレットを作る。 / HAProxy に、許可した送信元からの /pups-with-audit と /pups-with-audit-auth を <計算機> の k0s に転送する経路を足す。"
  :kind number)
(defrule scope -> :nucleus scope/n :elaboration-additional scope/limit)
(defrule scope/n -> :instruction "お願いが仕えるもの（公開する URL、対象のサービス）を 1 文で書く。お願いの中で分かるなら段落ごと書かない"
  :sample "公開 URL は https://sc.ddbj.nig.ac.jp/pups-with-audit です。")
(defrule scope/limit -> :instruction "その範囲に制限があれば、制限の理由とともに 1 文で書く。無ければ書かない"
  :sample "テスト段階なので全世界には公開せず、遺伝研内(133.39.xxx.xxx)からの接続だけを受け付けます。")
(defrule detail -> :nucleus detail/n :rank secondary)
(defrule detail/n -> :instruction "細かい手順や値を添付の文書に分けたなら、それを指す 1 文を書く。添付が無ければ段落ごと書かない" :sample "詳細は、添付の文書参照。")

;; the requester's system, for a receiver who does not know it (from the template)
(defrule s-background -> background :heading "## 背景")
(defrule background -> :nucleus background/n :elaboration-additional background/users :consequence-s background/stops)
(defrule background/n -> :instruction "頼む側のシステムが何であるかを 1 文で書く。宛先がすでに知っているなら節ごと書かない")
(defrule background/users -> :instruction "誰が何のために使うかを 1 文で書く")
(defrule background/stops -> :instruction "宛先の作業が無いと、何が止まるかを 1 文で書く")

;; the requests, one section each, in the order of the overview's list
(defrule requests -> :instruction "お願いを、概要の番号の順に、1 行に 1 つ、宛先のシステムの名前と「の設定」で挙げる"
  :frame "request-letter.request.lisp")

;; how the requester will check the work once the receiver reports it done (from the template)
(defrule s-confirm -> confirm-intro confirm-table :heading "## 設定後の確認")
(defrule confirm-intro -> :nucleus confirm-intro/n)
(defrule confirm-intro/n -> :instruction "作業が終わったら何を知らせてほしいかと、頼んだ側が何を確かめるかを 1 文で書く。確かめる手段を頼む側が持たないなら節ごと書かない")
(defrule confirm-table -> :instruction "確かめる項目 1 つにつき 1 行で、項目、確かめ方、期待する結果を並べた表。1 行目は見出しの行" :kind table)

;; whom to tell when something is unclear (from the template); a reply to the letter usually does this
(defrule s-contact -> contact :heading "## 連絡" :rank secondary)
(defrule contact -> :nucleus contact/n)
(defrule contact/n -> :instruction "不明な点や、値を変える必要が生じた点を、誰にどの経路で伝えてほしいかを 1 文で書く。依頼文への返信で足りるなら節ごと書かない")
