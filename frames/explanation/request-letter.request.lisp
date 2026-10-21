;;; one request of a request letter: what the requester has made ready, who does what where, the command or the
;;; settings in a form the receiver can copy, what to do along with it and what that is for, the conditions on it
;;; each with its reason, and where the steps are
;;; members: p-run p-run/code p-token (request 1, Vault), p-routes p-routes/list p-rules (request 2, HAProxy)
;;; the reasons are not gathered in a section of their own: each condition carries its reason in the same item
(defrule request -> request/act request/code request/list request/also request/conditions request/steps :heading "## お願い: {item}")
;; who does what where, after what the requester has made ready (p-run p-routes)
(defrule request/act -> :background request/act/ready :nucleus request/act/n)
(defrule request/act/ready -> :instruction "頼む側がすでに用意したもの（スクリプト、ファイル）と、その置き場所を 1 文で書く。用意したものが無ければ書かない"
  :sample "<計算機> のアカウント <作業アカウント> のホームに、スクリプト ~/setup-vault.sh を置いてあります。")
(defrule request/act/n -> :instruction "誰が（どの権限を持つ人が）、どの機械やシステムで、何をするかを、宛先を主語にして「〜してください」の形で 1 文で書く。下にコマンドや設定を示すなら「次のように」「次の」で指す"
  :sample "管理者権限の Vault トークンをお持ちの方が、<計算機> にログインして、次のように実行してください。 / https://sc.ddbj.nig.ac.jp/ を受け付ける HAProxy に、許可した送信元からの次の経路を足してください。")
;; the command or the settings, in a form the receiver can copy (p-run/code p-routes/list)
(defrule request/code -> :instruction "宛先が実行するコマンドを、そのまま写せる形で示す。コマンドが無ければ空にする" :kind code-block)
(defrule request/list -> :instruction "宛先が足す設定（経路、値）を、1 項目に 1 つ、そのまま写せる形で挙げる。何のための設定かを括弧で添える。足す設定が無ければ空にする"
  :sample "/pups-with-audit-auth → ワーカーノードの NodePort 31091（ログイン画面） / /pups-with-audit → ワーカーノードの NodePort 31090（サービス本体）"
  :kind bullet)
;; what to do along with it, what that is for, and what happens to it afterwards (p-token)
(defrule request/also -> :nucleus request/also/n :purpose request/also/for :elaboration-additional request/also/after)
(defrule request/also/n -> :instruction "このお願いと一緒にしてほしいことがあれば、「あわせて、〜してください」の形で 1 文で書く。置き場所や権限など、宛先が迷う値を含める。無ければ段落ごと書かない"
  :sample "あわせて、ポリシー k8s-pups-with-audit-admin（k8s-pups-with-audit/ の下の読み書きのみ）を持つトークンを 1 つ発行し、<計算機> の <作業アカウント> のホームの ~/.vault-token（権限 600）に置いてください。")
(defrule request/also/for -> :instruction "それが何に使われるかを 1 文で書く" :sample "ログイン画面の設定（Keycloak の realm とクライアントシークレットの登録）に使い、")
(defrule request/also/after -> :instruction "使い終わった後にそれをどうするか（誰が削除する、返す）を 1 文で書く。そのまま残すなら書かない" :sample "終わったら削除します。")
;; the conditions on the request, each with its reason in the same item (p-rules)
(defrule request/conditions -> :instruction "このお願いに付ける条件（判定の順序、拒むときの応答、許す範囲、時間、外してほしい古い設定）を、1 項目に 1 つ、「〜してください」の形で挙げる。理由がある条件は、同じ項目に「〜ため」か括弧で理由を添える。条件が無ければ空にする"
  :sample "/pups-with-audit-auth を先に判定してください（/pups-with-audit にも一致するため）。 / 許可していない送信元には、この2つのパスだけ 403 を返してください。 / ツールの画面は WebSocket を使うため、接続が 1 時間以上切れないようにしてください。 / 以前の /pups（NodePort 31087）の経路は不要なので、外してください。"
  :kind bullet)
;; where the steps are (the "(手順は添付)" of p-token)
(defrule request/steps -> :nucleus request/steps/n :rank secondary)
(defrule request/steps/n -> :instruction "このお願いの手順を添付の文書に分けたなら、それを指す短い文を書く。無ければ段落ごと書かない" :sample "（手順は添付）")
