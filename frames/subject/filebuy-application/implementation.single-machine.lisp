;;; subject: globus-toolkit-4 24.1.1 Running FileBuy on a Single Machine
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap24/globus_toolkit_p411-420 / s2411
;;; members: p-single-can p-single-copy p-single-caution p-single-ports p-single-shells
;;; left-out: none
(defrule single-machine -> p-single-can p-single-copy p-single-ports p-single-ports/code p-single-shells)
;; the alternative, what it still needs, and why (p-single-can)
(defrule p-single-can -> :nucleus p-single-can/n :concession p-single-can/still :reason p-single-can/because)
(defrule p-single-can/n -> :instruction "機械を何台も用意できない読み手のために、1 台でも動かせることを 1 文で書く" :sample "You can also run the application on a single machine.")
(defrule p-single-can/still -> :instruction "それでも複数要るもの（プロセス、入れ物など）を 1 文で書く" :sample "However, you will still need to be running two containers simultaneously.")
(defrule p-single-can/because -> :instruction "それが複数要る理由を、設計のどの構成要素が分かれていなければならないかで 1 文で書く"
  :sample "The reason for this is that we will need two distinct Index Services, one for the broker and one for the seller.")
;; how to get the second one, and its limits (p-single-copy p-single-caution)
(defrule p-single-copy -> :nucleus p-single-copy/n :elaboration-additional p-single-copy/quick :concession p-single-copy/crude)
(defrule p-single-copy/n -> :instruction "そのために何が 2 つ要るかを 1 文で書く" :sample "This means that you will need to have two installations of the Globus Toolkit 4 present in your system.")
(defrule p-single-copy/quick -> :instruction "2 つ目を手早く用意する方法を 1 文で書く" :sample "One quick way of getting a second GT4 installation is to simply make a complete copy of your current $GLOBUS_LOCATION to a new directory.")
(defrule p-single-copy/crude -> :instruction "その手早い方法は試すためだけのもので、本来はどうするかを 1 文で書く"
  :sample "Making a complete copy is a very crude way; if you ever do need to perform additional installations of the toolkit, follow the normal installation procedures.")
;; which one runs what, on which port, and the command (p-single-ports)
(defrule p-single-ports -> :example p-single-ports/ex :nucleus p-single-ports/n :recommendation p-single-ports/suggest :elaboration-process-step p-single-ports/how)
(defrule p-single-ports/ex -> :instruction "2 つのうちどちらに何を受け持たせるかを、具体的なディレクトリの名前で 1〜2 文で書く"
  :sample "Suppose that GT4 is installed in /usr/local/gt4, and that you make a copy in /usr/local/gt4-clone. You can use the cloned installation to host the broker's index, and your original installation to deploy all the services.")
(defrule p-single-ports/n -> :instruction "2 つが同時に動くために分けなければならないものを 1 文で書く" :sample "You must run each container on a different port.")
(defrule p-single-ports/suggest -> :instruction "どちらにどの番号を使うかを 1 文で勧める" :sample "We suggest that you have the broker's index listen on the default port (8443) and the original container listen on port 8444.")
(defrule p-single-ports/how -> :instruction "それを指定して起動する方法を 1 文で導入する" :sample "You can do this by running globus-start-container with the -p option, like so:")
(defrule p-single-ports/code -> :instruction "起動のコマンドを示す" :kind code-block)
;; what to keep apart while working, and the mistake it prevents (p-single-shells)
(defrule p-single-shells -> :nucleus p-single-shells/n :recommendation p-single-shells/only :pitfall p-single-shells/mistake)
(defrule p-single-shells/n -> :instruction "2 つを扱うときに分けておくもの（シェル、環境変数など）を 1〜2 文で書く"
  :sample "You must have a separate shell for each of the two containers. In each shell, make sure that the environment variable GLOBUS_LOCATION is set to the appropriate location.")
(defrule p-single-shells/only -> :instruction "2 つ目に受け持たせるのは最小限にするよう 1 文で勧める" :sample "We recommend you use the cloned installation to run only the broker's index, but not the broker itself.")
(defrule p-single-shells/mistake -> :instruction "勧めに従わなかったときに、どの操作で何を取り違えやすいかを 1 文で書く"
  :sample "Although you can certainly deploy the broker to that container, you will have to make sure that GLOBUS_LOCATION is pointing to the cloned installation directory whenever you run globus-deploy-gar.")
