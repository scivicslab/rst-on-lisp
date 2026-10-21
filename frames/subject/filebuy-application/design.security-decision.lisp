;;; one security decision: the question, what this system needs and does not need, the options when there is more than one, the choice
;;; members: p-authn-q p-authn-choice p-authn-method (authentication), p-integrity (privacy and integrity), p-authz-q p-authz-options p-authz-list p-authz-choice (authorization), p-audit p-audit-events (auditing)
(defrule security-decision -> :background security-decision/q :reason security-decision/needs :elaboration-set-member security-decision/options :nucleus security-decision/n)
(defrule security-decision/q -> :instruction "決めなければならない問いを 1 文で書く"
  :sample "We will have to decide whether we want communications to use digital signatures (guaranteeing integrity but not privacy) or encryption (guaranteeing integrity and privacy).")
(defrule security-decision/needs -> :instruction "このシステムが守る必要のあるものと、守らなくてよいものを、このシステムの事情から 1〜2 文で書く"
  :sample "In our case, we assume that the content of the files is not critical. On the other hand, we are interested in making sure that no one tampers with a communication.")
(defrule security-decision/options -> :instruction "取れる案が複数あれば、案ごとにその代償とともに挙げる。案が 1 つなら書かない"
  :sample "We can use GSI Secure Conversation along with GSI Transport; however, this would adversely affect performance. / We can use the delegation service to delegate our credentials. / We can dynamically create a gridmap with a single entry for the resource creator.")
(defrule security-decision/n -> :instruction "選んだ案を、選んだ理由とともに 1 文で書く" :sample "So, we decide to use GSI Transport with digital signatures and no encryption.")
