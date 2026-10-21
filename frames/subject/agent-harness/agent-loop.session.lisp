;;; subject: agent-harness / claude-agent-sdk-agent-loop 7 Sessions and continuity: how a run is identified, resumed and branched, and how its transcript outlives a host
;;; made-from: doc_Base012/docs/Papers-AgentHarness/claude-agent-loop/claude-agent-loop.lisp / s-sessions
;;; members: p-session-id p-session-resume p-session-store
;;; children: none
;;; elsewhere: none
;;; left-out: none
(defrule session -> p-session-id p-session-resume p-session-store)
(defrule p-session-id -> :nucleus p-session-id/n :elaboration-additional p-session-id/where)
(defrule p-session-id/n -> :instruction "やり取りが何を作るか、後で再開するために何を控えるかを 1〜2 文で書く" :sample "Each interaction with the SDK creates or continues a session. Capture the session ID from ResultMessage.session_id (available in both SDKs) to resume later.")
(defrule p-session-id/where -> :instruction "実行の識別子が SDK ごとにどこにあるかの違いを 1 文で書く" :sample "The TypeScript SDK also exposes it as a direct field on the init SystemMessage; in Python it's nested in SystemMessage.data.")
(defrule p-session-resume -> :nucleus p-session-resume/n :elaboration-additional p-session-resume/fork)
(defrule p-session-resume/n -> :instruction "再開すると何が元に戻るかを 1 文で書く" :sample "When you resume, the full context from previous turns is restored: files that were read, analysis that was performed, and actions that were taken.")
(defrule p-session-resume/fork -> :instruction "元を変えずに別の方法を試す手段を 1 文で書く" :sample "You can also fork a session to branch into a different approach without modifying the original.")
(defrule p-session-store -> :nucleus p-session-store/n)
(defrule p-session-store/n -> :instruction "状態を持たない実行環境をまたいで再開するための仕組みを 1 文で書く" :sample "To resume sessions across stateless containers or serverless hosts, pass a session_store / sessionStore adapter so the SDK mirrors transcripts to your own backend and another host can resume.")
