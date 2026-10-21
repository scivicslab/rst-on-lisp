;;; one component of the kind of system: what it is, what it does, and why it is needed
;;; members: p-broker-index p-broker-gateway (and the index and broker roles in p-broker-what)
(defrule component -> :background component/before :nucleus component/n :elaboration-additional component/does)
(defrule component/before -> :instruction "前の構成要素だけでは足りない点があれば 1 文で書く。無ければ書かない" :sample "An index service alone usually isn't enough to perform efficient resource brokering.")
(defrule component/n -> :instruction "この構成要素を名前とともに導入し、何を受け持つかを 1 文で書く"
  :sample "Often there is a gateway service in front of the index, called the broker, which is responsible for interpreting requests and enforcing VO policies on resource access.")
(defrule component/does -> :instruction "それがあることで利用者から何が見えなくなるか、何が楽になるかを 1 文で書く" :sample "Brokers can hide the many details involved in locating suitable resources.")
