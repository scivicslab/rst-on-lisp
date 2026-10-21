;;; one piece of code: what it does, why it is done this way and how it was done before, what happens when an input
;;; fails a check it makes, the code with its file, its marked lines one by one, where it is undone or used later, and
;;; what could be better
;;; from: ipv4.code-step.lisp (step), implementation.code-snippet.lisp (snippet); the same meaning: a piece of code with
;;;       what it does; a step adds the failure of a check, a snippet adds the earlier way, the file, the marked lines,
;;;       the undoing, and the better way
(defrule piece -> :nucleus piece/n :reason piece/because :comparison piece/before :result piece/fail :example piece/code
                  :elaboration-additional piece/where :elaboration-process-step piece/marks
                  :elaboration-additional piece/after :elaboration-additional piece/better)
(defrule piece/n -> :instruction "このコードの部分が何をするかを 1 文で書く。名前を付けて書くか、命令の形か「〜する」の形で書いてコロンで終える"
  :sample "Registration in the Index Service: To register the resource in the local index, we will use the Globus-supplied ServiceGroupRegistrationClient class. / Fetch the ip_options object from the inet_skb_parm object which is associated to the SKB:")
(defrule piece/because -> :instruction "そうする理由が自明でなければ、何を仮定しないためか、データの単位や前の段階の結果を根拠に 1〜2 文で書く。自明なら書かない"
  :sample "In general, our VO might have a central index service separate from any of the brokering services, so we should not assume that the broker components and the broker's index are deployed on the same host. / The frag_off field of the IPv4 header is measured in multiples of 8 bytes, so divide the offset by 8:")
(defrule piece/before -> :instruction "読み手が前に見た例でどう書いていたかと、何がよくなったかを 1〜2 文で書く。前の例に無いなら書かない"
  :sample "In previous examples, the instance service's path was included as a parameter in the resource home. In the FileBuy application we are using a much cleaner approach: we are putting all configuration information in a separate object which can be retrieved using JNDI.")
(defrule piece/fail -> :instruction "この部分が入力の検査なら、検査に落ちたとき、入力、送り元への知らせ、統計、返す値がそれぞれどうなるかを 1 文で書く。検査でなければ書かない"
  :sample "and if not, a \"Destination Unreachable\" ICMPv4 message with code of fragmentation needed is sent back to the sender, the statistics (IPSTATS_MIB_FRAGFAILS) are updated, the packet is dropped, and an error code of -EMSGSIZE is returned:")
(defrule piece/code -> :instruction "コードか設定の部分を、前後を「. . .」で省いて示す。行ごとに説明するなら、その行に番号の注記を付ける" :kind code-block)
(defrule piece/where -> :instruction "その部分がどのファイルにあるかを 1 文で書く。操作の説明で示したなら書かない" :sample "This is part of $EXAMPLES_DIR/org/globus/examples/services/filebuy/seller/impl/FileResourceHome.java")
(defrule piece/marks -> :instruction "注記を付けた行を、番号の順に 1 項目に 1 つ、その行で何をし、なぜそうするかを書く。注記が無ければ空にする"
  :sample "We are overriding the add method provided by the parent class. However, we have to invoke the parent's add method to make sure that the resource is correctly added. / Finally, we register the resource. Notice how the registration returns a Timer object which is then assigned to the resource's regTimer attribute."
  :kind number)
(defrule piece/after -> :instruction "このコードがしたことを後で取り消すとき、または続けて使うときに、どこで何をするかを 1 文で書く。無ければ書かない"
  :sample "Finally, we also have to make sure that a resource's registration is cancelled if it is destroyed. We do this using the RemoveCallback interface's remove method in the resource.")
(defrule piece/better -> :instruction "このコードをもっとよく書くならどうするか、そうしない代償は何かを 1 文で書く。無ければ書かない"
  :sample "Instead of hardcoding that we want to access the second element contained in the data, we could search through the aggregated resource properties and find the element called Price. This, however, would require additional code.")
