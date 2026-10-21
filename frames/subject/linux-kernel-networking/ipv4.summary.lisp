;;; subject: 4/Sec16 Summary: what the chapter covered, part by part, and what comes next
;;; made-from: doc_Base011/docs/Books-Infra/LinuxKernelNetworking/Chap04/CHAPTER 4_ IPv4 _ Linux Kernel Networking_ Implementation and Theory_p086-090 / summary
;;; members: the one paragraph of summary
;;; left-out: none
(defrule summary -> summary/p)
(defrule summary/p -> :nucleus summary/n :elaboration-additional summary/parts :elaboration-additional summary/special :elaboration-additional summary/next)
(defrule summary/n -> :instruction "この章が扱ったことを、主題と、その中で説明したデータの並びで 1 文で書く"
  :sample "This chapter dealt with the IPv4 protocol—how an IPv4 packet is built, the IPv4 header structure and IP options, and how they are handled.")
(defrule summary/parts -> :instruction "章で説明した道筋（登録、受信、送信）を、読み手が知ったこととして 1〜2 文で並べる"
  :sample "You learned how the IPv4 protocol handler is registered. You also learned about the Rx path and about the Tx path in IPv4.")
(defrule summary/special -> :instruction "特別な場合として扱ったこと（分割と組み立て直し、転送）を、なぜ要るかとともに 2〜3 文で書く"
  :sample "There are cases when packets are larger than the network interface MTU, and as a result they can't be sent without being fragmented on the sender side and later defragmented on the receiver side.")
(defrule summary/next -> :instruction "次の章が何を扱い、この後に何が続くかを 1〜2 文で書く"
  :sample "The next chapter discusses the IPv4 routing subsystem. The \"Quick Reference\" section that follows covers the top methods that are related to the topics discussed in this chapter.")
