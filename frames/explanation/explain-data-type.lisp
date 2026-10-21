;;; use: Explains one kind of data type of a programming language: what it holds, its members, which to use, how to write
;;;      its values, what the reader can count on, what it cannot do, and the tests that go wrong.
;;; integrates: subject/data-types/integer-types.lisp
;;; integrates: subject/data-types/floating-point-types.lisp
;;; roles (role: integer-types / floating-point-types):
;;;   p-what:      p-what / p-what
;;;   p-table:     p-table / p-table
;;;   p-which:     p-which / p-which
;;;   p-literals:  p-literals / p-literals
;;;   p-guarantee: p-fixed (ranges do not depend on the machine) / p-rules (computations follow IEEE 754)
;;;   p-limit:     p-lacks (no unsigned types) / p-unfit (no exact decimal fractions)
;;;   p-pitfalls:  - / p-pitfalls
;;;   p-new:       - / p-new
(in-package :rst)
(defdocument ExplainDataTypeFrame)

(defrule document -> title sections)
(defrule title -> :instruction "説明する型の種類の名前を題にする")
(defrule sections -> s1)
(defrule s1 -> p-what p-table p-which p-literals p-guarantee p-limit p-pitfalls p-new :heading "## Data type")

;; what the types are for, and how many there are (both)
(defrule p-what -> :nucleus p-what/n :elaboration-set-member p-what/members)
(defrule p-what/n -> :instruction "この種類の型がどんな値を表すためのものかを 1 文で書く"
  :sample "The integer types are for numbers without fractional parts. / The floating-point types denote numbers with fractional parts.")
(defrule p-what/members -> :instruction "この種類に属する型がいくつあるかを書き、表を指す"
  :sample "Java provides the four integer types shown in Table 3.1. / The two floating-point types are shown in Table 3.2.")

;; each member with its size and range (both)
(defrule p-table -> :instruction "型ごとに、名前、占める大きさ、表せる範囲（精度があれば精度も）を 1 行ずつ並べた表。1 行目は見出しの行" :kind table)

;; which member to use when (both)
(defrule p-which -> :nucleus p-which/n :elaboration-additional p-which/others)
(defrule p-which/n -> :instruction "ふだんはどの型を使えばよいかを、理由とともに 1〜2 文で書く"
  :sample "In most situations, the int type is the most practical. / The limited precision of float (6-7 significant digits) is simply not sufficient for many situations.")
(defrule p-which/others -> :instruction "ほかの型をどんな場面で使うかを 1〜2 文で書く"
  :sample "If you want to represent the number of inhabitants of our planet, you'll need to resort to a long. / Use float values only when you work with a library that requires them, or when you need to store a very large number of them.")

;; how to write values of the types in code (both)
(defrule p-literals -> :instruction "この種類の値をコードに書く書き方を、1 項目に 1 つずつ、例を添えて挙げる。何も付けないと何の型になるか、読み手が間違えやすい書き方には注意を、それぞれ含める"
  :sample "Long integer numbers have a suffix L or l (for example, 4000000000L). / Floating-point numbers without an F suffix (such as 3.14) are always considered to be of type double. / Octal numbers have a prefix 0 (for example, 010 is 8)—naturally, this can be confusing."
  :kind bullet)

;; what the reader can count on, and why it helps (both, with different content)
(defrule p-guarantee -> :nucleus p-guarantee/n :result p-guarantee/helps :comparison p-guarantee/other)
(defrule p-guarantee/n -> :instruction "この種類の型のふるまいについて、言語が保証していて読み手があてにしてよいことを 1 文で書く"
  :sample "Under Java, the ranges of the integer types do not depend on the machine on which you will be running the Java code. / All floating-point computations follow the IEEE 754 specification.")
(defrule p-guarantee/helps -> :instruction "その保証があることで、読み手のプログラムがどうなるかを 1 文で書く"
  :sample "This alleviates a major pain for the programmer who wants to move software from one platform to another.")
(defrule p-guarantee/other -> :instruction "読み手が知っていそうな別の言語に同じ保証が無ければ、そこで何が起きるかを 1 文で書く。違いが無ければ書かない"
  :sample "A C program that runs well on a 32-bit processor may exhibit integer overflow on a 16-bit system.")

;; something the types cannot do, what happens if the reader relies on it, and what to do instead (both, with different content)
(defrule p-limit -> :nucleus p-limit/n :example p-limit/ex :recommendation p-limit/instead)
(defrule p-limit/n -> :instruction "この種類の型ではできないこと、または使ってはいけない用途を 1 文で書く"
  :sample "Java does not have any unsigned versions of the int, long, short, or byte types. / Floating-point numbers are not suitable for financial calculations in which roundoff errors cannot be tolerated.")
(defrule p-limit/ex -> :instruction "それに頼ると何が起きるかを、具体的な値で 1 文で示す"
  :sample "The command IO.println(2.0 - 1.1) prints 0.8999999999999999, not 0.9 as you would expect.")
(defrule p-limit/instead -> :instruction "代わりにどうすればよいかを 1〜2 文で書く"
  :sample "You can, with some care, interpret signed integer values as unsigned. / If you need precise numerical computations without roundoff errors, use the BigDecimal class.")

;; tests that look right and are wrong (floating-point only; leave empty when there are none)
(defrule p-pitfalls -> :instruction "この種類の値を比べたり調べたりするとき、正しく見えて誤っている書き方を挙げる。無ければ空にする"
  :frame "explain-data-type.pitfall.lisp" :heading "### Tests that go wrong")

;; a recent addition (floating-point only; leave out when there is none)
(defrule p-new -> :nucleus p-new/n :purpose p-new/for)
(defrule p-new/n -> :instruction "最近の版でこの種類の型に足されたものを、どの版かとともに 1 文で書く。無ければ段落ごと書かない"
  :sample "Java 20 adds a couple of methods (Float.floatToFloat16 and Float.float16toFloat) for storing \"half-precision\" 16-bit floating-point numbers in short values.")
(defrule p-new/for -> :instruction "それが何に使われるかを 1 文で書く" :sample "These are used for implementing neural networks.")
