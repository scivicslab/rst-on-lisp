;;; subject: core-java-14-vol1 3.3.2 Floating-Point Types (under 3.3 Data Types)
;;; made-from: doc_Base011/docs/Books-Programming/CoreJava14th_Vol1/Chap03/3. Fundamental Programming Structures in Java _ Core Java, Vol. I_ Fundamentals, 14th Edition_p011-015 / s332
;;; members: p-fp-what p-fp-table p-fp-which p-fp-half p-fp-literals p-fp-exp p-fp-hex p-fp-ieee p-fp-specials p-fp-special-ex p-fp-nan p-fp-zero p-fp-money
;;; elsewhere: (p-fp-money names BigDecimal -> 3.9 Big Numbers, as where to go instead; the paragraph stays here)
;;; left-out: none
(in-package :rst)
(defdocument FloatingPointTypesFrame)

(defrule document -> title sections)
(defrule title -> :instruction "説明する型の種類の名前を題にする")
(defrule sections -> s1)
(defrule s1 -> p-what p-table p-which p-new p-literals p-rules p-pitfalls p-unfit :heading "## Floating-Point Types")

;; what the types are for, and how many there are
(defrule p-what -> :nucleus p-what/n :elaboration-set-member p-what/members)
(defrule p-what/n -> :instruction "この種類の型がどんな値を表すためのものかを 1 文で書く" :sample "The floating-point types denote numbers with fractional parts.")
(defrule p-what/members -> :instruction "この種類に属する型がいくつあるかを書き、表を指す" :sample "The two floating-point types are shown in Table 3.2.")

;; each member with its size and range
(defrule p-table -> :instruction "型ごとに、名前、占める大きさ、表せる範囲（と精度）を 1 行ずつ並べた表。1 行目は見出しの行" :kind table)

;; which member to use when, and why
(defrule p-which -> :background p-which/name :reason p-which/short :nucleus p-which/n)
(defrule p-which/name -> :instruction "型どうしの違いが名前のどこに表れているかを 1 文で書く"
  :sample "The name double refers to the fact that these numbers have twice the precision of the float type.")
(defrule p-which/short -> :instruction "小さいほうの型では足りない理由を 1 文で書く"
  :sample "The limited precision of float (6-7 significant digits) is simply not sufficient for many situations.")
(defrule p-which/n -> :instruction "小さいほうの型を使ってよい場面だけを 1 文で書く"
  :sample "Use float values only when you work with a library that requires them, or when you need to store a very large number of them.")

;; a recent addition to the types, and what it is for
(defrule p-new -> :nucleus p-new/n :purpose p-new/for)
(defrule p-new/n -> :instruction "最近の版でこの種類の型に足されたものを、どの版かとともに 1 文で書く。無ければ段落ごと書かない"
  :sample "Java 20 adds a couple of methods (Float.floatToFloat16 and Float.float16toFloat) for storing \"half-precision\" 16-bit floating-point numbers in short values.")
(defrule p-new/for -> :instruction "それが何に使われるかを 1 文で書く" :sample "These are used for implementing neural networks.")

;; how to write values of the types in code
(defrule p-literals -> :instruction "この種類の値をコードに書く書き方を、1 項目に 1 つずつ、例を添えて挙げる。何も付けないと何の型になるかを必ず含める"
  :sample "Numbers of type float have a suffix F or f (for example, 3.14F). / Floating-point numbers without an F suffix (such as 3.14) are always considered to be of type double. / An E or e denotes a decimal exponent; 1.729E3 is the same as 1729. / You can specify floating-point literals in hexadecimal: 0x1.0p-3 is 0.125."
  :kind bullet)

;; the rules the arithmetic of the types follows, and the special values it can yield
(defrule p-rules -> :nucleus p-rules/n :elaboration-set-member p-rules/specials :example p-rules/ex)
(defrule p-rules/n -> :instruction "この種類の型の計算が従う規則を 1 文で書く" :sample "All floating-point computations follow the IEEE 754 specification.")
(defrule p-rules/specials -> :instruction "その規則が生む特別な値を挙げる" :sample "There are three special floating-point values to denote overflows and errors: positive infinity, negative infinity, and NaN (not a number).")
(defrule p-rules/ex -> :instruction "どんな計算でその特別な値ができるかを例で 1〜2 文で書く"
  :sample "For example, the result of dividing a positive floating-point number by 0 is positive infinity. Dividing 0.0 by 0 or the square root of a negative number yields NaN.")

;; tests that look right and are wrong, and the right ones
(defrule p-pitfalls -> :instruction "この種類の値を比べたり調べたりするとき、正しく見えて誤っている書き方を 1 つずつ挙げ、それぞれ正しい書き方を添える"
  :frame "floating-point-types.pitfall.lisp" :heading "### Tests that go wrong")

;; what the types must not be used for, why, and what to use instead
(defrule p-unfit -> :nucleus p-unfit/n :example p-unfit/ex :reason p-unfit/cause :recommendation p-unfit/use)
(defrule p-unfit/n -> :instruction "この種類の型を使ってはいけない用途を 1 文で書く"
  :sample "Caution: Floating-point numbers are not suitable for financial calculations in which roundoff errors cannot be tolerated.")
(defrule p-unfit/ex -> :instruction "使うと何が起きるかを、実行できる 1 行とその結果で示す"
  :sample "For example, the command IO.println(2.0 - 1.1) prints 0.8999999999999999, not 0.9 as you would expect.")
(defrule p-unfit/cause -> :instruction "そうなる理由を 1〜2 文で書く"
  :sample "Such roundoff errors are caused by the fact that floating-point numbers are represented in the binary number system. There is no precise binary representation of the fraction 9/10.")
(defrule p-unfit/use -> :instruction "その用途には代わりに何を使えばよいかを 1 文で書く"
  :sample "If you need precise numerical computations without roundoff errors, use the BigDecimal class.")
