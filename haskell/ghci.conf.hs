-- This came from Greg V's dotfiles:
--      https://github.com/myfreeweb/dotfiles
-- Feel free to steal it, but attribution is nice
--
-- thanks:
--  http://redd.it/144biy

:set -XNoMonomorphismRestriction
:set +m

import qualified IPPrint
import qualified Language.Haskell.HsColour as HsColour
import qualified Language.Haskell.HsColour.Colourise as HsColour
import qualified Language.Haskell.HsColour.Output as HsColour

let myColourPrefs = HsColour.defaultColourPrefs { HsColour.conid = [HsColour.Foreground HsColour.Yellow, HsColour.Bold], HsColour.conop = [HsColour.Foreground HsColour.Yellow], HsColour.string = [HsColour.Foreground HsColour.Green], HsColour.char = [HsColour.Foreground HsColour.Cyan], HsColour.number = [HsColour.Foreground HsColour.Red, HsColour.Bold], HsColour.layout = [HsColour.Foreground HsColour.White], HsColour.keyglyph = [HsColour.Foreground HsColour.White] }

let myPrint = putStrLn . HsColour.hscolour (HsColour.TTYg HsColour.XTerm256Compatible) myColourPrefs False False "" False . IPPrint.pshow

:set -interactive-print=myPrint
:def! load \x -> return $ ":load " ++ x ++ "\n:set -interactive-print=myPrint"
:def! module \x -> return $ ":module " ++ x ++ "\n:set -interactive-print=myPrint"
:def! add \x -> return $ ":add " ++ x ++ "\n:set -interactive-print=myPrint"

:set prompt "\ESC[1;34m[ \ESC[1;32m%s \ESC[1;34m]\n\955\ESC[m "
-- :set prompt2 "|\ESC[m "
:set +t

:def hoogle \x -> return $ ":!hoogle \"" ++ x ++ "\""
:def doc \x -> return $ ":!hoogle --info \"" ++ x ++ "\""
:def source readFile
