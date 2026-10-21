;;; what to prepare before any flow of a program can be tried: what and why, the machines assumed, what to install and why
;;; less is not enough, the configuration changes, and how to run it all on a single machine
;;; from: implementation.setting-up.lisp, implementation.single-machine.lisp
(defrule setting-up -> p-setup-what p-setup-machines p-setup-install p-setup-install/code changes single-machine)
(defrule p-setup-what -> :nucleus p-setup-what/n :elaboration-additional p-setup-what/machines :concession p-setup-what/assumed)
(defrule p-setup-what/n -> :instruction "流れを動かす前に何を用意するか、それが主に何に関わるかを 1 文で書く"
  :sample "Before we start walking through each of the three scenarios, we have to perform some basic setup, mostly related to the GT4 Index Service.")
(defrule p-setup-what/machines -> :instruction "本来は何台の機械に、どの役割ごとに分けて置くかを 1 文で書く。1 台で動くものなら書かない"
  :sample "FileBuy should ideally be deployed in at least three machines (one broker, at least one seller, and at least one buyer).")
(defrule p-setup-what/assumed -> :instruction "以下の手順がどの台数を前提に書かれているかを 1 文で書き、機械の名前を挙げると言う。1 台で動くものなら書かない"
  :sample "The deployment instructions are given assuming three machines, each with a full GT4 install:")
(defrule p-setup-machines -> :instruction "役割ごとの機械の名前を 1 項目に 1 つ挙げる。1 台で動くものなら空にする" :sample "pc-broker.gt4book.com / pc-seller.gt4book.com / pc-buyer.gt4book.com" :kind bullet)
(defrule p-setup-install -> :concession p-setup-install/full :nucleus p-setup-install/n :elaboration-additional p-setup-install/how)
(defrule p-setup-install/full -> :instruction "土台を全部入れる必要は無いことを 1 文で書く。全部要るなら書かない" :sample "A full GT4 install is not strictly required.")
(defrule p-setup-install/n -> :instruction "何を入れなければならないか、最小の入れ方では何が欠けるから足りないかを 1 文で書く"
  :sample "However, a core-only install will not be enough as it does not include the GT4 Index Service necessary to run FileBuy.")
(defrule p-setup-install/how -> :instruction "何を指定して入れればよいかを 1 文で導入する" :sample "When running the GT4 installer, you must specify the target wsmds:")
(defrule p-setup-install/code -> :instruction "入れるコマンドを示す" :kind code-block)
(defrule changes -> :instruction "用意のために書き換える設定を、1 行に 1 つ、書き換える順に挙げる。無ければ空にする" :frame "explain-program.config-change.lisp")
(defrule single-machine -> p-single-can p-single-copy p-single-ports p-single-ports/code p-single-shells :heading "#### Running on a single machine")
(defrule p-single-can -> :nucleus p-single-can/n :concession p-single-can/still :reason p-single-can/because)
(defrule p-single-can/n -> :instruction "機械を何台も用意できない読み手のために、1 台でも動かせることを 1 文で書く。もともと 1 台で動くものなら節ごと書かない" :sample "You can also run the application on a single machine.")
(defrule p-single-can/still -> :instruction "それでも複数要るもの（プロセス、入れ物など）を 1 文で書く" :sample "However, you will still need to be running two containers simultaneously.")
(defrule p-single-can/because -> :instruction "それが複数要る理由を、設計のどの構成要素が分かれていなければならないかで 1 文で書く"
  :sample "The reason for this is that we will need two distinct Index Services, one for the broker and one for the seller.")
(defrule p-single-copy -> :nucleus p-single-copy/n :elaboration-additional p-single-copy/quick :concession p-single-copy/crude)
(defrule p-single-copy/n -> :instruction "そのために何が 2 つ要るかを 1 文で書く" :sample "This means that you will need to have two installations of the Globus Toolkit 4 present in your system.")
(defrule p-single-copy/quick -> :instruction "2 つ目を手早く用意する方法を 1 文で書く" :sample "One quick way of getting a second GT4 installation is to simply make a complete copy of your current $GLOBUS_LOCATION to a new directory.")
(defrule p-single-copy/crude -> :instruction "その手早い方法は試すためだけのもので、本来はどうするかを 1 文で書く"
  :sample "Making a complete copy is a very crude way; if you ever do need to perform additional installations of the toolkit, follow the normal installation procedures.")
(defrule p-single-ports -> :example p-single-ports/ex :nucleus p-single-ports/n :recommendation p-single-ports/suggest :elaboration-process-step p-single-ports/how)
(defrule p-single-ports/ex -> :instruction "2 つのうちどちらに何を受け持たせるかを、具体的なディレクトリの名前で 1〜2 文で書く"
  :sample "Suppose that GT4 is installed in /usr/local/gt4, and that you make a copy in /usr/local/gt4-clone. You can use the cloned installation to host the broker's index, and your original installation to deploy all the services.")
(defrule p-single-ports/n -> :instruction "2 つが同時に動くために分けなければならないものを 1 文で書く" :sample "You must run each container on a different port.")
(defrule p-single-ports/suggest -> :instruction "どちらにどの番号を使うかを 1 文で勧める" :sample "We suggest that you have the broker's index listen on the default port (8443) and the original container listen on port 8444.")
(defrule p-single-ports/how -> :instruction "それを指定して起動する方法を 1 文で導入する" :sample "You can do this by running globus-start-container with the -p option, like so:")
(defrule p-single-ports/code -> :instruction "起動のコマンドを示す" :kind code-block)
(defrule p-single-shells -> :nucleus p-single-shells/n :recommendation p-single-shells/only :pitfall p-single-shells/mistake)
(defrule p-single-shells/n -> :instruction "2 つを扱うときに分けておくもの（シェル、環境変数など）を 1〜2 文で書く"
  :sample "You must have a separate shell for each of the two containers. In each shell, make sure that the environment variable GLOBUS_LOCATION is set to the appropriate location.")
(defrule p-single-shells/only -> :instruction "2 つ目に受け持たせるのは最小限にするよう 1 文で勧める" :sample "We recommend you use the cloned installation to run only the broker's index, but not the broker itself.")
(defrule p-single-shells/mistake -> :instruction "勧めに従わなかったときに、どの操作で何を取り違えやすいかを 1 文で書く"
  :sample "Although you can certainly deploy the broker to that container, you will have to make sure that GLOBUS_LOCATION is pointing to the cloned installation directory whenever you run globus-deploy-gar.")
