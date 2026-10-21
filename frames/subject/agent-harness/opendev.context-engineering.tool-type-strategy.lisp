;;; how the output of one kind of tool is shrunk: what is kept in the conversation and what can be read again later
;;; members: file reads, search results, directory listings, command execution, errors
(defrule tool-type-strategy -> :nucleus tool-type-strategy/kept)
(defrule tool-type-strategy/kept -> :instruction "道具の種類と、縮めた後に会話に残るものを書く" :sample "File reads are replaced with metadata: “ ✓ Read file (142 lines, 4,831 chars) ”. The full content remains available through re-reading, but the context carries only the proof that the read occurred and the file’s approximate size.")
