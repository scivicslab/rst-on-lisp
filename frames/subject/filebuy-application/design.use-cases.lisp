;;; subject: globus-toolkit-4 23.3 Use Cases (23.3.1-23.3.3 are each one copy of design.use-case.lisp)
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap23/globus_toolkit_p391-400 / s233; 401-410 / s2331 s2332 s2333
;;; members: p-cases p-cases-plan, and in each scenario its sequence and steps, each design detail, each general concept
;;; left-out: none
;;; included by: design.lisp (s-cases); the use cases, one by one
;; the use cases, one by one (23.3)
(defrule use-cases-of-system -> p-cases p-cases-plan use-cases)
(defrule p-cases -> :nucleus p-cases/n :example p-cases/fig)
(defrule p-cases/n -> :instruction "設計をたどるために取り上げる利用場面を、番号を付けて 1 文で挙げ、ユースケース図を指す"
  :sample "We consider three key use cases of the system: (1) advertising a file, (2) finding a file and (3) purchasing a file (Figure 23.6).")
(defrule p-cases/fig -> :instruction "ユースケース図を示す" :kind image)
(defrule p-cases-plan -> :nucleus p-cases-plan/n :elaboration-process-step p-cases-plan/decisions :elaboration-process-step p-cases-plan/concepts)
(defrule p-cases-plan/n -> :instruction "各利用場面をまず構成要素のやりとりの順にたどることを 1 文で書く" :sample "We begin by walking through the sequence of component interactions for each use case.")
(defrule p-cases-plan/decisions -> :instruction "次に設計上の決定を説明することを 1 文で書く" :sample "A brief explanation of key design decisions follows.")
(defrule p-cases-plan/concepts -> :instruction "最後にその場面から言える一般的な考え方を挙げることを 1 文で書く" :sample "Then each use case study concludes with highlights of important general concepts.")
(defrule use-cases -> :instruction "取り上げる利用場面を、1 行に 1 つ、上で挙げた順に、場面の名前で挙げる" :frame "design.use-case.lisp")
