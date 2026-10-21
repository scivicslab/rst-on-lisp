;;; the kind of system a program belongs to: what it does, an example request, a term used loosely, its components, and
;;; how they interact
;;; from: design.resource-brokering-overview.lisp (kind-of-system)
(defrule kind-of-system -> p-concept-what p-concept-ex p-concept-term p-concept-parts p-concept-steps)
(defrule p-concept-what -> :nucleus p-concept-what/n :elaboration-additional p-concept-what/does :elaboration-process-step p-concept-what/ask :elaboration-process-step p-concept-what/answer)
(defrule p-concept-what/n -> :instruction "このプログラムが属する種類のシステムを、どんな場で使われるものかとともに 1 文で導入する" :sample "A resource brokering system is a construct common to many Grid deployments.")
(defrule p-concept-what/does -> :instruction "その種類のシステムが全体として何をするかを 1 文で書く" :sample "Such systems track available resources in a virtual organization and mediate their use.")
(defrule p-concept-what/ask -> :instruction "利用する側が、誰に、何を伝えて始まるかを 1 文で書く。役割の名前を導入する"
  :sample "When a service on the Grid (a resource consumer) requires a resource, it will contact a resource broker, specifying the type of resource it needs.")
(defrule p-concept-what/answer -> :instruction "受けた側がそれをどう処理するかを 1 文で書く" :sample "The resource broker then matches the request against available resources.")
(defrule p-concept-ex -> :nucleus p-concept-ex/n :elaboration-process-step p-concept-ex/then)
(defrule p-concept-ex/n -> :instruction "利用する側の要求を、具体的な数値の入った例で 1 文で書く" :sample "For example, a service might need to locate a machine with at least 10 GB of available disk space to store the result of a computation.")
(defrule p-concept-ex/then -> :instruction "その要求に対してシステムが何をするかを 1 文で書く" :sample "Given this request, the resource broker checks the list of resources in the virtual organization, and matches the request to the best possible resource.")
(defrule p-concept-term -> :nucleus p-concept-term/n :antithesis p-concept-term/not)
(defrule p-concept-term/n -> :instruction "この説明でゆるい意味で使う語があれば、その意味を 1 文で書く。無ければ段落ごと書かない"
  :sample "Note that in this chapter, we use the term resource loosely, referring to \"resources on the Grid\" (such as CPUs, clusters, network storage, etc.).")
(defrule p-concept-term/not -> :instruction "同じ語の、技術上の正式な意味とどう違うかを 1 文で書く"
  :sample "We are not referring to the more formal WS-Resource, as defined in the WS-Resource Framework specification.")
(defrule p-concept-parts -> :instruction "その種類のシステムを形づくる構成要素を、利用の流れで現れる順に挙げる"
  :frame "explain-program.component.lisp" :heading "#### Components")
(defrule p-concept-steps -> :nucleus p-concept-steps/n :example p-concept-steps/fig :elaboration-process-step p-concept-steps/list)
(defrule p-concept-steps/n -> :instruction "構成要素どうしのやりとりを順に示すことを 1 文で導入し、図を指す" :sample "Interactions in a typical resource brokerage can include the following (see also Figure 23.4):")
(defrule p-concept-steps/fig -> :instruction "構成要素とやりとりの全体を描いた図を示す" :kind image)
(defrule p-concept-steps/list -> :instruction "やりとりを 1 項目に 1 つ、起きる順に挙げる。項目ごとに、誰が誰に何をするかと、その行為の名前を書く"
  :sample "Available resources register with a broker. This can be viewed as a way of advertising a resource to the VO. / A resource consumer contacts the broker service, requesting a resource that meets some parameters. Finding a resource based on its attributes is often referred to as the process of discovery."
  :kind number)
