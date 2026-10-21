;;; one run of a client or command: what it takes, the values of this run and what it checks, the command, what it prints, and what the logs show
;;; from: implementation.run-and-observe.lisp
(defrule observed -> :nucleus observed/n :example observed/ex :example observed/code :result observed/out :example observed/out/code
               :elaboration-additional observed/log :example observed/log/code)
(defrule observed/n -> :instruction "クライアントが何を引数に取るかを 1 文で書く" :sample "The client expects three parameters: the file's name, the location of the file, and the price at which you will be offering it.")
(defrule observed/ex -> :instruction "この回に渡す値と、それで何を確かめるかを 1 文で書く"
  :sample "Let's ask for the example.txt file advertised in the previous scenario, and let's say that we're willing to pay 100 monetary units (more than the 25 units at which it is offered):")
(defrule observed/code -> :instruction "動かすコマンドを、渡す値を入れて示す" :kind code-block)
(defrule observed/out -> :instruction "うまくいけばクライアントが何を表示するかを 1 文で導入する。結果がファイルに残るなら、その場所も書く" :sample "If all goes well, you should see the following:")
(defrule observed/out/code -> :instruction "クライアントの表示を示す" :kind code-block)
(defrule observed/log -> :instruction "どの機械の入れ物のログに何が出るかを 1 文で導入する。ログを見なくてよい回なら書かない" :sample "If you check the container's log, you should see the following:")
(defrule observed/log/code -> :instruction "ログに出る行を示す" :kind code-block)
