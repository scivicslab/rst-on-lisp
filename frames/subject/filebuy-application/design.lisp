;;; subject: globus-toolkit-4 23 Design (Part IV The FileBuy Application): the design of one distributed system, told with a simplified UML before any code is written
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap23/globus_toolkit_p391-400 / ch23
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap23/globus_toolkit_p401-410 / s2331 s2332 s2333 s234 s235 s236
;;; children: each section is one child frame, put in with :include; the children list their own members and left-out paragraphs
;;; elsewhere: s225 -> 22.5 The Delegation Service; part4 (p-part-before p-part-filebuy p-part-two) -> Part IV; p-deploy-single -> 24.1.1 Running FileBuy on a Single Machine
(in-package :rst)
(defdocument DesignFrame)

(defrule document -> title sections)
(defrule title -> :instruction "設計を説明するシステムの名前と「設計」を題にする")
(defrule sections -> s1)
(defrule s1 -> p-plan s-concept s-system s-cases s-deploy s-security s-lessons :heading "## Design")
;; what the chapter presents, in order (p-design-plan)
(defrule p-plan -> :nucleus p-plan/n :background p-plan/kind :elaboration-process-step p-plan/scenarios :elaboration-process-step p-plan/end)
(defrule p-plan/n -> :instruction "この章がどのシステムの設計を示すのかを 1 文で書く" :sample "In this chapter we present an overview of the design of FileBuy.")
(defrule p-plan/kind -> :instruction "そのシステムがどの種類のシステムで、だからまずその種類の考え方から説明する、と 1 文で書く"
  :sample "FileBuy is a resource brokering system, and so we begin with a conceptual overview of resource brokering.")
(defrule p-plan/scenarios -> :instruction "どの図法で、いくつの利用場面をたどるかを 1 文で書く" :sample "Then, using a simplified form of UML, we walk through three usage scenarios of the system.")
(defrule p-plan/end -> :instruction "最後に何を扱うかを 1 文で書く" :sample "The chapter concludes with a brief discussion on security considerations and a review of the important design concepts seen in this chapter.")
(defrule s-concept -> :instruction "このシステムが属する種類のシステムを説明する" :include "design.resource-brokering-overview.lisp" :heading "### The kind of system")
(defrule s-system -> :instruction "このシステムを、種類の役割に当てて説明する" :include "design.filebuy-system-overview.lisp" :heading "### The system")
(defrule s-cases -> :instruction "利用場面を挙げ、場面ごとにやりとりと決定を説明する" :include "design.use-cases.lisp" :heading "### Use cases")
(defrule s-deploy -> :instruction "構成要素をどの機械に置くかを配置図で説明する" :include "design.deployment-architecture.lisp" :heading "### Deployment")
(defrule s-security -> :instruction "安全上の決定を、守るものと性能の釣り合いから説明する" :include "design.security-considerations.lisp" :heading "### Security")
(defrule s-lessons -> :instruction "この設計から読み手が持ち帰る設計の原則を説明する" :include "design.summing-up.lisp" :heading "### Summing up")
