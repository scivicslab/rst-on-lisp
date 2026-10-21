;;; one design principle the chapter teaches: the principle, shown on a decision of this chapter, and what happens without it
;;; members: p-good-before p-good-change (design before code), p-cost (cost vs. benefit), p-reuse p-reuse-decide (leverage existing services)
(defrule lesson -> :nucleus lesson/n :example lesson/shown :antithesis lesson/without)
(defrule lesson/n -> :instruction "設計の原則を 1 文で書く"
  :sample "Many of the design decisions you'll have to face are those which require you to analyze the cost of using a certain feature in relation to its potential benefits.")
(defrule lesson/shown -> :instruction "この章の設計上の決定のうち、その原則が現れたものを 1 つ取り上げ、1〜2 文で書く"
  :sample "If we didn't care about performance, we could argue that we should always use persistent resources. But we do care about performance, and this feature comes at a price: resources are stored on disk.")
(defrule lesson/without -> :instruction "その原則に従わないと何が起きるかを 1 文で書く"
  :sample "Changing your mind once the application is implemented, on the other hand, can be painful and time-consuming.")
