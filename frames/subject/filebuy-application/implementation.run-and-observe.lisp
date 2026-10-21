;;; one run of a client: what it takes, the command, what the client prints, and what the logs show
;;; members: p-try1-run p-try1-out p-try1-log, p-try2-run p-try2-out p-try2-log, p-try2-cheap p-try2-cheap-out, p-try3-run p-try3-out p-try3-file p-try3-log1 p-try3-log2
(defrule run -> :nucleus run/n :example run/ex :example run/code :result run/out :example run/out/code
               :elaboration-additional run/log :example run/log/code)
(defrule run/n -> :instruction "クライアントが何を引数に取るかを 1 文で書く" :sample "The client expects three parameters: the file's name, the location of the file, and the price at which you will be offering it.")
(defrule run/ex -> :instruction "この回に渡す値と、それで何を確かめるかを 1 文で書く"
  :sample "Let's ask for the example.txt file advertised in the previous scenario, and let's say that we're willing to pay 100 monetary units (more than the 25 units at which it is offered):")
(defrule run/code -> :instruction "動かすコマンドを、渡す値を入れて示す" :kind code-block)
(defrule run/out -> :instruction "うまくいけばクライアントが何を表示するかを 1 文で導入する。結果がファイルに残るなら、その場所も書く" :sample "If all goes well, you should see the following:")
(defrule run/out/code -> :instruction "クライアントの表示を示す" :kind code-block)
(defrule run/log -> :instruction "どの機械の入れ物のログに何が出るかを 1 文で導入する。ログを見なくてよい回なら書かない" :sample "If you check the container's log, you should see the following:")
(defrule run/log/code -> :instruction "ログに出る行を示す" :kind code-block)
