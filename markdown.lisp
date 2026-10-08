;;; 文書の規則を定義し、document から辿って markdown を書く。ABCL で (load) して使う。

;; 小文字だけの記号は大文字に、大文字小文字の混じる記号はそのまま読む。文書の id
;; GrammarAndDerivation_261006_oo01 のような名前を、書いたとおりに出すため。
(setf (readtable-case *readtable*) :invert)

(defpackage :rst (:use :cl) (:export :defrule :defdocument :render :check :load-grammar :reset :build))
(in-package :rst)

;; ABCL の *error-output* は標準出力と同じ所へ出るので、標準エラー出力には Java の System.err で書く
(defun stderr (s) (java:jcall "println" (java:jfield "java.lang.System" "err") s))
;; 読み込み中の誤りはデバッガに入らず、1 行印字して終了状態 1 で止まる
(setf *debugger-hook* (lambda (c h) (declare (ignore h)) (stderr (format nil "error: ~a" c)) (ext:quit :status 1)))

(defvar *rules* (make-hash-table :test #'equal))   ; 名前(文字列) -> (rhs attrs terminal-p)
(defvar *order* '())
(defvar *doc-id* nil)
(defvar *doc-attrs* nil)
(defvar *dir* nil)   ; 規則ファイルの場所。:file はここから読む
(defparameter *relations* '("ELABORATION" "EVIDENCE" "CONCESSION" "SOLUTIONHOOD" "BACKGROUND" "JUSTIFY" "CONTRAST" "SEQUENCE"))
(defparameter *nucleus* '("NUCLEUS"))   ; 核を指す属性の名前
(defun nucleus-key-p (k) (member k *nucleus* :test #'string=))
(defun part-key-p (k) (let ((n (symbol-name k))) (or (nucleus-key-p n) (member n *relations* :test #'string=))))

(defun nm (sym) (if (symbolp sym) (symbol-name sym) sym))
(defun shown (v) (if (symbolp v) (princ-to-string v) v))   ; 記号を書いたとおりの大文字小文字で

(defmacro defdocument (id &rest attrs)
  ;; :file の相対名は、この defdocument を含むファイルのディレクトリから読む
  `(progn (setf *doc-id* ,(shown id) *doc-attrs* ',attrs
                *dir* (or *load-truename* *default-pathname-defaults*)) nil))

;; (defrule ラベル [名前] -> 右辺… 属性…)。名前はラベルと違うときだけ書く。右辺は名前の並びか
;; 文字列 1 つで、無ければ未展開の非終端である。
(defmacro defrule (label &rest more)
  (let* ((named (not (eq (first more) '->)))
         (name (if named (first more) label))
         (rest (if named (rest (rest more)) (rest more)))
         (term (stringp (first rest)))
         (rhs (if term (first rest)
                  (loop for x in rest while (and (symbolp x) (not (keywordp x))) collect (nm x))))
         (attrs (if term (rest rest) (nthcdr (length rhs) rest))))
    (loop for (k v) on attrs by #'cddr
          unless (keywordp k)
          do (error "~a: after the right-hand side only :key value pairs may follow; found ~s~@[ (a terminal has exactly one string)~]"
                    (nm name) k term))
    `(progn (setf (gethash ,(nm name) *rules*) (list ',rhs ',attrs ,term ,(nm label)))
            (push ,(nm name) *order*) nil)))

(defun rule (name) (or (gethash name *rules*) (error "no rule ~a" name)))
(defun rhs (name) (first (rule name)))
(defun attr (name key) (getf (second (rule name)) key))
(defun attr-str (name key) (shown (attr name key)))
(defun terminal-p (name) (or (third (rule name)) (attr name :file)))
(defun last-segment (name) (let ((p (position #\/ name :from-end t))) (if p (subseq name (1+ p)) name)))
(defun label (name)   ; 明示のラベルか、無ければ名前の最後の語。末尾の数字は番号なので除く（核1 核2 -> 核）
  (let ((l (fourth (rule name))))
    (if (string= l name) (string-right-trim "0123456789" (last-segment name)) l)))
(defun parts (name)   ; 書いた順の (鍵 . 相手の名前) の並び
  (loop for (k v) on (second (rule name)) by #'cddr when (part-key-p k) collect (cons (symbol-name k) (nm v))))
(defun text-p (name) (and (third (rule name)) t))   ; 文の規則。右辺が文字列 1 つ
(defun paragraph-p (name)   ; sub-paragraph。対だけを持ち、裸の名前を持たない
  (or (string= (label name) "SUB-PARAGRAPH")
      (and (not (terminal-p name)) (null (rhs name)) (parts name) t)))

(defun render-paragraph (name)
  "段落の部分を書いた順に見る。文は連結して 1 つの散文にし、箇条書き・コードブロック・表はそこで
   散文を区切ってその形で書く。相手が段落なら、その中の部分を同じ散文に続けて連結する。"
  (let ((run '()))
    (labels ((flush () (when run (out-wrapped (apply #'concatenate 'string (nreverse run))) (out) (setf run '())))
             (walk (node)
               (cond ((text-p node) (push (rhs node) run))
                     ((paragraph-p node) (dolist (pr (parts node)) (walk (cdr pr))))
                     (t (flush) (render-body (list node))))))
      (dolist (pr (parts name)) (walk (cdr pr)))
      (flush))))

(defun out (&rest parts) (dolist (p parts) (write-string p)) (terpri))

;; ---- 折り返し ----
;; 1 行を表示幅 110 桁で折る。CJK は 2 桁、他は 1 桁。ASCII の連なりとバッククォートで囲んだ区間は
;; 分割しない。行頭に置けない文字（、。）」など）の前と、行末に置けない文字（（「など）の後では折らない。
(defparameter *width* 110)
(defparameter *no-start* "、。）」』・，．：；！？*")   ; * は太字の ** が行頭に来ると閉じないため
(defparameter *no-end* "（「『*")
(defun cjk-p (ch) (>= (char-code ch) #x3000))
(defun swidth (s) (loop for c across s sum (if (cjk-p c) 2 1)))

(defun tokens (s)
  (let ((out '()) (i 0) (n (length s)))
    (loop while (< i n) do
      (let ((c (char s i)))
        (cond ((char= c #\`)
               (let ((j (position #\` s :start (1+ i))))
                 (if j (progn (push (subseq s i (1+ j)) out) (setf i (1+ j)))
                     (progn (push (string c) out) (incf i)))))
              ((or (cjk-p c) (char= c #\Space)) (push (string c) out) (incf i))
              (t (let ((j i))
                   (loop while (and (< j n) (not (cjk-p (char s j)))
                                    (char/= (char s j) #\Space) (char/= (char s j) #\`))
                         do (incf j))
                   (push (subseq s i j) out) (setf i j))))))
    (nreverse out)))

(defun wrap (s &optional (width *width*) (indent ""))
  "トークンを行に詰める。行頭に置けないトークンで幅を超えたら、その 1 つ前のトークンから次の行へ送る。"
  (let ((lines '()) (line '()))   ; line はトークンの逆順リスト
    (flet ((text (toks) (apply #'concatenate 'string (reverse toks)))
           (flush () (push (string-right-trim " " (apply #'concatenate 'string (reverse line))) lines)))
      (dolist (tok (tokens s))
        (let ((w (+ (swidth (text (cons tok line))) (if lines (swidth indent) 0))))
          (cond ((or (<= w width) (null line)) (push tok line))
                ((find (char tok 0) *no-start*)
                 (let ((prev (pop line)))
                   (if (null line) (setf line (list tok prev))
                       (progn (flush) (setf line (list tok (string-left-trim " " prev)))))))
                ((find (char (first line) (1- (length (first line)))) *no-end*)
                 (let ((prev (pop line)))
                   (if (null line) (setf line (list tok prev))
                       (progn (flush) (setf line (list tok prev))))))
                (t (flush) (setf line (list (string-left-trim " " tok)))))))
      (when line (flush)))
    (setf lines (nreverse lines))
    (cons (first lines) (mapcar (lambda (l) (concatenate 'string indent l)) (rest lines)))))

(defun out-wrapped (s &optional (width *width*) (indent ""))
  (dolist (l (wrap s width indent)) (out l)))

(defun file-text (name)
  (with-open-file (in (merge-pathnames name *dir*) :external-format :utf-8)
    (let ((s (make-string (file-length in))))
      (subseq s 0 (read-sequence s in)))))

(defun fenced (name)   ; 拡張子で fence の言語を決める。.txt は言語なし
  (let* ((dot (position #\. name :from-end t))
         (ext (if dot (subseq name (1+ dot)) ""))
         (lang (cond ((string= ext "lisp") "lisp") ((string= ext "md") "markdown") ((string= ext "sh") "bash") ((string= ext "py") "python") (t ""))))
    (let* ((text (file-text name))
           (fence (if (search "```" text) "````" "```")))   ; 中身に ``` があれば 4 つで囲む
      (concatenate 'string fence lang (string #\Newline) text fence))))

(defun split-cells (s)   ; "a | b | c" -> ("a" "b" "c")
  (let ((cells '()) (start 0))
    (loop for p = (search " | " s :start2 start)
          do (push (subseq s start p) cells)
          while p do (setf start (+ p 3)))
    (nreverse cells)))

(defun render-body (names)
  (dolist (n names)
    (cond ((eq (attr n :kind) 'code-block)
           (out (if (attr n :file) (fenced (attr-str n :file)) (rhs n))) (out))
          ((eq (attr n :kind) 'html-block)   ; ファイルの中身を fence で囲まずそのまま書く
           (out (file-text (attr-str n :file))) (out))
          ((paragraph-p n) (render-paragraph n))
          ((eq (attr n :kind) '表)
           (let ((rows (mapcar (lambda (r) (split-cells (rhs r))) (rhs n))))
             (out "| " (format nil "~{~a~^ | ~}" (first rows)) " |")
             (out "|" (format nil "~{~a~^|~}" (mapcar (lambda (c) (declare (ignore c)) "---") (first rows))) "|")
             (dolist (r (rest rows)) (out "| " (format nil "~{~a~^ | ~}" r) " |"))
             (out)))
          ((member (attr n :kind) '(印 番号))
           (let ((num (eq (attr n :kind) '番号)) (k 0))
             (dolist (it (rhs n)) (incf k)
               (let* ((lead (if num (format nil "~d. " k) "- "))
                      (ls (wrap (rhs it) (- *width* (swidth lead)) (if num "   " "  "))))
                 (out lead (first ls)) (dolist (l (rest ls)) (out l))))
             (out)))
          (t (render-body (rhs n))))))

(defun render-section (n)   ; 段落 1 つの節点か、段落の並びを持つ節点
  (render-body (if (paragraph-p n) (list n) (rhs n))))

;; ---- 木の検査 ----
;; 根と front matter（title・description）を除く全ての規則は、親の核（:rel 無し）か、
;; :rel と :of を持つ衛星か、兄弟全部が同じ多核の関係（列挙・順序・対比）を持つかのどれかである。
(defun check (&optional (stream *standard-output*))
  "文法との照合と、段落の中の関係を調べ、違反の行と件数を stream に印字して件数を返す。
   節と節の間の関係は文法が形として書いているので調べない。
   段落は、部分を書いた順の (:鍵 相手) の対で持つ。鍵 :nucleus が核で、ちょうど 1 つある。"
  (let ((n 0))
    (flet ((report (fmt &rest args) (incf n) (apply #'format stream fmt args) (terpri stream)))
      (when (plusp (hash-table-count *grammar*)) (check-grammar #'report))
      (dolist (name (reverse *order*))
        (let ((ps (parts name)))
          (when (or ps (paragraph-p name))
            (dolist (pr ps)
              (cond ((null (gethash (cdr pr) *rules*))
                     (report "~a: ~a: no rule for ~a named after :~a" *doc-id* (pretty name) (pretty (cdr pr)) (pretty (car pr))))
                    ((string= (cdr pr) name)
                     (report "~a: ~a: :~a points at itself" *doc-id* (pretty name) (pretty (car pr))))))))))
    (format stream "~d violations~%" n)
    n))


;; ---- 文法 ----
;; 文法ファイルの 1 行 (lhs -> 項… :key 値…) を読む。項は名前、(+ x)、(* x)、(? x)、(or x…)。
;; *grammar*: 左辺(文字列) -> (項の並び 属性plist)
(defvar *grammar* (make-hash-table :test #'equal))

(defun item (x)   ; 読んだ項を、名前は文字列に、(+ x) などは (op 項) にする
  (if (consp x) (cons (nm (first x)) (mapcar #'item (rest x))) (nm x)))

(defun load-grammar (path)
  (clrhash *grammar*)
  (with-open-file (in path :external-format :utf-8)
    (loop for form = (read in nil nil) while form
          do (let* ((lhs (nm (first form)))
                    (body (rest (rest form)))   ; -> の右
                    (items (loop for x in body until (keywordp x) collect (item x)))
                    (attrs (nthcdr (length items) body)))
               (setf (gethash lhs *grammar*) (list items attrs)))))
  (hash-table-count *grammar*))

(defun production (lhs) (gethash lhs *grammar*))
(defun pretty (s)   ; 読み取り器が大文字にした名前を、書いたとおりの小文字に戻して見せる
  (if (and (stringp s) (notany #'lower-case-p s)) (string-downcase s) s))
(defun op-p (x name) (and (consp x) (string-equal (first x) name)))
(defun alias-p (lhs)   ; 右辺が名前 1 つで属性の無い規則。その名前の規則で代用する
  (let ((p (production lhs)))
    (and p (null (second p)) (= (length (first p)) 1) (stringp (first (first p))) (production (first (first p)))
         (first (first p)))))

(defun kind (name)   ; この規則が文法のどの非終端か。ラベルがそれで、無ければ形から決める
  (let ((l (label name)))
    (cond ((production l) l)
          ((eq (attr name :kind) 'code-block) "CODE-BLOCK")
          ((eq (attr name :kind) 'html-block) "HTML-BLOCK")
          ((member (attr name :kind) '(印 番号)) "LIST")
          ((eq (attr name :kind) '表) "TABLE")
          ((paragraph-p name) "SUB-PARAGRAPH")
          ((terminal-p name) "文字列")
          (t l))))

(defun matches (sym k)   ; 文法の名前 sym に、種類 k の子を当てられるか
  (or (string= sym k)
      (let ((p (production sym)))
        (and p (null (second p))
             (some (lambda (alt) (and (= (length alt) 1)
                                      (let ((a (first alt)))
                                        (if (consp a)
                                            (and (op-p a "or") (some (lambda (y) (matches y k)) (rest a)))
                                            (matches a k)))))
                   (list (first p)))))))

(defun match (items kinds)   ; 項の並びに子の種類の並びが合うか（後戻りつき）
  (cond ((null items) (null kinds))
        (t (let ((it (first items)) (more (rest items)))
             (if (stringp it)
                 (and kinds (matches it (first kinds)) (match more (rest kinds)))
                 (let ((op (first it)) (xs (rest it)))
                   (cond ((string-equal op "or") (some (lambda (x) (match (cons x more) kinds)) xs))
                         ((string-equal op "?") (or (match (cons (first xs) more) kinds) (match more kinds)))
                         ((string-equal op "*") (or (and kinds (match (list (first xs)) (list (first kinds)))
                                                         (match items (rest kinds)))
                                                    (match more kinds)))
                         ((string-equal op "+") (match (cons (first xs) (cons (list "*" (first xs)) more)) kinds))
                         (t nil))))))))

(defun names-in (items)   ; 項の並びに現れる名前の全部
  (loop for it in items append (if (stringp it) (list it) (names-in (rest it)))))

(defun show-items (items)
  (format nil "~{~a~^ ~}" (mapcar (lambda (it) (if (stringp it) (pretty it) (format nil "(~a ~a)" (pretty (first it)) (show-items (rest it))))) items)))
(defun show-key (key) (concatenate 'string ":" (pretty (symbol-name key))))

(defun attr-decls (attrs)   ; 属性の宣言を (個数 鍵 値) の並びにする。(* :key 値) は 0 個以上
  (let ((out '()) (rest attrs))
    (loop while rest do
      (let ((x (pop rest)))
        (if (consp x)
            (push (list (nm (first x)) (second x) (third x)) out)
            (push (list "1" x (pop rest)) out))))
    (nreverse out)))

(defun key-set (key)   ; 鍵が非終端の名前なら、その非終端が挙げる鍵の集まり。でなければその鍵 1 つ
  (let ((p (production (symbol-name key))))
    (if (and p (null (second p)) (= 1 (length (first p))) (op-p (first (first p)) "or"))
        (rest (first (first p)))
        (list (symbol-name key)))))

(defun check-value (name key v spec report)
  (cond ((consp spec)
         (unless (member (shown v) (mapcar #'shown (rest spec)) :test #'string=)
           (funcall report "~a: ~a: ~a must be one of ~{~a~^ ~}" *doc-id* (pretty name) (show-key key) (mapcar #'shown (rest spec)))))
        ((and (symbolp v) (string= (shown v) (shown spec))))   ; :kind code-block のような記号そのもの
        ((production (nm spec))
         (unless (matches (nm spec) (kind (nm v)))
           (funcall report "~a: ~a: ~a ~a is not a ~a" *doc-id* (pretty name) (show-key key) (pretty (nm v)) (pretty (nm spec)))))
        ((member (nm spec) '("文字列" "ファイル名") :test #'string=)
         (unless (stringp v) (funcall report "~a: ~a: ~a must be a string" *doc-id* (pretty name) (show-key key))))
        ((string= (nm spec) "必須"))
        (t (unless (string= (shown v) (shown spec))
             (funcall report "~a: ~a: ~a must be ~a" *doc-id* (pretty name) (show-key key) (shown spec))))))

(defun check-attrs (name attrs report)
  "宣言された属性 1 つごとに、その鍵が書かれた回数を個数と照らし、値の種類を照らす。
   宣言のどれにも当たらない鍵は、文法に無い属性として報告する。"
  (let ((decls (attr-decls attrs))
        (written (loop for (k v) on (second (rule name)) by #'cddr collect (cons k v))))
    (dolist (d decls)
      (destructuring-bind (n key spec) d
        (let* ((keys (key-set key))
               (hits (remove-if-not (lambda (kv) (member (symbol-name (car kv)) keys :test #'string=)) written))
               (c (length hits)))
          (cond ((string= n "1")
                 (cond ((zerop c) (funcall report "~a: ~a: no ~a" *doc-id* (pretty name) (show-key key)))
                       ((> c 1) (funcall report "~a: ~a: ~d ~a; just one is allowed" *doc-id* (pretty name) c (show-key key)))))
                ((string= n "+")
                 (when (zerop c) (funcall report "~a: ~a: no ~a; one or more are required" *doc-id* (pretty name) (show-key key))))
                ((string= n "?")
                 (when (> c 1) (funcall report "~a: ~a: ~d ~a; at most one is allowed" *doc-id* (pretty name) c (show-key key))))
                ((string= n "*")))
          (dolist (kv hits) (check-value name (car kv) (cdr kv) spec report)))))
    (let ((allowed (loop for d in decls append (key-set (second d)))))
      (dolist (kv written)
        (unless (member (symbol-name (car kv)) allowed :test #'string=)
          (funcall report "~a: ~a: ~a is not an attribute of ~a" *doc-id* (pretty name) (show-key (car kv)) (pretty (kind name))))))))

(defun check-rule (name report)
  (let* ((k (kind name)) (p (production k)))
    (cond ((string= k "文字列"))   ; 名前だけの終端（箇条書きの項目）。親の規則が item -> 文字列 で照合する
          ((null p) (funcall report "~a: ~a: ~a is not in the grammar" *doc-id* (pretty name) (pretty k)))
          (t (loop while (alias-p k) do (setf k (alias-p k)))   ; 既知 -> paragraph のような代用を辿る
             (let* ((p (production k)) (items (first p)) (attrs (second p))
                    (string-p (third (rule name)))   ; 右辺が文字列 1 つ
                    (kids (if (terminal-p name) '() (rhs name)))
                    ;; 文字列の塊は、文字列という種類の子 1 つを持つものとして照合する
                    (kinds (if string-p '("文字列") (mapcar #'kind kids)))
                    (shown-name (pretty (if (string= (label name) name) name (format nil "~a ~a" (label name) name))))
                    (string-rule (equal items '("文字列")))
                    (unexpanded (and (null kids) (not (terminal-p name)) (not (match items '())))))
               (cond ((and string-rule (not (terminal-p name)))
                      (funcall report "~a: ~a: not a terminal (~a -> 文字列)" *doc-id* shown-name (pretty k)))
                     (unexpanded
                      (funcall report "~a: ~a: not expanded (~a -> ~a)" *doc-id* shown-name (pretty k) (show-items items)))
                     ((not (match items kinds))
                      (let ((bad (and (not string-p)
                                      (find-if-not (lambda (x) (some (lambda (s) (matches s x)) (names-in items))) kinds))))
                        (if string-p
                            (funcall report "~a: ~a: a string where ~a -> ~a is expected" *doc-id* shown-name (pretty k) (show-items items))
                        (if bad
                            (funcall report "~a: ~a: ~a is not in the production (~a -> ~a)" *doc-id* shown-name
                                     (pretty (nth (position bad kinds) kids)) (pretty k) (show-items items))
                            (funcall report "~a: ~a: children (~{~a~^ ~}) do not match (~a -> ~a)" *doc-id* shown-name
                                     (mapcar #'pretty kinds) (pretty k) (show-items items)))))))
               (unless unexpanded (check-attrs name attrs report)))))))

(defun check-grammar (report)
  (dolist (name (reverse *order*))
    (let ((missing (and (not (terminal-p name))
                        (remove-if (lambda (k) (gethash k *rules*)) (rhs name)))))
      (if missing
          (funcall report "~a: ~a: no rule for ~{~a~^ ~} named in the right-hand side" *doc-id* (pretty name) (mapcar #'pretty missing))
          (check-rule name report)))))

(defparameter *fixed-headings* '(("アイディア" . "コアのアイディア") ("目標" . "到達する状態")))
(defparameter *unnumbered* '("項目" "コマンド" "対処"))   ; :heading を持つが番号を付けないラベル

(defun render ()
  "文書を markdown として標準出力に書く。違反があれば標準エラー出力に印字し、何も書かずに終了状態 1 で止まる。"
  (let* ((out (make-string-output-stream)) (n (check out)))
    (when (plusp n)
      (stderr (get-output-stream-string out))
      (stderr "render refused: fix the violations above first")
      (ext:quit :status 1)))
  (out "---") (out "id: " *doc-id*) (out "title: " (rhs "TITLE")) (out "description: |")
  (dolist (l (wrap (rhs "DESCRIPTION") 108)) (out "  " l)) (out "---") (out)
  (out "## Problem Definition") (out)
  (dolist (n (rhs "問題提起"))
    (cond ((string= n "前提条件と達成状態")
           (out "### 前提条件と達成状態") (out)
           (dolist (g (rhs n)) (out g) (out) (render-body (list g))))
          ((string= n "用語定義") (out "### " (attr n :heading)) (out) (render-body (rhs n)))
          (t (render-section n))))
  (out "## How to do it") (out)
  (let ((no 0))
    (dolist (n (rhs "HOW"))
      (let ((fixed (cdr (assoc (label n) *fixed-headings* :test #'string=))))   ; 番号の付かない見出し
        (cond (fixed (out "### " fixed))
              ((member (label n) *unnumbered* :test #'string=) (out "### " (attr n :heading)))
              (t (out (format nil "### ~d. " (incf no)) (attr n :heading)))))
      (out) (render-section n)))
  (when (rhs "UNDER-THE-HOOD")   ; 理由が 1 つも無ければ節ごと書かない
    (out "## Under the Hood") (out)
    (dolist (n (rhs "UNDER-THE-HOOD")) (out "### " (attr n :問い)) (out) (render-section n)))
  (when (rhs "REFERENCES")   ; 参照が 1 つも無ければ節ごと書かない
    (out "## 参考資料") (out) (out "<ul>")
    (dolist (n (rhs "REFERENCES"))
      (out "<li><span data-doc-id=\"" (attr-str n :doc) "\" data-relation=\"" (attr-str n :relation) "\">" (rhs n) "</span></li>"))
    (out "</ul>")))

;; ---- 1 回の起動で複数の文書を扱う ----
;; 規則は大域の表に入るので、文書 1 本ごとに表を空にする。
(defun reset ()
  (clrhash *rules*) (setf *order* '() *doc-id* nil *doc-attrs* nil *dir* nil)
  nil)

;; 規則ファイル 1 本を読み、検査して、markdown を書き出す。違反があれば書かずに違反の数を返す。
;; 文法は呼ぶ側が load-grammar で読んでおく。
(defun build (lisp-path md-path)
  (reset)
  (load lisp-path)
  (let* ((out (make-string-output-stream))
         (n (check out)))
    (if (plusp n)
        (progn (stderr (format nil "~a" lisp-path))
               (stderr (get-output-stream-string out))
               n)
        (with-open-file (s md-path :direction :output :if-exists :supersede
                                   :if-does-not-exist :create :external-format :utf-8)
          (let ((*standard-output* s)) (render))
          0))))
