;;; one stage of the pipeline that keeps the playbook current: what it reads, what it decides, and what it emits
;;; members: select bullets, reflect, curate, apply and save
(defrule playbook-stage -> :nucleus playbook-stage/does)
(defrule playbook-stage/does -> :instruction "段階の名前と、その段階が受け取るもの、決めること、出すものを書く" :sample "In Stage 1, the BulletSelector ranks every bullet by a weighted score combining effectiveness (0.5), recency decay (0.3), and semantic similarity to the current query via cosine similarity over cached embeddings (0.2); the top-ranked bullets are injected into the Generator’s system prompt so the agent can act on prior experience.")
