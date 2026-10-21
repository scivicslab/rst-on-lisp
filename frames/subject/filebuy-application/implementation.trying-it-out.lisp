;;; trying one usage scenario out: what the test shows, the settings to change first, building and deploying, compiling the client,
;;; what must be running, each run with what to see, and what the result is used for next
;;; members: 24.2.3 (p-try1-*), 24.3 Trying it Out (p-try2-*), 24.4.7 (p-try3-*)
;;; children: each settings change is one copy of implementation.config-change.lisp; each run is one copy of implementation.run-and-observe.lisp
(defrule trying -> trying/plan trying/changes trying/build trying/build/code trying/compile trying/compile/code trying/running trying/runs trying/next)
(defrule trying/plan -> :nucleus trying/plan/n :elaboration-additional trying/plan/fail :elaboration-process-step trying/plan/input)
(defrule trying/plan/n -> :instruction "この試しで何を確かめるかを 1 文で書く" :sample "We will now run through this scenario to try and find the file advertised in the previous scenario.")
(defrule trying/plan/fail -> :instruction "うまくいかないはずの場合も試すなら、それを 1 文で書く。試さなければ書かない"
  :sample "We will also see what happens when we ask for the file but specify that we are not willing to pay the 25 monetary units at which the file is offered.")
(defrule trying/plan/input -> :instruction "試す前に読み手が用意する入力（ファイルなど）を 1 文で書く。無ければ書かない"
  :sample "Create a file named example.txt in the seller machine's /tmp directory, and write any random text in that file.")
(defrule trying/changes -> :instruction "組み立てる前に書き換える設定を、1 行に 1 つ挙げる。無ければ空にする" :frame "implementation.config-change.lisp")
(defrule trying/build -> :nucleus trying/build/n)
(defrule trying/build/n -> :instruction "どの構成要素を組み立てて配置するかを 1 文で導入する"
  :sample "Now, we will need to build and deploy the seller components, the buyer components, and the file transfer service:")
(defrule trying/build/code -> :instruction "組み立てと配置のコマンドを、実行する順に示す" :kind code-block)
(defrule trying/compile -> :nucleus trying/compile/n)
(defrule trying/compile/n -> :instruction "場面を始めるクライアントを変換すると 1 文で導入する" :sample "Compile the AddFile client:")
(defrule trying/compile/code -> :instruction "変換のコマンドを示す" :kind code-block)
(defrule trying/running -> :nucleus trying/running/n :concession trying/running/even)
(defrule trying/running/n -> :instruction "クライアントを動かす前に、どの機械のどの入れ物が動いていなければならないかを 1 文で書く"
  :sample "Before you run the client, you have to make sure that the broker's container is running.")
(defrule trying/running/even -> :instruction "この場面では使わないように見えるのに動いていなければならないものがあれば、その理由を 1 文で書く"
  :sample "Even though we have not deployed any broker components, we still need the broker's index service up and running.")
(defrule trying/runs -> :instruction "クライアントを動かす回を、1 行に 1 つ、何を確かめる回かで挙げる（うまくいく回、うまくいかないはずの回）"
  :frame "implementation.run-and-observe.lisp")
(defrule trying/next -> :nucleus trying/next/n)
(defrule trying/next/n -> :instruction "この試しで得たもの（ファイル、資源の参照）を後の場面でどう使うか、どこに残るかを 1〜2 文で書く"
  :sample "In the next scenario, we will use the EPR written to disk to refer to the FileOrder WS-Resource for which we want to initiate a purchase.")
