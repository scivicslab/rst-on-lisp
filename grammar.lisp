;;; rst-on-lisp の共有文法。1 行が 1 つの生成式で、左辺の非終端記号が -> の右の並びに展開される。
;;; 非終端記号の名前、属性の名前、属性の値は英語で書く。日本語で書くのは、文書に現れる文字列だけである。
;;; 並びの語は非終端記号の名前か、(+ x) = x が 1 個以上、(* x) = x が 0 個以上、(? x) = x が 0 個か 1 個、
;;; (or x y) = x か y のどちらか 1 つである。並びの後ろの :key 値 は、その非終端記号の規則が持つ属性で、
;;; 値の string・file-name は文字列、required は何かが書かれていること、記号はその記号そのものを求める。
;;; 属性は既定でちょうど 1 回。(* :key 値) は 0 回以上、(+ :key 値) は 1 回以上、(? :key 値) は 0 回か 1 回。
;;; 属性の名前が非終端記号の名前であるもの（:relation-name など）は、その非終端記号が挙げる名前のどれを属性の名前に書いてもよい。
;;; 各文書の .lisp の規則は (defrule 名前 -> …) で、-> の左には名前を 1 つだけ書く。名前の最後の語から末尾の
;;; 数字を除いたもの（step1 なら step）がラベルで、ラベルがこの文法の左辺にあれば、その非終端記号の規則として照合する。
;;; 左辺に無ければ、規則の形から非終端記号を決める。

;; 文書の形
(document           -> (or explanation-document vision-document book-document))   ; どの形かは子の名前で決まる
(explanation-document -> title description problem-definition how-to-do-it under-the-hood related-docs)
(vision-document    -> title description business-requirement related-docs)
(book-document      -> title sections)   ; 本の文章。見出しは ## から始まる。front matter は defdocument の属性から書く
(title              -> string)
(description        -> string)
(how-to-do-it       -> (or program-description measurement selection guide anti-pattern command-list
                          investigation-report sub-paragraph))   ; sub-paragraph なら、中身を意味構造として対で書く
(under-the-hood     -> (* why))
(related-docs       -> (* related-doc))

;; 節 1 つを展開する非終端記号。右辺の各語が節の中身になる
(problem-definition -> (? preconditions-and-postconditions) (? terms) :nucleus content (* :relation-name content)
                      (* :relation-class content))
                      ; 中身は意味構造で、sub-paragraph と同じく対で書く。前提条件と達成状態・用語定義は形式的構造で、名前を並べる
(preconditions-and-postconditions -> preconditions postconditions)
(business-requirement -> business-background opportunities-and-obstacles business-objectives success-metrics
                         vision-statement)   ; Vision の文書の節。5 つとも :heading の見出しを持つ
(program-description  -> core-idea whole run concrete-values breakdown error-cases rules)
(measurement          -> aim procedure numbers reading)
(selection            -> candidates criteria verdict rejected)
(guide                -> goal (+ step))      ; 到達する状態を先に置き、段を順に進める
(anti-pattern         -> (+ entry))          ; 書き方の誤り 1 つが 1 項目
(command-list         -> (+ command))        ; コマンド 1 つが 1 節
(investigation-report -> (+ finding) resolution)  ; 調べて分かったことを順に置き、最後に直した内容
(why                  -> (+ body) :question string)
(related-doc          -> string :doc required
                         :relation (or prerequisite details applies-with example anti-pattern))

