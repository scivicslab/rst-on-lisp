;;; one level of the effort setting: its name, how deep the reasoning is, and the work it fits
;;; members: "low", "medium", "high", "xhigh", "max"
(defrule level -> :nucleus level/n :elaboration-additional level/fits)
(defrule level/n -> :instruction "水準の名前と、その水準での考え方の深さを 1 文で書く" :sample "Minimal reasoning, fast responses")
(defrule level/fits -> :instruction "その水準に向く仕事の例を 1 文で書く" :sample "File lookups, listing directories")
