;;; Merges the rule files that book-terms writes, one per part of a book (01.lisp, 02.lisp, …),
;;; into one rst-on-lisp document: the term graph of the book.
;;;
;;; Each part's file holds rule pairs
;;;   (defrule term/<name> -> :nucleus term/<name>/text :<term-relation> term/<other> …)
;;;   (defrule term/<name>/text -> "<the sentence of the book that defines the term>")
;;; The same term may come in several parts. The merged document has one rule per name: a term's
;;; definition is the one of the first part that gave it, and its relations are those of every part,
;;; each pair once. The document is a book-document with one section per part, holding the terms
;;; that part was the first to give.
;;;
;;; usage: bin/merge-terms <dir> <document id> <title>   writes <dir>/terms.lisp

(defpackage :rst-terms (:use :common-lisp) (:export #:merge-terms))
(in-package :rst-terms)

(defpackage :rst-terms-data (:use))   ; the parts' symbols are read into this package, as data

(defun part-files (dir)
  (sort (remove-if-not (lambda (p) (every #'digit-char-p (pathname-name p)))
                       (mapcar #'namestring (directory (merge-pathnames "*.lisp" dir))))
        #'string<))

(defun part-title (path)   ; the first line is ";;; <the part's .md>"; its file name without .md
  (with-open-file (in path :external-format :utf-8)
    (let* ((line (or (read-line in nil) ""))
           (md (string-trim " ;" line))
           (slash (position #\/ md :from-end t))
           (name (if slash (subseq md (1+ slash)) md)))
      (if (and (> (length name) 3) (string= ".md" name :start2 (- (length name) 3)))
          (subseq name 0 (- (length name) 3))
          name))))

(defun read-forms (path)
  "The defrule forms of one part, read with their case kept. A part that cannot be read is
   reported and contributes nothing."
  (let ((*readtable* (copy-readtable nil))
        (*package* (find-package :rst-terms-data)))
    (setf (readtable-case *readtable*) :preserve)
    (handler-case
        (with-open-file (in path :external-format :utf-8)
          (loop for form = (read in nil :eof)
                until (eq form :eof)
                when (and (consp form) (symbolp (first form)) (string= (symbol-name (first form)) "defrule"))
                  collect form))
      (error (e)
        (format *error-output* "~a: not read: ~a~%" path e)
        '()))))

(defun name-of (form) (symbol-name (second form)))
(defun body-of (form) (cdddr form))   ; what follows (defrule name ->

(defun pairs (body)   ; (:key value …) as a list of (key . value), keys and values compared by name
  (loop for (k v) on body by #'cddr collect (cons k v)))

(defun same-pair-p (a b)
  (and (string= (symbol-name (car a)) (symbol-name (car b)))
       (equal (princ-to-string (cdr a)) (princ-to-string (cdr b)))))

(defun merge-terms (dir id title)
  (let ((rules (make-hash-table :test #'equal))   ; name -> body
        (order '())                                ; names in the order first given
        (first-part (make-hash-table :test #'equal))
        (titles '())
        (files (part-files dir)))
    (loop for path in files for i from 1
          do (push (part-title path) titles)
             (dolist (form (read-forms path))
               (let ((name (name-of form)) (body (body-of form)))
                 (multiple-value-bind (old seen) (gethash name rules)
                   (cond ((not seen)
                          (setf (gethash name rules) body (gethash name first-part) i)
                          (push name order))
                         ((and (consp body) (keywordp (first body)) (consp old) (keywordp (first old)))
                          ;; a term given again: add the relations it did not have
                          (dolist (p (pairs body))
                            (unless (or (string= (symbol-name (car p)) "nucleus")
                                        (find p (pairs old) :test #'same-pair-p))
                              (setf old (append old (list (car p) (cdr p))))))
                          (setf (gethash name rules) old)))))))
    (setf order (nreverse order) titles (nreverse titles))
    (let ((out (merge-pathnames "terms.lisp" dir))
          (*readtable* (copy-readtable nil))
          (*package* (find-package :rst-terms-data))
          (*print-right-margin* 100000)
          (sections '()))
      (setf (readtable-case *readtable*) :preserve)
      (with-open-file (s out :direction :output :if-exists :supersede :external-format :utf-8)
        (format s "(in-package :rst)~%(defdocument ~a)~%~%" id)
        (format s "(defrule document -> title sections)~%(defrule title -> ~s)~%" title)
        (loop for ptitle in titles for i from 1
              for heads = (remove-if-not (lambda (n) (and (= i (gethash n first-part))
                                                           (keywordp (first (gethash n rules)))
                                                           (string= "term/" n :end2 (min 5 (length n)))
                                                           (not (search "/text" n))))
                                         order)
              when heads do (push (cons (format nil "part~2,'0d" i) (cons ptitle heads)) sections))
        (setf sections (nreverse sections))
        (format s "(defrule sections ->~{ ~a~})~%" (mapcar #'car sections))
        (dolist (sec sections)
          (format s "~%;;; ~a~%(defrule ~a ->~{ ~a~} :heading ~s)~%"
                  (second sec) (car sec) (cddr sec) (concatenate 'string "## " (second sec)))
          (dolist (head (cddr sec))
            (dolist (n (list head (concatenate 'string head "/text")))
              (multiple-value-bind (body seen) (gethash n rules)
                (when seen
                  (format s "(defrule ~a ->~{ ~s~})~%" n body))))))
        (format t "~a: ~d terms in ~d sections from ~d parts~%" (namestring out)
                (reduce #'+ (mapcar (lambda (x) (length (cddr x))) sections)) (length sections) (length files))))))
