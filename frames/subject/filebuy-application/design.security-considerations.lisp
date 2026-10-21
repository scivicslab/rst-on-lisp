;;; subject: globus-toolkit-4 23.5 Security Considerations (23.5.1-23.5.3 and Auditing are each one copy of design.security-decision.lisp)
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap23/globus_toolkit_p401-410 / s235
;;; members: p-sec-matters p-sec-tradeoff p-sec-plan, and each security decision
;;; left-out: p-authz-more (decisions a real system would add)
;;; included by: design.lisp (s-security); the security decisions
;; the security decisions (23.5)
(defrule security -> p-sec-matters p-sec-tradeoff security-decisions)
(defrule p-sec-matters -> :nucleus p-sec-matters/n :reason p-sec-matters/because)
(defrule p-sec-matters/n -> :instruction "この種類のシステムで安全性がなぜ大事かを、参加者の性質から 1〜2 文で書く"
  :sample "Security is a primary concern in the context of Grid computing, as Grid-based collaborations involve people from multiple administrative domains sharing important resources.")
(defrule p-sec-matters/because -> :instruction "参加者が協力していても守る必要がある理由を 1 文で書く"
  :sample "While participants in a VO agree in principle to work together, that openness increases the importance of protecting the system from naive or intentional misuse.")
(defrule p-sec-tradeoff -> :background p-sec-tradeoff/q :nucleus p-sec-tradeoff/n :elaboration-additional p-sec-tradeoff/challenge)
(defrule p-sec-tradeoff/q -> :instruction "すべての安全機構を使えばよいのでは、という問いを 1 文で立てる" :sample "So why not lock everything down with a full complement of security mechanisms?")
(defrule p-sec-tradeoff/n -> :instruction "そうしない理由（安全機構が何を犠牲にするか）を 1 文で答える" :sample "The answer is simple: runtime security adversely affects performance.")
(defrule p-sec-tradeoff/challenge -> :instruction "だから設計者が何と何を釣り合わせ、何で決めるかを 1〜2 文で書く"
  :sample "The challenge for the system designer is to minimize the potential for exploits while at the same time optimizing for performance. In practice the correct design decisions are highly dependent on the requirements imposed by the problem domain and the policies of the participants.")
(defrule security-decisions -> :instruction "このシステムで下した安全上の決定を、1 行に 1 つ、決める事柄の名前（認証、通信の秘匿と完全性、認可、監査など）で挙げる"
  :frame "design.security-decision.lisp" :heading "#### Security decisions")
