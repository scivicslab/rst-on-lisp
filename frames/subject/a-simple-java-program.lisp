;;; subject: core-java-14-vol1 3.1 A Simple Java Program
;;; made-from: doc_Base011/docs/Books-Programming/CoreJava14th_Vol1/Chap03/3. Fundamental Programming Structures in Java _ Core Java, Vol. I_ Fundamentals, 14th Edition_p001-005 / s31
;;; made-from: doc_Base011/docs/Books-Programming/CoreJava14th_Vol1/Chap03/3. Fundamental Programming Structures in Java _ Core Java, Vol. I_ Fundamentals, 14th Edition_p006-010 / s31
;;; members: p-whole p-case p-method p-println p-class p-note-class p-old-main p-io p-older-java p-body p-call p-string p-args p-run p-compile p-launch
;;; elsewhere: p-braces -> 3.8.1 Block Scope; p-naming -> 4 (class names); p-print -> 3.7 Input and Output
;;; left-out: p-style (a matter of taste), p-spec-note p-bug-story (history of the launcher)
(in-package :rst)
(defdocument ASimpleJavaProgramFrame)

(defrule document -> title sections)
(defrule title -> :instruction "説明するプログラムを短く言う題を書く")
(defrule sections -> s1)
(defrule s1 -> p-whole concepts-in-program notes-on-versions how-to-run
              :heading "## A Simple Program")

;; the whole program first
(defrule p-whole -> :nucleus p-whole/n :example p-whole/code)
(defrule p-whole/n -> :instruction "いまから見せるプログラムが何をするプログラムかを 1 文で書く"
  :sample "Let's look more closely at one of the simplest Java programs you can have—one that merely prints a message to console:")
(defrule p-whole/code -> :instruction "プログラム全体を示す" :kind code-block)

;; one concept the program uses, in the order the code uses them (members p-case p-method p-println p-class p-body p-call p-string p-args)
(defrule concepts-in-program -> :instruction "このプログラムを読むのに要る概念を、コードに現れる順に挙げる。プログラムに書かれていない概念は挙げない"
  :frame "a-simple-java-program.concept.lisp" :heading "### The parts of the program")

;; what the same program looked like in older versions (members p-note-class p-old-main p-io p-older-java)
(defrule notes-on-versions -> :instruction "このプログラムの書き方のうち、以前の版では違っていたものを挙げる。違いが無ければ空にする"
  :frame "a-simple-java-program.version-note.lisp" :heading "### Older versions")

;; how to run it (members p-run p-compile p-launch)
(defrule how-to-run -> p-run p-compile :heading "### Running the program")
(defrule p-run -> :nucleus p-run/n :example p-run/code :result p-run/shows)
(defrule p-run/n -> :instruction "プログラムを動かすコマンドを導入する 1 文を書く" :sample "You run the sample program with this command:")
(defrule p-run/code -> :instruction "そのコマンドを示す" :kind code-block)
(defrule p-run/shows -> :instruction "動かすとプログラムが何を表示するか、何を起こすかを 1 文で書く"
  :sample "When the program executes, it simply displays the string We will not use 'Hello, World!' on the console.")
(defrule p-compile -> :nucleus p-compile/n :example p-compile/code :result p-compile/out :elaboration-additional p-compile/then :example p-compile/launch)
(defrule p-compile/n -> :instruction "先に変換してから動かす場合を、その理由とともに 1 文で導入する"
  :sample "If you intend to run a program multiple times, it is more efficient to compile it first:")
(defrule p-compile/code -> :instruction "変換のコマンドを示す" :kind code-block)
(defrule p-compile/out -> :instruction "変換でできるものが何で、どこに置かれるかを 1〜2 文で書く"
  :sample "You end up with a file containing the bytecodes for this class. The Java compiler names the bytecode file FirstSample.class and stores it in the same directory as the source file.")
(defrule p-compile/then -> :instruction "変換したものの動かし方を導入する 1 文を書く" :sample "Whenever you want to launch the program, issue the following command:")
(defrule p-compile/launch -> :instruction "変換したものを動かすコマンドを示す" :kind code-block)
