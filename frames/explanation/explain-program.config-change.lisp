;;; one configuration change: what it makes happen, the file and the machine, the setting itself, and the value for a single machine
;;; from: implementation.config-change.lisp
(defrule config-change -> :background config-change/default :nucleus config-change/n :elaboration-process-step config-change/where
                          :example config-change/code :elaboration-additional config-change/single)
(defrule config-change/default -> :instruction "変える前にどうなっていて、なぜそのままでは困るかを 1〜2 文で書く。既定の値を変えるのでなければ書かない"
  :sample "By default, the broker's index will collect new data from the seller's index every 10 minutes. Although this is generally a good refresh interval, in our case we will need to shorten it.")
(defrule config-change/n -> :instruction "この設定で何を成り立たせるか（何をどこに登録する、どの値をいくつにする、どのアドレスを渡す）を 1 文で書く"
  :sample "On the seller's machine, you will need to register the local index with the broker's VO index.")
(defrule config-change/where -> :instruction "どの機械のどのファイルに、何を足すか書き換えるかを 1 文で書く"
  :sample "To do this, you must add the following to the file $GLOBUS_LOCATION/etc/globus_wsrf_mds_index/hierarchy.xml:")
(defrule config-change/code -> :instruction "足すか書き換えた後の設定の部分を示す。書き換える行にはその旨の注記を付ける" :kind code-block)
(defrule config-change/single -> :instruction "機械 1 台で動かすときに値をどう変えるかを 1 文で書く。変わらなければ書かない"
  :sample "If you are using a one-machine setup, the hostname and port should be 127.0.0.1:8443")
