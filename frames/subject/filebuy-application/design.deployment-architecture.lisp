;;; subject: globus-toolkit-4 23.4 Deployment Architecture
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap23/globus_toolkit_p401-410 / s234
;;; members: p-deploy-hosts p-deploy-fig
;;; left-out: none (p-deploy-single -> 24.1.1 Running FileBuy on a Single Machine)
;;; included by: design.lisp (s-deploy); where the parts run
;; where the parts run (23.4)
(defrule deployment -> p-deploy-hosts p-deploy-fig)
(defrule p-deploy-hosts -> :nucleus p-deploy-hosts/n :comparison p-deploy-hosts/before :elaboration-set-member p-deploy-hosts/platforms)
(defrule p-deploy-hosts/n -> :instruction "このシステムの配置が、それまでの例と比べてどう違うかを 1 文で書く" :sample "Unlike the MathService example seen throughout the book, the deployment of FileBuy is more complex as it involves multiple hosts.")
(defrule p-deploy-hosts/before -> :instruction "それまでの例ではどう配置していたかを 1 文で書く。比べる例が無ければ書かない" :sample "With MathService, we were quite content to deploy the service on our local container, and invoke it from our own machine.")
(defrule p-deploy-hosts/platforms -> :instruction "このシステムを何種類の機械に分けて置くかを、種類の名前とともに 1 文で書く" :sample "FileBuy is intended to be deployed across three types of platforms: the buyer, the broker, and the seller.")
(defrule p-deploy-fig -> :nucleus p-deploy-fig/n :elaboration-additional p-deploy-fig/legend :example p-deploy-fig/fig)
(defrule p-deploy-fig/n -> :instruction "配置図が何を示すかを 1 文で書く" :sample "Figure 23.10 contains an overview of the components deployed on each platform, and the relationship between each component.")
(defrule p-deploy-fig/legend -> :instruction "配置図の線の種類ごとに、何を表すかを 1 文で書く" :sample "The straight arrows represent communication dependencies, while the dotted arrows represent creation of WS-Resources.")
(defrule p-deploy-fig/fig -> :instruction "配置図を示す" :kind image)
