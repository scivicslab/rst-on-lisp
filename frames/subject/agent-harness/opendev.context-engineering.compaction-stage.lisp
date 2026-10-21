;;; one stage of the compaction pipeline: its name and trigger level, what it does to the conversation, and what it keeps
;;; members: Stage 1 Warning, Stage 2 Observation Masking, Stage 2.5 Fast Pruning, Stage 3 Aggressive Masking, Stage 4 Full Compaction
(defrule compaction-stage -> :nucleus compaction-stage/n)
(defrule compaction-stage/n -> :instruction "段階の名前と作動する圧力の割合、その段階で会話に行うこと、残すものを書く" :sample "Stage 2 - Observation Masking (80%): Older tool result messages are replaced in-place with compact reference pointers (e.g., [output offloaded to scratch file]), preserving the conversation structure required by the LLM API while reducing token footprint from thousands of tokens to approximately 15 per observation. The most recent tool outputs are preserved at full fidelity.")
