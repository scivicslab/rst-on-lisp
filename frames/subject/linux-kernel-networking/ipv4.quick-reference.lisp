;;; subject: 4/Sec17 Quick Reference (4/Sec18 Methods, 4/Sec45 Macros): the methods and macros of the chapter, each with what it does
;;; made-from: doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p086-090 doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p091-095 / quickref methods macros
;;; members: every entry of methods and macros
;;; children: each entry is one copy of ipv4.reference-entry.lisp
;;; left-out: none
(defrule quick-reference -> qr/intro methods-intro methods macros-intro macros)
(defrule qr/intro -> :nucleus qr/intro/n)
(defrule qr/intro/n -> :instruction "章で出てきた大事なメソッドとマクロを短く並べて章を終える、と 1 文で書く"
  :sample "I conclude this chapter with a short list of important methods and macros of the IPv4 subsystem that were mentioned in this chapter.")
(defrule methods-intro -> :nucleus methods-intro/n)
(defrule methods-intro/n -> :instruction "メソッドの一覧を導入する 1 文を書く" :sample "The following is a short list of important methods of the IPv4 layer, which were mentioned in this chapter.")
(defrule methods -> :instruction "章で出てきたメソッドを、文脈の順に、1 行に 1 つ名前で挙げる" :frame "ipv4.reference-entry.lisp" :heading "#### Methods")
(defrule macros-intro -> :nucleus macros-intro/n)
(defrule macros-intro/n -> :instruction "マクロの一覧を、どの仕組みに関わるマクロかとともに導入する"
  :sample "This section mentions some macros from this chapter that deal with mechanisms encountered in the IPv4 stack, such as fragmentation, netfilter hooks, and IP options.")
(defrule macros -> :instruction "章で出てきたマクロを、1 行に 1 つ名前で挙げる" :frame "ipv4.reference-entry.lisp" :heading "#### Macros")
