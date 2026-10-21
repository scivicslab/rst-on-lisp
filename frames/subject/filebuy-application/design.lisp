;;; subject: globus-toolkit-4 23 Design (Part IV The FileBuy Application): the design of one distributed system, told with
;;;          a simplified UML (use case, sequence and deployment diagrams) before any code is written
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap23/globus_toolkit_p391-400 / ch23
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap23/globus_toolkit_p401-410 / s2331 s2332 s2333 s234 s235 s236
;;; members: p-design-plan p-design-review
;;;          23.1 p-broker-what p-broker-ex p-broker-term p-broker-vo p-broker-index p-broker-gateway p-broker-steps-intro p-broker-steps
;;;          23.2 p-filebuy-what p-filebuy-vo
;;;          23.3 p-cases p-cases-plan, and for each of the three scenarios: the sequence and its steps, each design detail, each general concept
;;;          23.4 p-deploy-hosts p-deploy-fig
;;;          23.5 p-sec-matters p-sec-tradeoff p-sec-plan p-authn-q p-authn-choice p-authn-method p-integrity p-authz-q p-authz-options p-authz-list p-authz-choice p-audit p-audit-events
;;;          23.6 p-good-before p-good-change p-cost p-reuse p-reuse-decide
;;; elsewhere: s225 -> 22.5 The Delegation Service; part4 (p-part-before p-part-filebuy p-part-two) -> Part IV; p-deploy-single -> 24.1.1 Running FileBuy on a Single Machine
;;; left-out: p-broker-complex (information systems out of scope), p-broker-index-own (a remark on one figure), p-broker-next p-reuse-next (transitions),
;;;           p-authz-more (decisions a real system would add), p-good-known (pointers to design books), refs
(in-package :rst)
(defdocument DesignFrame)

(defrule document -> title sections)
(defrule title -> :instruction "設計を説明するシステムの名前と「設計」を題にする")
(defrule sections -> s1)
(defrule s1 -> p-plan s-concept s-system s-cases s-deploy s-security s-lessons :heading "## Design")

;; what the chapter presents, in order (p-design-plan)
(defrule p-plan -> :nucleus p-plan/n :background p-plan/kind :elaboration-process-step p-plan/scenarios :elaboration-process-step p-plan/end)
(defrule p-plan/n -> :instruction "この章がどのシステムの設計を示すのかを 1 文で書く" :sample "In this chapter we present an overview of the design of FileBuy.")
(defrule p-plan/kind -> :instruction "そのシステムがどの種類のシステムで、だからまずその種類の考え方から説明する、と 1 文で書く"
  :sample "FileBuy is a resource brokering system, and so we begin with a conceptual overview of resource brokering.")
(defrule p-plan/scenarios -> :instruction "どの図法で、いくつの利用場面をたどるかを 1 文で書く" :sample "Then, using a simplified form of UML, we walk through three usage scenarios of the system.")
(defrule p-plan/end -> :instruction "最後に何を扱うかを 1 文で書く" :sample "The chapter concludes with a brief discussion on security considerations and a review of the important design concepts seen in this chapter.")

;; the kind of system, before this system (23.1)
(defrule s-concept -> p-concept-what p-concept-ex p-concept-term p-concept-parts p-concept-steps :heading "### The kind of system")
(defrule p-concept-what -> :nucleus p-concept-what/n :elaboration-additional p-concept-what/does :elaboration-process-step p-concept-what/ask :elaboration-process-step p-concept-what/answer)
(defrule p-concept-what/n -> :instruction "このシステムが属する種類のシステムを、どんな場で使われるものかとともに 1 文で導入する" :sample "A resource brokering system is a construct common to many Grid deployments.")
(defrule p-concept-what/does -> :instruction "その種類のシステムが全体として何をするかを 1 文で書く" :sample "Such systems track available resources in a virtual organization and mediate their use.")
(defrule p-concept-what/ask -> :instruction "利用する側が、誰に、何を伝えて始まるかを 1 文で書く。役割の名前を太字の語として導入する"
  :sample "When a service on the Grid (a resource consumer) requires a resource, it will contact a resource broker, specifying the type of resource it needs.")
