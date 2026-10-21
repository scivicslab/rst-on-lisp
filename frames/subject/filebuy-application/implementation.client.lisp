;;; one client application: what it invokes, that it holds nothing new, and where it is
;;; members: p-addfile p-addfile-where (24.2.2), p-findfile p-findfile-where (24.3.2)
(defrule client -> :nucleus client/n :evaluation-s client/plain :elaboration-additional client/where)
(defrule client/n -> :instruction "このクライアントが、どのサービスのどの操作を呼ぶかを 1 文で書く" :sample "The AddFile client is the one responsible for invoking the addFile operation in the FilesForSale service.")
(defrule client/plain -> :instruction "このクライアントに新しく説明の要るコードがあるかを 1 文で書く" :sample "The client has no noteworthy code, and is similar to clients seen in previous chapters.")
(defrule client/where -> :instruction "このクライアントのコードがどのファイルにあるかを 1 文で書く" :sample "The AddFile client can be found in $EXAMPLES_DIR/org/globus/examples/clients/filebuy/FilesForSale/AddFileClient.java")
