Config { font = "xft:ChicagoFLF:size=9,Font Awesome:size=11:antialias=false,DejaVu Sans Mono:size=9"
       , borderColor = "#464b50"
       , border = TopB
       , bgColor = "#1e1e1e"
       , fgColor = "#e8e8e8"
       , position = Top
       , lowerOnStart = True
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run StdinReader
                    , Run Kbd [("us(colemak)", "EN"), ("ru", "RU")]
                    , Run Date "%a %b %_d %Y %H:%M" "date" 10
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %StdinReader% }{  <fc=#f9ee98> %kbd%</fc>  <fc=#afc4db> %date%</fc>"
       }