(defrule p-concept-what/answer -> :instruction "受けた側がそれをどう処理するかを 1 文で書く" :sample "The resource broker then matches the request against available resources.")
(defrule p-concept-ex -> :nucleus p-concept-ex/n :elaboration-process-step p-concept-ex/then)
(defrule p-concept-ex/n -> :instruction "利用する側の要求を、具体的な数値の入った例で 1 文で書く" :sample "For example, a service might need to locate a machine with at least 10 GB of available disk space to store the result of a computation.")
(defrule p-concept-ex/then -> :instruction "その要求に対してシステムが何をするかを 1 文で書く" :sample "Given this request, the resource broker checks the list of resources in the virtual organization, and matches the request to the best possible resource.")
(defrule p-concept-term -> :nucleus p-concept-term/n :antithesis p-concept-term/not)
(defrule p-concept-term/n -> :instruction "この章でゆるい意味で使う語があれば、その意味を 1 文で書く。無ければ段落ごと書かない"
  :sample "Note that in this chapter, we use the term resource loosely, referring to \"resources on the Grid\" (such as CPUs, clusters, network storage, etc.).")
(defrule p-concept-term/not -> :instruction "同じ語の、技術上の正式な意味とどう違うかを 1 文で書く"
  :sample "We are not referring to the more formal WS-Resource, as defined in the WS-Resource Framework specification.")
(defrule p-concept-parts -> :instruction "その種類のシステムを形づくる構成要素を、利用の流れで現れる順に挙げる"
  :frame "design.component.lisp" :heading "#### Components")
(defrule p-concept-steps -> :nucleus p-concept-steps/n :example p-concept-steps/fig :elaboration-process-step p-concept-steps/list)
(defrule p-concept-steps/n -> :instruction "構成要素どうしのやりとりを順に示すことを 1 文で導入し、図を指す" :sample "Interactions in a typical resource brokerage can include the following (see also Figure 23.4):")
(defrule p-concept-steps/fig -> :instruction "構成要素とやりとりの全体を描いた図を示す" :kind image)
(defrule p-concept-steps/list -> :instruction "やりとりを 1 項目に 1 つ、起きる順に挙げる。項目ごとに、誰が誰に何をするかと、その行為の名前（advertising、aggregating、discovery など）を書く"
  :sample "Available resources register with a broker. This can be viewed as a way of advertising a resource to the VO. / The resource broker's index service collects, or aggregates, information about available resources. / A resource consumer contacts the broker service, requesting a resource that meets some parameters. Finding a resource based on its attributes is often referred to as the process of discovery."
  :kind number)

;; this system, mapped onto the kind (23.2)
(defrule s-system -> p-system-what p-system-scale :heading "### The system")
(defrule p-system-what -> :nucleus p-system-what/n :elaboration-object-attribute p-system-what/roles :elaboration-additional p-system-what/resources)
(defrule p-system-what/n -> :instruction "このシステムが誰と誰の間で何をするシステムかを 1 文で書く" :sample "FileBuy is a resource brokering system that enables buyers to purchase files from sellers linked by a wide-area network.")
(defrule p-system-what/roles -> :instruction "このシステムの参加者が、さきの種類のシステムのどの役割に当たるかを 1〜2 文で書く"
  :sample "In our system the sellers represent resource producers and the buyers represent resource consumers. Interactions between the two are mediated by the FileBuyBroker.")
(defrule p-system-what/resources -> :instruction "このシステムで扱う対象が何かを 1 文で書く" :sample "The \"resources\" in a FileBuy VO are not CPUs nor storage capacity, but data files.")
(defrule p-system-scale -> :nucleus p-system-scale/n :example p-system-scale/fig)
(defrule p-system-scale/n -> :instruction "1 つのシステムに各参加者がどれだけいるかを 1 文で書き、図を指す" :sample "A FileBuy VO is made up of one broker and (potentially) hundreds of buyers, sellers, and files.")
(defrule p-system-scale/fig -> :instruction "参加者の配置を描いた図を示す" :kind image)

;; the use cases, one by one (23.3)
(defrule s-cases -> p-cases p-cases-plan use-cases :heading "### Use cases")
(defrule p-cases -> :nucleus p-cases/n :example p-cases/fig)
(defrule p-cases/n -> :instruction "設計をたどるために取り上げる利用場面を、番号を付けて 1 文で挙げ、ユースケース図を指す"
  :sample "We consider three key use cases of the system: (1) advertising a file, (2) finding a file and (3) purchasing a file (Figure 23.6).")
