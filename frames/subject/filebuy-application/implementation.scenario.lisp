;;; one usage scenario's implementation: how to read it against its sequence diagram, the operations it runs through, the clients, and trying it out
;;; members: p-sc1-follow p-sc1-parts (24.2), p-sc2-parts (24.3), p-sc3-parts (24.4)
;;; children: each operation is one copy of implementation.service-operation.lisp; each client is one copy of implementation.client.lisp;
;;;           trying it out is implementation.trying-it-out.lisp (:include)
(defrule scenario -> scenario/follow scenario/parts scenario/operations scenario/clients scenario/try :heading "### {item}")
;; how to read the scenario: against its sequence diagram, services before clients (p-sc1-follow p-sc3-parts)
(defrule scenario/follow -> :nucleus scenario/follow/n :elaboration-additional scenario/follow/fig :elaboration-additional scenario/follow/order)
(defrule scenario/follow/n -> :instruction "どの利用場面の実装を見るかを 1 文で書く" :sample "We begin by taking a look at the implementation of the first usage scenario.")
(defrule scenario/follow/fig -> :instruction "設計のどのシーケンス図と突き合わせて読むかを 1 文で書く"
  :sample "You should review Figure 23.7 to see how the sequence of events described here matches the one shown in the sequence diagram.")
(defrule scenario/follow/order -> :instruction "どの順に見ていくか（どの構成要素を先にし、どれを後に回すか）と、その理由を 1 文で書く。前の場面と同じなら書かない"
  :sample "We will defer the explanation of the client applications to the very end, as they only perform very simple invocations. The interesting code will mainly be in the services.")
;; which components take part, and which steps are not coded by us (p-sc1-parts p-sc2-parts p-sc3-parts)
(defrule scenario/parts -> :nucleus scenario/parts/n :elaboration-additional scenario/parts/not-ours)
(defrule scenario/parts/n -> :instruction "この場面に関わる構成要素が、どの機械のどれかを 1 文で書く"
  :sample "This scenario involves a client application in the buyer's machine and two services deployed in the broker's machine.")
(defrule scenario/parts/not-ours -> :instruction "シーケンス図の手順のうち、自分たちが書いたのではない構成要素が受け持つものと、それを誰が行うかを 1〜2 文で書く。無ければ書かない"
  :sample "Although step 5 involves the broker's index, this step is not performed by us. The broker's index automatically retrieves the data in the seller's local index because we configured the broker's index as the upstream index.")
;; the operations, in the order of the sequence diagram
(defrule scenario/operations -> :instruction "この場面で呼ばれるサービスの操作を、シーケンス図の順に、1 行に 1 つ「サービス名: 操作名」で挙げる"
  :frame "implementation.service-operation.lisp")
;; the clients that start the scenario
(defrule scenario/clients -> :instruction "この場面を始めるクライアントを 1 行に 1 つ挙げる。サービスが兼ねていて独立のクライアントが無ければ空にする"
  :frame "implementation.client.lisp")
;; trying the scenario out
(defrule scenario/try -> :instruction "この場面を実際に動かして確かめる手順を説明する" :include "implementation.trying-it-out.lisp" :heading "#### Trying it out")
