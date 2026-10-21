;;; one general concept a flow shows: the concept, and what it gives the program or its participants
;;; from: design.concept.lisp
(defrule concept -> :nucleus concept/n :result concept/gives)
(defrule concept/n -> :instruction "この流れが示す一般的な考え方を、名前とともに 1 文で書く"
  :sample "This scenario illustrates the process of discovery, in which resources are identified based on their attributes (as opposed to using EPRs directly).")
(defrule concept/gives -> :instruction "その考え方がプログラムや参加者に何をもたらすか、なぜ必要かを 1 文で書く"
  :sample "The ability to discover resources is a fundamental requirement of Grid computing, as it enables the formation of dynamic systems that do not depend on the existence of specific resources.")
