;;; one operation of one service: what it does with what, how the service is built, where its code is, what it does in order,
;;; what it leaves behind, the decisions it carries out, and its interesting code
;;; members: 24.2.1 (p-ffs-what p-ffs-where p-ffs-steps p-persist), 24.3.1 (p-fb-what p-fb-factory p-fb-where p-fb-blocks p-fb-order p-fb-redundant p-fb-status),
;;;          24.4.1 (p-buy-start p-buy-state p-buy-deleg p-buy-where), 24.4.2 (p-relay p-relay-where), 24.4.3 (p-fill p-fill-where),
;;;          24.4.4 (p-xfer p-xfer-where), 24.4.5 (p-recv p-recv-steps), 24.4.6 (p-report)
;;; children: each interesting code snippet is one copy of implementation.code-snippet.lisp
(defrule operation -> operation/what operation/built operation/where operation/steps-intro operation/steps operation/state operation/snippets :heading "#### {item}")
;; what the operation does, with what, and what it returns (p-ffs-what p-fb-what p-relay p-fill p-xfer p-recv p-report)
(defrule operation/what -> :nucleus operation/what/n :elaboration-additional operation/what/params :elaboration-additional operation/what/returns)
(defrule operation/what/n -> :instruction "どのサービスのどの操作が、この場面で何を受け持つかを 1 文で書く"
  :sample "In this scenario we are only interested in the addFile operation in the factory service, which will be the one responsible for creating File resources.")
(defrule operation/what/params -> :instruction "操作が受け取るものを 1 文で書く" :sample "This operation expects three parameters: the name of the file to add, the location of the file, and the price at which it will be offered.")
(defrule operation/what/returns -> :instruction "うまくいったとき、いかなかったときに、それぞれ何を返すか、何が起きるかを 1〜2 文で書く"
  :sample "If we are successful in finding a file meeting the specified criteria, a new File Order WS-Resource is created and its EPR is returned, along with the price of the file. Otherwise, a null EPR is returned.")
;; how the service is built, and why that way (p-ffs-what p-fb-factory p-buy-start p-buy-state p-buy-deleg)
(defrule operation/built -> :nucleus operation/built/n :reason operation/built/because :comparison operation/built/usual)
(defrule operation/built/n -> :instruction "このサービスがどう組み立てられているか（いくつのサービスに分かれるか、状態を持つか、クライアントを兼ねるか）を 1 文で書く。前の操作と同じサービスなら書かない"
  :sample "As mentioned in the design, this particular service is not divided into a factory service and instance service.")
(defrule operation/built/because -> :instruction "設計のどの決定がその組み立て方を求めたかを 1〜2 文で書く"
  :sample "As a simple precaution against receiving unexpected transfers, we will make this service stateful and we will store the name of the file which we expect to receive.")
(defrule operation/built/usual -> :instruction "それまでの例の組み立て方と比べ、何が簡単になり何を代償にするかを 1〜2 文で書く。比べるものが無ければ書かない"
  :sample "A simpler way of implementing the WS-Resource factory pattern is to have all the code in a single service. This results in simpler code, but one that forces us to have the factory code and the instance code in the same container.")
;; where the code is (p-ffs-where p-fb-where p-buy-where p-relay-where p-fill-where p-xfer-where)
(defrule operation/where -> :nucleus operation/where/n)
(defrule operation/where/n -> :instruction "この操作のコードがどのファイルにあるかを 1 文で書く。操作の一部が別のクラスで行われるなら、そのファイルも書く"
  :sample "The implementation of the factory service can be found in $EXAMPLES_DIR/org/globus/examples/services/filebuy/seller/impl/FilesForSaleFactoryService.java")
;; what the operation does, in order (p-ffs-steps p-fb-blocks p-recv-steps)
(defrule operation/steps-intro -> :nucleus operation/steps-intro/n)
(defrule operation/steps-intro/n -> :instruction "操作が呼ばれた後に起きることを順に挙げると 1 文で導入する" :sample "Once the addFile operation is invoked, three interesting things happen:")
(defrule operation/steps -> :instruction "操作の中で起きることを、起きる順に 1 項目に 1 つ挙げる。条件で分かれるところは、条件ごとに項目を立てる。後で説明する項目にはその旨を書く"
  :sample "First of all, we query the Index Service to see if there are any files with the specified name. / If the query doesn't return anything, the method ends there and we return a null EPR. / If the cheapest file meets the price restriction, we create a FileOrder resource and return its EPR."
  :kind number)
;; what the operation leaves behind for later, and why each piece is kept (p-fb-order p-fb-redundant p-fb-status p-persist)
(defrule operation/state -> :nucleus operation/state/n :reason operation/state/because :elaboration-additional operation/state/more)
(defrule operation/state/n -> :instruction "操作が後の操作のために残すもの（資源に何を入れるか、永続化するか）を 1 文で書く。残さなければ段落ごと書かない"
  :sample "We will be interested in storing the File WS-Resource's EPR in the FileOrder resource (as a resource property), so we can later refer to it and request that it be transferred to the buyer.")
(defrule operation/state/because -> :instruction "余分に見えるものを残すなら、それで何が省けるかと、残す代償を 1〜2 文で書く"
  :sample "This might seem redundant, but it will save us an extra trip to the File WS-Resource in the next scenario. Storing a redundant piece of information is sometimes acceptable, if the performance gain outweighs the cost.")
(defrule operation/state/more -> :instruction "ほかに残すもの（状態を表す値など）と、その値の取りうる範囲を 1 文で書く"
  :sample "We will also include an OrderStatus resource property indicating the status of our order. This property has four possible values: NEW, TRANSFERING, FAILED, and COMPLETED.")
;; the interesting code snippets
(defrule operation/snippets -> :instruction "この操作のコードのうち、それまでの章に無く説明が要る部分を、1 行に 1 つ挙げる。無ければ空にする"
  :frame "implementation.code-snippet.lisp" :heading "##### Interesting code snippets")
