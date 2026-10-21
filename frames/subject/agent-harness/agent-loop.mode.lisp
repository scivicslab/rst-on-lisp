;;; one permission mode: its name, what it does with tool calls that need approval, and the use it suits
;;; members: "default", "acceptEdits", "plan", "dontAsk", "auto", "bypassPermissions"
(defrule mode -> :nucleus mode/n :elaboration-additional mode/exceptions :purpose mode/use)
(defrule mode/n -> :instruction "モードの名前と、承認が要る呼び出しをこのモードがどう扱うかを書く" :sample "Auto-approves file edits and common filesystem commands (mkdir, touch, mv, cp, etc.); other Bash commands follow default rules")
(defrule mode/exceptions -> :instruction "このモードでも承認を飛ばさない、または拒否する呼び出しと、使えない条件があれば 1〜2 文で書く。無ければ空にする" :sample "In the TypeScript SDK, also requires allowDangerouslySkipPermissions: true in options. Can't be used when running as root on Unix")
(defrule mode/use -> :instruction "このモードが向く使い方を書く" :sample "You trust Claude's edits and want faster iteration")
