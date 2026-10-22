;;; one level of the setting that decides how deeply the model reasons per response
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule effort-level -> :nucleus effort-level/depth :purpose effort-level/fits)
(defrule effort-level/depth -> :instruction "水準の名前と、その水準での考え方の深さを書く" :sample "Minimal reasoning, fast responses")
(defrule effort-level/fits -> :instruction "その水準に向く仕事の例を書く" :sample "File lookups, listing directories")
