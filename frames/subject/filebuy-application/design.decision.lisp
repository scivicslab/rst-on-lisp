;;; one design decision: what was decided, what in this system calls for it, what it costs or what was not chosen, where the mechanism is explained
;;; members: p-add-factory p-add-persist p-add-index p-add-lease p-find-factory p-find-persist p-find-compose p-buy-client p-buy-transfer p-buy-destroy
(defrule decision -> :nucleus decision/n :reason decision/because :comparison decision/cost :background decision/see)
(defrule decision/n -> :instruction "決めた事柄の名前に続けて、何を選んだかを 1 文で書く" :sample "Resource persistence: Our File resources are persisted so they will survive container restarts.")
(defrule decision/because -> :instruction "このシステムのどんな事情がその選択を求めるかを 1〜2 文で書く"
  :sample "In our application, a seller can advertise multiple files, which means the system must support multiple File resources.")
(defrule decision/cost -> :instruction "その選択の代償、または選ばなかった案とその理由を 1 文で書く。同じ事柄について別の場面で別の選択をしていれば、それと比べる"
  :sample "In our simple system recovery from the loss of a File Order is relatively painless, as the buyers need only execute a single search to recreate it. The effort to recover File resources, however, can be non-trivial.")
(defrule decision/see -> :instruction "その仕組みを詳しく説明している章があれば 1 文で指す。無ければ書かない" :sample "See Chapter 12 for additional information on persisting resources.")
