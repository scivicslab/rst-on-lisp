;;; subject: globus-toolkit-4 24.1 Setting Up
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap24/globus_toolkit_p411-420 / s241
;;; members: p-setup-what p-setup-machines p-setup-install p-setup-register p-setup-interval
;;; children: 24.1.1 implementation.single-machine.lisp (:include); each configuration change is one copy of implementation.config-change.lisp
;;; left-out: none
(defrule setting-up -> p-setup-what p-setup-machines p-setup-install p-setup-install/code changes single-machine)
;; what is set up and why, and the machines assumed (p-setup-what p-setup-machines)
(defrule p-setup-what -> :nucleus p-setup-what/n :elaboration-additional p-setup-what/machines :concession p-setup-what/assumed)
(defrule p-setup-what/n -> :instruction "利用場面を動かす前に何を用意するか、それが主に何に関わるかを 1 文で書く"
  :sample "Before we start walking through each of the three scenarios, we have to perform some basic setup, mostly related to the GT4 Index Service.")
(defrule p-setup-what/machines -> :instruction "本来は何台の機械に、どの役割ごとに分けて置くかを 1 文で書く"
  :sample "FileBuy should ideally be deployed in at least three machines (one broker, at least one seller, and at least one buyer).")
(defrule p-setup-what/assumed -> :instruction "以下の手順がどの台数を前提に書かれているかを 1 文で書き、機械の名前を挙げると言う"
  :sample "The deployment instructions are given assuming three machines, each with a full GT4 install:")
(defrule p-setup-machines -> :instruction "役割ごとの機械の名前を 1 項目に 1 つ挙げる" :sample "pc-broker.gt4book.com / pc-seller.gt4book.com / pc-buyer.gt4book.com" :kind bullet)
;; what must be installed, and why less is not enough (p-setup-install)
(defrule p-setup-install -> :concession p-setup-install/full :nucleus p-setup-install/n :elaboration-additional p-setup-install/how)
(defrule p-setup-install/full -> :instruction "全部を入れる必要は無いことを 1 文で書く" :sample "A full GT4 install is not strictly required.")
(defrule p-setup-install/n -> :instruction "最小の入れ方では足りないこと、何が欠けるからかを 1 文で書く"
  :sample "However, a core-only install will not be enough as it does not include the GT4 Index Service necessary to run FileBuy.")
(defrule p-setup-install/how -> :instruction "何を指定して入れればよいかを 1 文で導入する" :sample "When running the GT4 installer, you must specify the target wsmds:")
(defrule p-setup-install/code -> :instruction "入れるコマンドを示す" :kind code-block)
;; the configuration changes, one by one (p-setup-register p-setup-interval)
(defrule changes -> :instruction "用意のために書き換える設定を、1 行に 1 つ、書き換える順に挙げる" :frame "implementation.config-change.lisp")
;; 24.1.1
(defrule single-machine -> :instruction "機械が 1 台しか無いときの置き方を説明する" :include "implementation.single-machine.lisp" :heading "#### Running on a single machine")
