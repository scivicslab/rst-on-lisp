;;; one use case: the sequence of interactions with its diagram, the design decisions it involves, the general concepts it shows
;;; members: 23.3.1 23.3.2 23.3.3 (each has Overview, Design Details, General Concepts)
(defrule use-case -> use-case/overview use-case/details use-case/concepts)
(defrule use-case/overview -> use-case/seq use-case/steps :heading "##### Overview")
(defrule use-case/seq -> :nucleus use-case/seq/n :example use-case/seq/fig)
(defrule use-case/seq/n -> :instruction "この利用場面を、誰の立場から見るかとともに 1 文で導入し、シーケンス図を指す"
  :sample "We now switch to the buyer's perspective, and explore what happens when a buyer needs to find a file. Figure 23.8 shows the sequence diagram for this use case:")
(defrule use-case/seq/fig -> :instruction "この利用場面のシーケンス図を示す。図の矢印の番号は、次の手順の番号と合わせる" :kind image)
(defrule use-case/steps -> :instruction "シーケンス図の矢印 1 本を 1 項目にして、起きる順に挙げる。項目ごとに、どの構成要素がどの構成要素のどの操作を、何を渡して呼ぶかを書き、その結果できるものや変わるものがあれば添える"
  :sample "The FindFile client invokes the Find operation on the FileBuy Broker, which is deployed on the broker's container. / If there is at least one entry returned from the search, FileBuy Broker creates a File Order resource. / FileBuy Broker then returns the File Order EPR along with the cost of the file to the FindFile client."
  :kind number)
(defrule use-case/details -> :instruction "この利用場面に関わる設計上の決定を、1 行に 1 つ、決めた事柄の名前（資源の作り方、資源の永続化、構成要素の組み立て方など）で挙げる"
  :frame "design.decision.lisp" :heading "##### Design Details")
(defrule use-case/concepts -> :instruction "この利用場面から言える一般的な考え方を、1 行に 1 つ挙げる。このシステムに限らない考え方だけを挙げる"
  :frame "design.concept.lisp" :heading "##### General Concepts")
