;;; subject: core-java-14-vol1 3.3.1 Integer Types (under 3.3 Data Types)
;;; made-from: doc_Base011/docs/Books-Programming/CoreJava14th_Vol1/Chap03/3. Fundamental Programming Structures in Java _ Core Java, Vol. I_ Fundamentals, 14th Edition_p006-010 / s331
;;; made-from: doc_Base011/docs/Books-Programming/CoreJava14th_Vol1/Chap03/3. Fundamental Programming Structures in Java _ Core Java, Vol. I_ Fundamentals, 14th Edition_p011-015 / s331
;;; members: p-int-what p-int-table p-int-which p-int-fixed p-int-literals p-int-binary p-int-unsigned p-int-as-unsigned
;;; elsewhere: p-int-c -> 3.3 Data Types (it is about all numeric types, and repeats p-int-fixed)
;;; left-out: none
(in-package :rst)
(defdocument IntegerTypesFrame)

(defrule document -> title sections)
(defrule title -> :instruction "説明する型の種類の名前を題にする")
(defrule sections -> s1)
(defrule s1 -> p-what p-table p-which p-fixed p-literals p-lacks :heading "## Integer Types")

;; what the types are for, and how many there are
(defrule p-what -> :nucleus p-what/n :elaboration-additional p-what/values :elaboration-set-member p-what/members)
(defrule p-what/n -> :instruction "この種類の型がどんな値を表すためのものかを 1 文で書く" :sample "The integer types are for numbers without fractional parts.")
(defrule p-what/values -> :instruction "表せる値について読み手が最初に知るべき性質を 1 文で書く" :sample "Negative values are allowed.")
(defrule p-what/members -> :instruction "この種類に属する型がいくつあるかを書き、表を指す" :sample "Java provides the four integer types shown in Table 3.1.")

;; each member with its size and range
(defrule p-table -> :instruction "型ごとに、名前、占める大きさ、表せる範囲を 1 行ずつ並べた表。1 行目は見出しの行" :kind table)

;; which member to use when
(defrule p-which -> :nucleus p-which/n :example p-which/bigger :elaboration-additional p-which/special)
(defrule p-which/n -> :instruction "ふだんはどの型を使えばよいかを 1 文で書く" :sample "In most situations, the int type is the most practical.")
(defrule p-which/bigger -> :instruction "それでは足りない場面を具体例で 1 文で書き、そのとき使う型を言う"
  :sample "If you want to represent the number of inhabitants of our planet, you'll need to resort to a long.")
(defrule p-which/special -> :instruction "残りの型が何のためにあるかを 1 文で書く"
  :sample "The byte and short types are mainly intended for specialized applications, such as low-level file handling, or for large arrays when storage space is at a premium.")

;; a property the reader can count on, why the language keeps it, and how another language differs
(defrule p-fixed -> :nucleus p-fixed/n :result p-fixed/eases :comparison p-fixed/other :reason p-fixed/because)
(defrule p-fixed/n -> :instruction "この言語でこの種類の型について読み手があてにしてよい性質を 1 文で書く"
  :sample "Under Java, the ranges of the integer types do not depend on the machine on which you will be running the Java code.")
(defrule p-fixed/eases -> :instruction "その性質で読み手の何が楽になるかを 1 文で書く"
  :sample "This alleviates a major pain for the programmer who wants to move software from one platform to another.")
(defrule p-fixed/other -> :instruction "読み手が知っていそうな別の言語ではどう違い、何が起きるかを 1〜2 文で書く。違いが無ければ書かない"
  :sample "In contrast, C and C++ programs use the most efficient integer type for each processor. As a result, a C program that runs well on a 32-bit processor may exhibit integer overflow on a 16-bit system.")
(defrule p-fixed/because -> :instruction "この言語がその性質を保つ理由を 1 文で書く"
  :sample "Since Java programs must run with the same results on all machines, the ranges for the various types are fixed.")

;; how to write values of the types in code
(defrule p-literals -> :instruction "この種類の値をコードに書く書き方を、1 項目に 1 つずつ、例を添えて挙げる。読み手が間違えやすい書き方には注意を添える"
  :sample "Long integer numbers have a suffix L or l (for example, 4000000000L). / Hexadecimal numbers have a prefix 0x or 0X (for example, 0xCAFE). / Octal numbers have a prefix 0 (for example, 010 is 8)—naturally, this can be confusing. / You can add underscores to number literals, such as 1_000_000; the compiler simply removes them."
  :kind bullet)

;; something the types do not have, and how to get by without it
(defrule p-lacks -> :nucleus p-lacks/n :elaboration-additional p-lacks/instead :elaboration-additional p-lacks/limit)
(defrule p-lacks/n -> :instruction "この種類の型に、読み手が他の言語から期待しそうで実は無いものを 1 文で書く。無いものが無ければ段落ごと書かない"
  :sample "Note that Java does not have any unsigned versions of the int, long, short, or byte types.")
(defrule p-lacks/instead -> :instruction "それが要るときの代わりのやり方を 1〜2 文で書く"
  :sample "If you work with integer values that can never be negative and you really need an additional bit, you can, with some care, interpret signed integer values as unsigned.")
(defrule p-lacks/limit -> :instruction "その代わりのやり方が通じる範囲と、通じないときにどうするかを 1〜2 文で書く"
  :sample "Addition, subtraction, and multiplication will work provided they don't overflow. For other operations, call Byte.toUnsignedInt(b) to get an int value between 0 and 255, then process the integer value and cast back to byte.")
