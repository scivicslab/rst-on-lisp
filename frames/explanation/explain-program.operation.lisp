;;; one operation or method a flow runs through: what it does and where it is called from, what it takes and returns,
;;; how its component is built and why, where its code is, what it does in order, what it leaves behind, and its code,
;;; piece by piece
;;; from: ipv4.path-method.lisp (method), implementation.service-operation.lisp (operation); the same meaning: one
;;;       operation of a flow, told with its code
;;; roles (role: method / operation):
;;;   op/what:  method/intro / operation/what
;;;   op/built: - / operation/built
;;;   op/where: - / operation/where
;;;   op/steps: - / operation/steps-intro operation/steps
;;;   op/state: - / operation/state
;;;   op/code:  method/steps / operation/snippets
(defrule operation -> op/what op/built op/where op/steps-intro op/steps op/state op/code :heading "#### {item}")
;; what it does, where it is called from, what it takes and what it returns
(defrule op/what -> :nucleus op/what/n :elaboration-additional op/what/from :elaboration-additional op/what/params :elaboration-additional op/what/returns)
(defrule op/what/n -> :instruction "どの構成要素のどの操作（どのメソッド）が、この流れで何を受け持つかを 1 文で書く"
  :sample "In this scenario we are only interested in the addFile operation in the factory service, which will be the one responsible for creating File resources. / The ipmr_forward_finish() method is very short and is shown here in its entirety.")
(defrule op/what/from -> :instruction "どのメソッドからどんな条件で呼ばれるかを 1 文で書く。前の操作の説明で分かるなら書かない"
  :sample "Now, assuming that there are no netfilter NF_INET_FORWARD hooks, the ip_forward_finish() method is invoked:")
(defrule op/what/params -> :instruction "操作が受け取るものを 1 文で書く。コードで示すなら書かない"
  :sample "This operation expects three parameters: the name of the file to add, the location of the file, and the price at which it will be offered.")
(defrule op/what/returns -> :instruction "うまくいったとき、いかなかったときに、それぞれ何を返すか、何が起きるかを 1〜2 文で書く。コードで示すなら書かない"
  :sample "If we are successful in finding a file meeting the specified criteria, a new File Order WS-Resource is created and its EPR is returned, along with the price of the file. Otherwise, a null EPR is returned.")
;; how the component is built, and why that way
(defrule op/built -> :nucleus op/built/n :reason op/built/because :comparison op/built/usual)
(defrule op/built/n -> :instruction "この操作を持つ構成要素がどう組み立てられているか（いくつに分かれるか、状態を持つか、クライアントを兼ねるか）を 1 文で書く。前の操作と同じ構成要素なら段落ごと書かない"
  :sample "As mentioned in the design, this particular service is not divided into a factory service and instance service.")
(defrule op/built/because -> :instruction "設計のどの決定がその組み立て方を求めたかを 1〜2 文で書く"
  :sample "As a simple precaution against receiving unexpected transfers, we will make this service stateful and we will store the name of the file which we expect to receive.")
(defrule op/built/usual -> :instruction "読み手が前に見た組み立て方と比べ、何が簡単になり何を代償にするかを 1〜2 文で書く。比べるものが無ければ書かない"
  :sample "A simpler way of implementing the WS-Resource factory pattern is to have all the code in a single service. This results in simpler code, but one that forces us to have the factory code and the instance code in the same container.")
;; where the code is
(defrule op/where -> :nucleus op/where/n)
(defrule op/where/n -> :instruction "この操作のコードがどのファイルにあるかを 1 文で書く。操作の一部が別のクラスで行われるなら、そのファイルも書く。コードの部分ごとに示すなら段落ごと書かない"
  :sample "The implementation of the factory service can be found in $EXAMPLES_DIR/org/globus/examples/services/filebuy/seller/impl/FilesForSaleFactoryService.java")
;; what it does, in order, in words
(defrule op/steps-intro -> :nucleus op/steps-intro/n)
(defrule op/steps-intro/n -> :instruction "操作が呼ばれた後に起きることを順に挙げると 1 文で導入する。コードの部分を順にたどるなら段落ごと書かない" :sample "Once the addFile operation is invoked, three interesting things happen:")
(defrule op/steps -> :instruction "操作の中で起きることを、起きる順に 1 項目に 1 つ挙げる。条件で分かれるところは、条件ごとに項目を立てる。後で説明する項目にはその旨を書く。上の段落を書かなければ空にする"
  :sample "First of all, we query the Index Service to see if there are any files with the specified name. / If the query doesn't return anything, the method ends there and we return a null EPR. / If the cheapest file meets the price restriction, we create a FileOrder resource and return its EPR."
  :kind number)
;; what it leaves behind for later, and why each piece is kept
(defrule op/state -> :nucleus op/state/n :reason op/state/because :elaboration-additional op/state/more)
(defrule op/state/n -> :instruction "操作が後の操作のために残すもの（資源に何を入れるか、永続化するか）を 1 文で書く。残さなければ段落ごと書かない"
  :sample "We will be interested in storing the File WS-Resource's EPR in the FileOrder resource (as a resource property), so we can later refer to it and request that it be transferred to the buyer.")
(defrule op/state/because -> :instruction "余分に見えるものを残すなら、それで何が省けるかと、残す代償を 1〜2 文で書く。無ければ書かない"
  :sample "This might seem redundant, but it will save us an extra trip to the File WS-Resource in the next scenario. Storing a redundant piece of information is sometimes acceptable, if the performance gain outweighs the cost.")
(defrule op/state/more -> :instruction "ほかに残すもの（状態を表す値など）と、その値の取りうる範囲を 1 文で書く。無ければ書かない"
  :sample "We will also include an OrderStatus resource property indicating the status of our order. This property has four possible values: NEW, TRANSFERING, FAILED, and COMPLETED.")
;; the code, piece by piece
(defrule op/code -> :instruction "この操作のコードを、先頭から段階ごとに全部たどるか、説明が要る部分だけを選ぶかを決め、その部分を 1 行に 1 つ、何をする部分かの名前で挙げる。入力を落とす検査は検査と分かる名前にする。説明の要るコードが無ければ空にする"
  :frame "explain-program.code-piece.lisp")
