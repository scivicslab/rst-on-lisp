;;; one layer of the architecture: its central part and what it takes on, the kinds of that part, and what the kinds share
;;; members: Entry & UI, Agent, Tool & Context, Persistence (the sample is the Entry & UI layer, the fullest)
(defrule layer -> :nucleus layer/core :elaboration-set-member layer/variants :elaboration-object-attribute layer/shared)
(defrule layer/core -> :instruction "層の中心になる部品と、それが引き受けることを 1 文で書く" :sample "The CLI Entry Point parses arguments and bootstraps four shared managers (ConfigManager, SessionManager, ModeManager, and ApprovalManager), which are injected into all downstream components.")
(defrule layer/variants -> :instruction "その部品や画面に種類があれば、種類と違いを 1 文で書く。無ければ空にする" :sample "OpenDev supports two frontends: a TUI built on Textual using blocking modal approvals, and a Web UI backed by FastAPI and WebSockets using asynchronous polling approvals.")
(defrule layer/shared -> :instruction "種類が共通に満たす約束と、それで保たれることを 1 文で書く。無ければ空にする" :sample "Both implement a shared UICallback contract, keeping the agent layer UI-agnostic.")
