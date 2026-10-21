;;; one design decision: the question, what in this program calls for an answer (what it needs and does not need), the
;;; options when there is more than one, the choice, what it costs or what was not chosen, and where the mechanism is explained
;;; from: design.decision.lisp, design.security-decision.lisp (the same meaning: a decision; the security one adds the
;;;       question and the options)
(defrule decision -> :background decision/q :reason decision/because :elaboration-set-member decision/options :nucleus decision/n
                     :comparison decision/cost :elaboration-additional decision/see)
(defrule decision/q -> :instruction "決めなければならない問いを 1 文で書く。決めた事柄の名前で足りるなら書かない"
  :sample "We will have to decide whether we want communications to use digital signatures (guaranteeing integrity but not privacy) or encryption (guaranteeing integrity and privacy).")
(defrule decision/because -> :instruction "このプログラムのどんな事情がその選択を求めるか（守る必要のあるもの、無いもの）を 1〜2 文で書く"
  :sample "In our application, a seller can advertise multiple files, which means the system must support multiple File resources. / In our case, we assume that the content of the files is not critical. On the other hand, we are interested in making sure that no one tampers with a communication.")
(defrule decision/options -> :instruction "取れる案が複数あれば、案ごとにその代償とともに挙げる。案が 1 つなら書かない"
  :sample "We can use GSI Secure Conversation along with GSI Transport; however, this would adversely affect performance. / We can use the delegation service to delegate our credentials.")
(defrule decision/n -> :instruction "決めた事柄の名前に続けて、何を選んだかを 1 文で書く"
  :sample "Resource persistence: Our File resources are persisted so they will survive container restarts. / So, we decide to use GSI Transport with digital signatures and no encryption.")
(defrule decision/cost -> :instruction "その選択の代償、または選ばなかった案とその理由を 1 文で書く。同じ事柄について別の流れで別の選択をしていれば、それと比べる。案を上で比べたなら書かない"
  :sample "In our simple system recovery from the loss of a File Order is relatively painless, as the buyers need only execute a single search to recreate it. The effort to recover File resources, however, can be non-trivial.")
(defrule decision/see -> :instruction "その仕組みを詳しく説明している章や文書があれば 1 文で指す。無ければ書かない" :sample "See Chapter 12 for additional information on persisting resources.")
