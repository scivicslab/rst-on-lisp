;;; one level of the setting that decides how deeply the model reasons per response
;;; roles: claude-doc: agent-loop.effort-level.lisp / opendev: the depth levels (OFF, LOW, MEDIUM, HIGH) of the thinking phase
(defrule effort-level -> :nucleus effort-level/depth :purpose effort-level/fits)
(defrule effort-level/depth -> :instruction "水準の名前と、その水準での考え方の深さを書く" :sample "Minimal reasoning, fast responses")
(defrule effort-level/fits -> :instruction "その水準に向く仕事の例を書く" :sample "File lookups, listing directories")
