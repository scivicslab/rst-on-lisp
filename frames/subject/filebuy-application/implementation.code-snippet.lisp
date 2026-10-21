;;; one interesting code snippet: what it does, why it is done this way (against the earlier way), the code and its file,
;;; the marked lines one by one, and what could be better
;;; members: p-path p-path-old p-path-new p-path-class p-path-use p-path-more (instance service path), p-reg p-reg-timer p-reg-file p-reg-add p-add-marks p-remove (index registration),
;;;          p-idx-uri p-idx-class (index URI), p-query (querying the index), p-results p-results-data p-price p-price-better (processing results), p-create (creating the resource),
;;;          p-xfer-read (reading the file), p-recv-binary p-recv-java (receiving binary data)
(defrule snippet -> :nucleus snippet/n :reason snippet/because :comparison snippet/before :example snippet/code
                    :elaboration-additional snippet/where :elaboration-process-step snippet/marks
                    :elaboration-additional snippet/after :elaboration-additional snippet/better)
(defrule snippet/n -> :instruction "このコードの部分が何をするかを、名前を付けて 1 文で書く"
  :sample "Registration in the Index Service: To register the resource in the local index, we will use the Globus-supplied ServiceGroupRegistrationClient class.")
(defrule snippet/because -> :instruction "なぜこの書き方をするのか、何を仮定しないためかを 1〜2 文で書く"
  :sample "In general, our VO might have a central index service separate from any of the brokering services, so we should not assume that the broker components and the broker's index are deployed on the same host.")
(defrule snippet/before -> :instruction "それまでの例でどう書いていたかと、何がよくなったかを 1〜2 文で書く。それまでの例に無いなら書かない"
  :sample "In previous examples, the instance service's path was included as a parameter in the resource home. In the FileBuy application we are using a much cleaner approach: we are putting all configuration information in a separate object which can be retrieved using JNDI.")
(defrule snippet/code -> :instruction "コードか設定の部分を示す。説明する行には番号の注記を付ける" :kind code-block)
(defrule snippet/where -> :instruction "その部分がどのファイルにあるかを 1 文で書く" :sample "This is part of $EXAMPLES_DIR/org/globus/examples/services/filebuy/seller/impl/FileResourceHome.java")
(defrule snippet/marks -> :instruction "注記を付けた行を、番号の順に 1 項目に 1 つ、その行で何をし、なぜそうするかを書く。注記が無ければ空にする"
  :sample "We are overriding the add method provided by the parent class. However, we have to invoke the parent's add method to make sure that the resource is correctly added. / Finally, we register the resource. Notice how the registration returns a Timer object which is then assigned to the resource's regTimer attribute."
  :kind number)
(defrule snippet/after -> :instruction "このコードがしたことを後で取り消すとき、または続けて使うときに、どこで何をするかを 1 文で書く。無ければ書かない"
  :sample "Finally, we also have to make sure that a resource's registration is cancelled if it is destroyed. We do this using the RemoveCallback interface's remove method in the resource.")
(defrule snippet/better -> :instruction "このコードをもっとよく書くならどうするか、そうしない代償は何かを 1 文で書く。無ければ書かない"
  :sample "Instead of hardcoding that we want to access the second element contained in the data, we could search through the aggregated resource properties and find the element called Price. This, however, would require additional code.")
