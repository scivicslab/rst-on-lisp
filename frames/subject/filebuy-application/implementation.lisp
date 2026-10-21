;;; subject: globus-toolkit-4 24 Implementation (Part IV The FileBuy Application): the implementation of a designed
;;;          distributed system, told as a roadmap to its code, one usage scenario at a time
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap24/globus_toolkit_p411-420 / ch24 s241 s242
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap24/globus_toolkit_p421-430 / s2421 s2422 s2423 s243 s244
;;; made-from: doc_Base011/docs/Books-Programming/GlobusToolkit/Chap24/globus_toolkit_p431-440 / s2443 s2444 s2445 s2446 s2447
;;; members: p-roadmap p-why-terse p-new-code p-code-dirs p-code-dirs-list p-wsdl-dir p-version-note p-gt-required
;;; children: 24.1 implementation.setting-up.lisp (:include); 24.2-24.4 implementation.scenario.lisp (:frame, one copy per scenario)
;;; left-out: conclusion (the end of the book), part5 / appendix-a (Appendix A Installing the Globus Toolkit 4, a node of its own)
(in-package :rst)
(defdocument ImplementationFrame)

(defrule document -> title sections)
(defrule title -> :instruction "実装を説明するシステムの名前と「実装」を題にする")
(defrule sections -> s1)
(defrule s1 -> p-roadmap p-easy p-new p-code-dirs p-code-dirs-list p-versions setting-up scenarios :heading "## Implementation")

;; what the chapter is, and how to read it (p-roadmap)
(defrule p-roadmap -> :background p-roadmap/design :nucleus p-roadmap/n :antithesis p-roadmap/not :elaboration-additional p-roadmap/read)
(defrule p-roadmap/design -> :instruction "設計を見終えて、これから実装を見ることを 1 文で書く" :sample "After seeing the design of the FileBuy application, we are now ready to see its implementation.")
(defrule p-roadmap/n -> :instruction "この章がコードへの道案内であることを 1 文で書く" :sample "This chapter is meant as a roadmap to the FileBuy code,")
(defrule p-roadmap/not -> :instruction "コードの動作を全部は説明しないことを 1 文で書く" :sample "and not a comprehensive explanation of every single action that takes place in the implementation.")
(defrule p-roadmap/read -> :instruction "コードを手元に開いて読むよう 1 文で勧める" :sample "As such, this chapter is meant to be read with the FileBuy code in front of you.")
;; why most of the code needs no explanation, and what is worth looking at (p-why-terse)
(defrule p-easy -> :nucleus p-easy/n :elaboration-additional p-easy/appeal :comparison p-easy/before)
(defrule p-easy/n -> :instruction "コードの大半が、どの章を読んでいれば読めるかを 1 文で書く"
  :sample "Most of the code should be easy to read if you have read all the previous chapters (or, at the very least, the Java WS Core chapters).")
(defrule p-easy/appeal -> :instruction "このコードで見どころになるのは何か（設計の図がコードのどこにどう現れるか）を 1 文で書く"
  :sample "The main appeal of this code is that it involves several services interacting with each other, so it'll be interesting to see how the sequence diagrams in the previous chapter translate to code.")
(defrule p-easy/before -> :instruction "それまでの例とどこが違うかを 1 文で書く。違いが無ければ書かない"
  :sample "In all the MathService examples control never flowed from one service to another.")
(defrule p-new -> :nucleus p-new/n)
(defrule p-new/n -> :instruction "それまでの章に無い、初めて出てくるコードが何に関わるものかを 1 文で書き、それは説明すると言う"
  :sample "Even so, there are a few bits and pieces of code that are completely new, especially those that deal with the GT4 Index Service, and we will provide an explanation for those.")
;; where the code is (p-code-dirs p-code-dirs-list p-wsdl-dir)
(defrule p-code-dirs -> :nucleus p-code-dirs/n)
(defrule p-code-dirs/n -> :instruction "コード全体をどこから手に入れられるかを書き、構成要素ごとの置き場所を挙げると言う"
  :sample "A complete implementation is available for download at the book's website. Each of the four services explained in the previous chapter can be found in the following directories:")
(defrule p-code-dirs-list -> :instruction "構成要素 1 つにつき 1 項目で、名前と置き場所のディレクトリを挙げる。インターフェースの定義の置き場所も含める"
  :sample "File Broker service: $EXAMPLES_DIR/org/globus/examples/services/filebuy/broker/ / File Seller service: $EXAMPLES_DIR/org/globus/examples/services/filebuy/seller/ / the WSDL files: $EXAMPLES_DIR/schema/examples/filebuy/"
  :kind bullet)
;; which version of the code this is, and which version of what it runs on is needed (p-version-note p-gt-required)
(defrule p-versions -> :nucleus p-versions/n :reason p-versions/because)
(defrule p-versions/n -> :instruction "このコードの版と、動かすのに要る土台の最低の版を 1〜2 文で書く。版の決まりが無ければ段落ごと書かない"
  :sample "The version of FileBuy described in this chapter is version 1.0. The FileBuy application requires at least version 4.0.1 of the toolkit.")
(defrule p-versions/because -> :instruction "それより前の版では何が起きるかを 1 文で書く" :sample "A small bug in GT4.0.0 prevents some of the code from compiling and running correctly.")

;; 24.1: what to set up before any scenario
(defrule setting-up -> :instruction "どの利用場面より前に用意しておくものを説明する" :include "implementation.setting-up.lisp" :heading "### Setting up")
;; 24.2-24.4: one usage scenario at a time, in the order of the design
(defrule scenarios -> :instruction "設計で挙げた利用場面を、1 行に 1 つ、設計と同じ順に、場面の名前で挙げる" :frame "implementation.scenario.lisp")
