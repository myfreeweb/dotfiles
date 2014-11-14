; This came from Greg V's dotfiles:
;      https://github.com/myfreeweb/dotfiles
; Feel free to steal it, but attribution is nice
;
; thanks:
; http://z.caudate.me/give-your-clojure-workflow-more-flow/

{:user {:signing {:gpg-key "greg@unrelenting.technology"}
        :dependencies [[leiningen #=(leiningen.core.main/leiningen-version)]
                       [org.clojure/tools.namespace "0.2.4"]
                       [im.chit/vinyasa "0.2.2"]
                       [im.chit/iroh "0.1.11"]
                       [io.aviso/pretty "0.1.12"]
                       [spyscope "0.1.5"]
                       [ritz/ritz-nrepl-middleware "0.7.0"]
                       [slamhound "1.5.5"]]
        :plugins [[lein-pprint "1.1.2"]
                  [lein-clojars "0.9.1"]
                  [lein-localrepo "0.5.3"]
                  [lein-sub "0.3.0"]
                  [lein-kibit "0.0.8"]
                  [lein-create-template "0.1.1"]
                  [lein-deps-tree "0.1.2"]
                  [lein-ritz "0.7.0"]
                  [lein-light-nrepl "0.1.0"]]
         :aliases {"slamhound" ["run" "-m" "slam.hound"]}}
         :injections [(require 'spyscope.core)
                      (require 'io.aviso.repl)
                      (require '[vinyasa.inject :as inject])
                      (inject/in
                        [vinyasa.inject :refer [inject [in inject-in]]]
                        [vinyasa.lein :exclude [*project*]]
                        [vinyasa.pull :all]
                        [cemerick.pomegranate add-classpath get-classpath resources]

                        clojure.core
                        [iroh.core .> .? .* .% .%>]

                        clojure.core >
                        [clojure.pprint pprint]
                        [clojure.java.shell sh])
                      ]
         :repl-options {:nrepl-middleware [lighttable.nrepl.handler/lighttable-ops
                                           io.aviso.nrepl/pretty-middleware
                                           ritz.nrepl.middleware.javadoc/wrap-javadoc
                                           ritz.nrepl.middleware.apropos/wrap-apropos]}}