;; 節の中身。段落・箇条書き・コードブロックの並び。:heading の無いものは見出しが変換器の側で決まっている
(preconditions    -> list)
(postconditions   -> list)
(terms            -> (+ body) :heading string)
(business-background         -> (+ body) :heading string)
(opportunities-and-obstacles -> (+ body) :heading string)
(business-objectives         -> (+ body) :heading string)
(success-metrics             -> (+ body) :heading string)
(vision-statement            -> (+ body) :heading string)
(core-idea        -> (+ body))
(goal             -> (+ body))
(step             -> (+ body) :heading string)
(entry            -> (+ body) :heading string)
(command          -> (+ body) :heading string)
(finding          -> (+ body) :heading string)
(resolution       -> (+ body) :heading string)
(whole            -> (+ body) :heading string)
(run              -> (+ body) :heading string)
(concrete-values  -> (+ body) :heading string)
(breakdown        -> (+ body) :heading string)
(error-cases      -> (+ body) :heading string)
(rules            -> (+ body) :heading string)
(aim              -> (+ body) :heading string)
(procedure        -> (+ body) :heading string)
(numbers          -> (+ body) :heading string)
(reading          -> (+ body) :heading string)
(candidates       -> (+ body) :heading string)
(criteria         -> (+ body) :heading string)
(verdict          -> (+ body) :heading string)
(rejected         -> (+ body) :heading string)
(body             -> (or sub-paragraph list code-block table html-block image))
(sections         -> (+ section))                       ; 見出しを持つ節の並び。対の相手に置ける
(section          -> (+ (or body section)) :heading string)   ; 入れ子の深さで ### #### と見出しが下がる
;; 名前が文法の左辺に無い規則は形から決まる。:heading を持てば section、名前だけを並べていれば sections

;; sub-paragraph。核 1 つと、その核に結ばれるサテライトから成る。:nucleus が核で、ちょうど 1 つある。
;; :nucleus 相手 と :関係名 相手 の対を、書いた順に並べる。核の前にも後にも置ける。
;; :nucleus はちょうど 1 つ。関係名は 0 回以上で、同じものを 2 回以上書いてよく、書いた順に別のサテライトになる。
;; 相手は、文か、別の sub-paragraph か、箇条書きか表かコードブロックか HTML ブロックである。相手が sub-paragraph なら、
;; 段落と段落の間の関係になり、相手の段落は別の markdown の段落として書かれる。
;; 相手が複数の文になるときは、1 つの文字列に 2〜3 文を入れる。
;; sub-paragraph 1 つの中で相手が文である対は、つながって markdown の 1 段落になる。
;; 右辺に名前が無く、対だけを持つ規則を、変換器が sub-paragraph と決める。
;; 関係名は英語名である。下の 78 個が全部で、1 つずつの意味と例は
;; RST Discourse Treebank の関係 78 種（RstDtRelations_261008_oo01）にある。
;; 小文字で始まる名前は核とサテライトの関係、大文字で始まる名前は複数の核の関係である。
;; relation-class は同じ資料の 16 の類で、関係名の代わりに書いてよい
(sub-paragraph -> :nucleus content (* :relation-name content) (* :relation-class content))
(content       -> (or string sub-paragraph section sections list table code-block html-block image))
;; 文字列の中の空行は段落の区切りになる
(relation-name -> (or attribution attribution-n background circumstance cause result consequence-s consequence-n
                      Consequence Cause-Result comparison Comparison preference analogy Analogy Proportion condition
                      hypothetical contingency otherwise Otherwise antithesis Contrast concession elaboration-additional
                      elaboration-general-specific elaboration-part-whole elaboration-process-step
                      elaboration-object-attribute elaboration-set-member example definition purpose enablement
                      evaluation-s evaluation-n Evaluation interpretation-s interpretation-n Interpretation conclusion
                      Conclusion comment evidence explanation-argumentative reason Reason List Disjunction manner means
                      problem-solution-s problem-solution-n Problem-Solution question-answer-s question-answer-n
                      Question-Answer statement-response-s statement-response-n Statement-Response Topic-Comment
                      Comment-Topic rhetorical-question summary-s summary-n restatement temporal-before temporal-after
                      temporal-same-time Temporal-Same-Time Sequence Inverted-Sequence topic-shift Topic-Shift topic-drift
                      Topic-Drift Same-Unit TextualOrganization))
(relation-class -> (or attribution background cause comparison condition contrast elaboration enablement evaluation
                       explanation joint manner-means topic-comment summary temporal topic-change))

;; 箇条書き・コードブロック・表。終端記号の入れ物
(list       -> (+ (or item list)) :kind (or bullet number) (? :start required))   ; 中の list は前の項目の下に字下げして書く。:start は番号の始まり
(item       -> string)
(code-block -> :file file-name :kind code-block)
(html-block -> :file file-name :kind html-block)   ; 中身を fence で囲まずそのまま書く。rowspan のある表に使う
(image      -> :file file-name :kind image (? :alt string))   ; ![alt](file) と書く
(table      -> (+ row) :kind table)   ; 1 行目が見出しの行
(row        -> string)                ; 升は " | " で区切る
