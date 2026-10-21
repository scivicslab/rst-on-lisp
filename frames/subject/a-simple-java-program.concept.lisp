;;; one concept a program uses: where it is in the code, what it is, the rule the reader must keep
;;; members: p-method p-println p-class p-body p-call p-string p-args (where + what: all; the rule: p-method p-class p-body p-args; p-case gives the rule and what breaks)
(defrule concept -> :nucleus concept/n :definition concept/def :elaboration-additional concept/rule)
(defrule concept/n -> :instruction "その概念がコードのどこにどう書かれているかを、読み手が見つけられるように 1 文で書く"
  :sample "The program declares a method called main.")
(defrule concept/def -> :instruction "その概念が何であるかを 1 文で定義する"
  :sample "The term \"method\" is Java-speak for a function—a block of code that carries out a specific task.")
(defrule concept/rule -> :instruction "その概念について読み手が守らなければならない規則を 1 文で書く。守らないと何が起きるかが分かるなら添える"
  :sample "You must have a main method in every program.")
