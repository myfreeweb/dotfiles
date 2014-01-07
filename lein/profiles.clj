; This came from Greg V's dotfiles:
;      https://github.com/myfreeweb/dotfiles
; Feel free to steal it, but attribution is nice
;
; thanks:
; http://z.caudate.me/give-your-clojure-workflow-more-flow/

{:user {:dependencies [[leiningen "2.1.2"]
                       [org.clojure/tools.namespace "0.2.4"]
                       [im.chit/vinyasa "0.1.7"]
                       [io.aviso/pretty "0.1.8"]
                       [spyscope "0.1.4"]
                       [ritz/ritz-nrepl-middleware "0.7.0"]
                       [slamhound "1.5.0"]]
        :plugins [[lein-pprint "1.1.1"]
                  [lein-clojars "0.9.1"]
                  [lein-localrepo "0.5.3"]
                  [lein-sub "0.3.0"]
                  [lein-kibit "0.0.8"]
                  [lein-create-template "0.1.1"]
                  [lein-deps-tree "0.1.2"]
                  [lein-ritz "0.7.0"]
                  [lein-light-nrepl "0.0.9"]]
         :aliases {"slamhound" ["run" "-m" "slam.hound"]}}
         :injections [(require 'spyscope.core)
                      (require 'vinyasa.inject)
                      (vinyasa.inject/inject 'clojure.core
                        '[[vinyasa.inject [inject inject]]
                          [vinyasa.pull [pull pull]]
                          [vinyasa.lein [lein lein]]
                          [clojure.repl apropos dir doc find-doc source [root-cause cause]]
                          [clojure.tools.namespace.repl [refresh refresh]]
                          [clojure.pprint [pprint >pprint]]
                          [io.aviso.binary [write-binary >bin]]])
                      (require 'io.aviso.repl
                               'clojure.repl
                               'clojure.main)
                      (alter-var-root #'clojure.main/repl-caught
                        (constantly @#'io.aviso.repl/pretty-pst))
                      (alter-var-root #'clojure.repl/pst
                        (constantly @#'io.aviso.repl/pretty-pst))]
         :repl-options {:nrepl-middleware [lighttable.nrepl.handler/lighttable-ops
                                           ritz.nrepl.middleware.javadoc/wrap-javadoc
                                           ritz.nrepl.middleware.apropos/wrap-apropos]}}
