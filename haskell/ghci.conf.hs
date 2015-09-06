-- This came from Greg V's dotfiles:
--      https://github.com/myfreeweb/dotfiles
-- Feel free to steal it, but attribution is nice
--
-- thanks:
--  http://redd.it/144biy
--  http://www.mega-nerd.com/erikd/Blog/CodeHacking/Haskell/ghci-trick.html

:set -DGHC_INTERACTIVE
:set -XNoMonomorphismRestriction
:set -XOverloadedStrings
:set -XQuasiQuotes
:set +m

:set prompt "\ESC[1;34m[ \ESC[1;32m%s \ESC[1;34m]\n\955\ESC[m "
-- :set prompt2 "|\ESC[m "
:set +t

:def hoogle \x -> return $ ":!hoogle \"" ++ x ++ "\""
:def doc \x -> return $ ":!hoogle --info \"" ++ x ++ "\""
:def source readFile

-- cabal install ghci-pretty
:def cp (\_ -> return "import IPPrint.Colored\n:set -interactive-print=IPPrint.Colored.cpprint")
:def ncp (\_ -> return ":set -interactive-print=print")
