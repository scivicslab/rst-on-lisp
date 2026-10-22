;;; how the output of one kind of tool is shrunk before it enters the conversation: what is kept and what can be read again
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule output-strategy -> :nucleus output-strategy/kept)
(defrule output-strategy/kept -> :instruction "道具の種類と、縮めた後に会話に残るものを書く" :sample "File reads are replaced with metadata: “ ✓ Read file (142 lines, 4,831 chars) ”. The full content remains available through re-reading, but the context carries only the proof that the read occurred and the file’s approximate size.")
