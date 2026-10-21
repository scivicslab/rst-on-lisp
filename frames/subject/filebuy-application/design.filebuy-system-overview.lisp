;;; subject: globus-toolkit-4 23.2 FileBuy System Overview
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap23/globus_toolkit_p391-400 / s232
;;; members: p-filebuy-what p-filebuy-vo
;;; left-out: none
;;; included by: design.lisp (s-system); the designed system, mapped onto the kind
;; this system, mapped onto the kind (23.2)
(defrule the-system -> p-system-what p-system-scale)
(defrule p-system-what -> :nucleus p-system-what/n :elaboration-object-attribute p-system-what/roles :elaboration-additional p-system-what/resources)
(defrule p-system-what/n -> :instruction "このシステムが誰と誰の間で何をするシステムかを 1 文で書く" :sample "FileBuy is a resource brokering system that enables buyers to purchase files from sellers linked by a wide-area network.")
(defrule p-system-what/roles -> :instruction "このシステムの参加者が、さきの種類のシステムのどの役割に当たるかを 1〜2 文で書く"
  :sample "In our system the sellers represent resource producers and the buyers represent resource consumers. Interactions between the two are mediated by the FileBuyBroker.")
(defrule p-system-what/resources -> :instruction "このシステムで扱う対象が何かを 1 文で書く" :sample "The \"resources\" in a FileBuy VO are not CPUs nor storage capacity, but data files.")
(defrule p-system-scale -> :nucleus p-system-scale/n :example p-system-scale/fig)
(defrule p-system-scale/n -> :instruction "1 つのシステムに各参加者がどれだけいるかを 1 文で書き、図を指す" :sample "A FileBuy VO is made up of one broker and (potentially) hundreds of buyers, sellers, and files.")
(defrule p-system-scale/fig -> :instruction "参加者の配置を描いた図を示す" :kind image)
