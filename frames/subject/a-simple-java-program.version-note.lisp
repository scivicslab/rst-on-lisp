;;; one difference between versions: what used to be required, what is required now
;;; members: p-note-class p-old-main p-io (p-older-java puts them together as steps)
(defrule version-note -> :background version-note/old :nucleus version-note/n)
(defrule version-note/old -> :instruction "以前の版で必要だった書き方を、どの版より前かが分かる 1 文で書く"
  :sample "Prior to Java 25, you had to explicitly declare the class containing the main method.")
(defrule version-note/n -> :instruction "いまの版ではどう書けばよいかを 1 文で書く"
  :sample "This is no longer necessary.")
