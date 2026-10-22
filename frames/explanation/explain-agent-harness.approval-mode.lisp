;;; one posture that decides what the harness asks the user before acting: its name, how it treats a call that needs approval, and the use it suits
;;; links: links/explanation/explain-agent-harness.tsv (which rule of each integrated frame each rule here was made from)
(defrule approval-mode -> :nucleus approval-mode/treats :elaboration-additional approval-mode/exceptions :purpose approval-mode/use)
(defrule approval-mode/treats -> :instruction "姿勢の名前と、承認が要る呼び出しをその姿勢がどう扱うかを書く" :sample "Auto-approves file edits and common filesystem commands (mkdir, touch, mv, cp, etc.); other Bash commands follow default rules")
(defrule approval-mode/exceptions -> :instruction "その姿勢でも承認を飛ばさない、または拒否する呼び出しと、使えない条件があれば書く。無ければ空にする" :sample "In the TypeScript SDK, also requires allowDangerouslySkipPermissions: true in options. Can't be used when running as root on Unix")
(defrule approval-mode/use -> :instruction "その姿勢が向く使い方を書く" :sample "You trust Claude's edits and want faster iteration")
