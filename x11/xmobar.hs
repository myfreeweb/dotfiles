Config { font = "xft:Fira Mono:size=9:antialias=true"
       , borderColor = "black"
       , border = TopB
       , bgColor = "#282828"
       , fgColor = "#e8e8e8"
       , position = Top
       , lowerOnStart = True
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run StdinReader
                    , Run Com "uname" ["-s","-r"] "" 36000
                    , Run Kbd [("us(colemak)", "EN"), ("ru", "RU")]
                    , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %StdinReader% }{ <fc=#dc9656>%kbd%</fc> <fc=#a1b56c>%date%</fc> <fc=#ab4642>%uname%</fc>"
       }