(defrule p-cases/fig -> :instruction "ユースケース図を示す" :kind image)
(defrule p-cases-plan -> :nucleus p-cases-plan/n :elaboration-process-step p-cases-plan/decisions :elaboration-process-step p-cases-plan/concepts)
(defrule p-cases-plan/n -> :instruction "各利用場面をまず構成要素のやりとりの順にたどることを 1 文で書く" :sample "We begin by walking through the sequence of component interactions for each use case.")
(defrule p-cases-plan/decisions -> :instruction "次に設計上の決定を説明することを 1 文で書く" :sample "A brief explanation of key design decisions follows.")
(defrule p-cases-plan/concepts -> :instruction "最後にその場面から言える一般的な考え方を挙げることを 1 文で書く" :sample "Then each use case study concludes with highlights of important general concepts.")
(defrule use-cases -> :instruction "取り上げる利用場面を、1 行に 1 つ、上で挙げた順に挙げる" :frame "design.use-case.lisp" :heading "#### Usage scenarios")

;; where the parts run (23.4)
(defrule s-deploy -> p-deploy-hosts p-deploy-fig :heading "### Deployment")
(defrule p-deploy-hosts -> :nucleus p-deploy-hosts/n :comparison p-deploy-hosts/before :elaboration-set-member p-deploy-hosts/platforms)
(defrule p-deploy-hosts/n -> :instruction "このシステムの配置が、それまでの例と比べてどう違うかを 1 文で書く" :sample "Unlike the MathService example seen throughout the book, the deployment of FileBuy is more complex as it involves multiple hosts.")
(defrule p-deploy-hosts/before -> :instruction "それまでの例ではどう配置していたかを 1 文で書く。比べる例が無ければ書かない" :sample "With MathService, we were quite content to deploy the service on our local container, and invoke it from our own machine.")
(defrule p-deploy-hosts/platforms -> :instruction "このシステムを何種類の機械に分けて置くかを、種類の名前とともに 1 文で書く" :sample "FileBuy is intended to be deployed across three types of platforms: the buyer, the broker, and the seller.")
(defrule p-deploy-fig -> :nucleus p-deploy-fig/n :elaboration-additional p-deploy-fig/legend :example p-deploy-fig/fig)
(defrule p-deploy-fig/n -> :instruction "配置図が何を示すかを 1 文で書く" :sample "Figure 23.10 contains an overview of the components deployed on each platform, and the relationship between each component.")
(defrule p-deploy-fig/legend -> :instruction "配置図の線の種類ごとに、何を表すかを 1 文で書く" :sample "The straight arrows represent communication dependencies, while the dotted arrows represent creation of WS-Resources.")
(defrule p-deploy-fig/fig -> :instruction "配置図を示す" :kind image)

;; the security decisions (23.5)
(defrule s-security -> p-sec-matters p-sec-tradeoff security-decisions :heading "### Security")
(defrule p-sec-matters -> :nucleus p-sec-matters/n :reason p-sec-matters/because)
(defrule p-sec-matters/n -> :instruction "この種類のシステムで安全性がなぜ大事かを、参加者の性質から 1〜2 文で書く"
  :sample "Security is a primary concern in the context of Grid computing, as Grid-based collaborations involve people from multiple administrative domains sharing important resources.")
(defrule p-sec-matters/because -> :instruction "参加者が協力していても守る必要がある理由を 1 文で書く"
  :sample "While participants in a VO agree in principle to work together, that openness increases the importance of protecting the system from naive or intentional misuse.")
(defrule p-sec-tradeoff -> :background p-sec-tradeoff/q :nucleus p-sec-tradeoff/n :elaboration-additional p-sec-tradeoff/challenge)
(defrule p-sec-tradeoff/q -> :instruction "すべての安全機構を使えばよいのでは、という問いを 1 文で立てる" :sample "So why not lock everything down with a full complement of security mechanisms?")
(defrule p-sec-tradeoff/n -> :instruction "そうしない理由（安全機構が何を犠牲にするか）を 1 文で答える" :sample "The answer is simple: runtime security adversely affects performance.")
(defrule p-sec-tradeoff/challenge -> :instruction "だから設計者が何と何を釣り合わせ、何で決めるかを 1〜2 文で書く"
  :sample "The challenge for the system designer is to minimize the potential for exploits while at the same time optimizing for performance. In practice the correct design decisions are highly dependent on the requirements imposed by the problem domain and the policies of the participants.")
(defrule security-decisions -> :instruction "このシステムで下した安全上の決定を、1 行に 1 つ、決める事柄の名前（認証、通信の秘匿と完全性、認可、監査など）で挙げる"
  :frame "design.security-decision.lisp" :heading "#### Security decisions")

;; what the chapter teaches about design (23.6)
(defrule s-lessons -> :instruction "この設計から読み手が持ち帰るべき設計の原則を、1 行に 1 つ挙げる" :frame "design.lesson.lisp" :heading "### Summing up")
