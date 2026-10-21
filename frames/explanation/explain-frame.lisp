;;; use: Explains one frame of the frame library: what its subject is, where the subject sits in the subject tree,
;;;      the properties of the subject and the actions the subject allows, as the frame's parts write them.
;;; made-from: the request of 2026-10-21 (the four contents (1)-(4)); FrameOntology_261021_oo01 (subject tree = class
;;;            hierarchy, properties and actions = members of the class)
(in-package :rst)
(defdocument ExplainFrameFrame)

(defrule document -> title description problem-definition how-to-do-it under-the-hood related-docs)
(defrule title -> :instruction "「フレーム: 」に続けて、フレームの主題を本の見出しの語で書く")
(defrule description -> :instruction "このフレームが何を書くためのものか、どの本のどの節から作ったか、何を説明する文書かを 1〜3 行で書く")

;;; Problem Definition: where the frame came from, and what this document explains
(defrule problem-definition -> :background pd/source :nucleus pd/nucleus)
(defrule pd/source -> :instruction "フレームの元になった本と節、その節を規則ファイルに直したファイルを書き、その節を書いた人間の著者が何を説明していたかを 1〜2 文で書く")
(defrule pd/nucleus -> :instruction "本文書が、このフレームの主題、主題タグの木での位置、主題の性質、主題が可能な動作を説明することを 1 文で書く")

;;; How to do it: the four contents, in this order
(defrule how-to-do-it -> :nucleus parts)
(defrule parts -> subject tree properties actions frame-shape)

;; (1) the subject
(defrule subject -> subject/p :heading "### 主題")
(defrule subject/p -> :nucleus subject/n :elaboration-additional subject/use :antithesis subject/not)
(defrule subject/n -> :instruction "このフレームの主題を、主題タグの木の節点の名前で 1 文で書く")
(defrule subject/use -> :instruction "このフレームを埋めると、どんな対象について、読み手が何をできるようになる文章ができるかを 1 文で書く")
(defrule subject/not -> :instruction "同じ節に出てくるが、このフレームの主題ではないものがあれば、それが何で、なぜ主題ではないかを 1 文で書く。無ければ書かない")

;; (2) the subject tree itself, and its explanation
(defrule tree -> tree/intro tree/code tree/p :heading "### 主題タグの木")
(defrule tree/intro -> :nucleus tree/intro/n)
(defrule tree/intro/n -> :instruction "主題タグの木を、どの本の見出しから作ったかを 1 文で書き、主題の節点とその親・兄弟・子を示すことを言う")
(defrule tree/code -> :instruction "主題タグの木のうち、主題の節点、その親、兄弟、子を、番号と見出しで字下げして示す。主題の節点に印を付ける" :kind code-block)
(defrule tree/p -> :nucleus tree/p/n :elaboration-additional tree/p/elsewhere)
(defrule tree/p/n -> :instruction "主題が木のどこにあり、親の節点が主題をどんな種類のものとして束ねているかを 1〜2 文で書く")
(defrule tree/p/elsewhere -> :instruction "元の節の段落のうち、木の別の節点に回したものを、回した先の節点の名前とともに書く。回したものが無ければ書かない")

;; (3) the properties of the subject
(defrule properties -> properties/intro properties/list :heading "### 主題の性質")
(defrule properties/intro -> :nucleus properties/intro/n)
(defrule properties/intro/n -> :instruction "ここで性質と呼ぶものが、主題が何であり、どんな状態や値を持つかを述べるもので、フレームのどの部分が書くかを 1 文で書く")
(defrule properties/list -> :instruction "主題の性質を 1 項目に 1 つ挙げる。項目ごとに、性質の名前、元の本がそれをどう書いていたかの短い例、それを書くフレームの規則の名前を書く"
  :kind bullet)

;; (4) the actions the subject allows
(defrule actions -> actions/intro actions/list :heading "### 主題が可能な動作")
(defrule actions/intro -> :nucleus actions/intro/n)
(defrule actions/intro/n -> :instruction "ここで動作と呼ぶものが、主題に対して読み手や他の構成要素が行えること、または主題が行うことで、フレームのどの部分が書くかを 1 文で書く")
(defrule actions/list -> :instruction "主題が可能な動作を 1 項目に 1 つ挙げる。項目ごとに、動作の名前、誰が何に対して行うか、それを書くフレームの規則の名前を書く"
  :kind bullet)

;; the frame's own shape, so that the reader can find each part in the file
(defrule frame-shape -> frame-shape/p frame-shape/code :heading "### フレームの形")
(defrule frame-shape/p -> :nucleus frame-shape/p/n :elaboration-additional frame-shape/p/sub)
(defrule frame-shape/p/n -> :instruction "フレームのファイルの置き場所と、節の並びが上の性質と動作をどの順で書かせるかを 1〜2 文で書く")
(defrule frame-shape/p/sub -> :instruction "繰り返し現れる部分をサブフレームにしたものがあれば、サブフレームごとに、何を 1 つ書くか、元のどの段落から作ったかを書く")
(defrule frame-shape/code -> :instruction "フレームの節の並びを決める規則の行だけを示す" :kind code-block)

;;; Under the Hood: why paragraphs were left out
(defrule under-the-hood -> why1)
(defrule why1 -> why1/p :heading "### なぜ元の節の一部をフレームに入れなかったか")
(defrule why1/p -> :nucleus why1/p/n :elaboration-additional why1/p/each)
(defrule why1/p/n -> :instruction "元の節の段落のうち、主題にも木の別の節点にも当たらないので外したものがあれば、その段落が何を書いていたかを 1 文で書く。無ければ、外した段落が無いことと、その理由を書く")
(defrule why1/p/each -> :instruction "外した理由を、主題との関係で 1〜2 文で書く")

(defrule related-docs -> related-doc1 related-doc2)
(defrule related-doc1 -> "— フレームとは何か、お手本からフレームを作る手順" :doc OnFrame_261010_oo01 :relation prerequisite)
(defrule related-doc2 -> "— 目次から作る主題タグの木と、主題の性質と動作をクラスのメンバとして集める考え方" :doc FrameOntology_261021_oo01 :relation prerequisite)
