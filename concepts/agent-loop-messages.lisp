;;; Concept classes for the messages of an agent loop, written by hand from claude-agent-loop as a first trial
;;; (FrameMakingWorkflow_261022_oo01). A concept is a class; kind-of is a superclass; what can be said of a concept
;;; is a slot, whose documentation is the question a paragraph about the concept answers. A class says what its
;;; superclasses say, and what it adds.
(defpackage :concepts (:use :cl))
(in-package :concepts)

(defclass message ()
  ((when-delivered :documentation "When, and on what event, the program is handed this message")
   (kinds          :documentation "What kinds (subtypes) of it there are, and what each means")
   (carried-values :documentation "What values it carries, what each holds, and when each is present")
   (how-to-receive :documentation "How the program receives it and tells it apart from other messages")
   (cautions       :documentation "What to watch for when reading it"))
  (:documentation "Something the agent loop hands to the program that drives it"))

(defclass system-message (message) ()
  (:documentation "A message about the session itself, such as its start or a compaction"))
(defclass assistant-message (message) ()
  (:documentation "A message carrying what the model said or the tool calls it asked for"))
(defclass user-message (message) ()
  (:documentation "A message carrying what went back to the model, such as tool results"))
(defclass stream-event (message) ()
  (:documentation "A message carrying a piece of output while it is still being generated"))
(defclass result-message (message)
  ((how-it-ended :documentation "How the loop ended, and which value tells the endings apart"))
  (:documentation "The message that marks the end of the agent loop"))

(defun what-can-be-said (class-name)
  "Every slot of a concept, its own and the ones it inherits, as (slot-name class-it-comes-from question)."
  (let ((class (find-class class-name)))
    (mop:finalize-inheritance class)
    (loop for slot in (mop:class-slots class)
          for name = (mop:slot-definition-name slot)
          for from = (find-if (lambda (c) (find name (mop:class-direct-slots c) :key #'mop:slot-definition-name))
                              (mop:class-precedence-list class))
          collect (list name (class-name from) (documentation slot t)))))
