import XMonad
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Roledex
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Accordion
import Data.Monoid
import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm .|. shiftMask, xK_Return), spawn "dmenu_run -fn 'ChicagoFLF-9' -sb '#8F9D6A' -sf '#282828' -p '$'")
    , ((modm .|. shiftMask, xK_c     ), kill) -- close focused window
    , ((modm,               xK_space ), sendMessage NextLayout) -- Rotate through the available layout algorithms
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- Reset the layouts on the current workspace to default
    , ((modm,               xK_n     ), refresh) -- Resize viewed windows to the correct size
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_k     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_j     ), windows W.swapUp    )
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink) -- Push window back into tiling
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    ]

-- If you change layout bindings be sure to use 'mod-shift-space' after restarting
myLayout = avoidStruts $ smartBorders $ smartSpacing 8 $ layouts
  where layouts  = three ||| tall ||| Mirror tall ||| Accordion ||| Roledex
        three    = ThreeColMid 1 resize (3/7)
        tall     = Tall 1 resize (1/2)
        resize   = 3/100

-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
-- To match on the WM_NAME, you can use 'title' in the same way that 'className' and 'resource' are used below.
myManageHook = composeAll
    [ className =? "Xmessage"       --> doFloat
    , className =? "Pinentry"       --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "stalonetray"    --> doIgnore
    , title     =? "gromit-mpx"     --> doIgnore
    , resource  =? "desktop_window" --> doIgnore ]

-- Event handling
myEventHook = mempty
myPP = xmobarPP { ppCurrent = xmobarColor "#282828" "#8f9d6a"
                , ppUrgent  = xmobarColor "#282828" "#cf6a4c"
                , ppTitle   = xmobarColor "#a16946" "" . shorten 128
                , ppSep     = "  "
                , ppLayout  = \x -> ""}
myStartupHook = return ()
main = do
  barProc <- spawnPipe "~/bin/xmobar"
  xmonad $ withUrgencyHook NoUrgencyHook
         $ defaultConfig {
    focusFollowsMouse  = False -- Kinda disrupts the keyboard control thing...
  , clickJustFocuses   = False
  , borderWidth        = 3
  , modMask            = mod1Mask
  , workspaces         = map (\x -> [' ', x, ' ']) ['α'..'ω']
  , normalBorderColor  = "#383838"
  , focusedBorderColor = "#585858"
  , keys               = myKeys
  , mouseBindings      = myMouseBindings
  , layoutHook         = myLayout
  , manageHook         = myManageHook
  , handleEventHook    = myEventHook
  , logHook            = dynamicLogWithPP $ myPP { ppOutput = hPutStrLn barProc }
  , startupHook        = myStartupHook }
