;;; one layer of the language-server stack: what it hands upward and what it handles
;;; members: agent tool layer, symbol retriever, server wrapper, solid language server (the sample is the server wrapper)
(defrule lsp-layer -> :nucleus lsp-layer/does)
(defrule lsp-layer/does -> :instruction "層の名前と、その層が受け持つことを 1 文で書く" :sample "The LSP Server Wrapper handles language detection (30+ file extensions; see Figure 18) and server lifecycle via a singleton pool: one server per language, started lazily, with automatic liveness checks and transparent restart on crash.")
