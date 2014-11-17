import XMonad
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import Data.Monoid
import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm .|. shiftMask, xK_Return), spawn "dmenu_run -fn 'Fira Mono-9'")
    , ((modm .|. shiftMask, xK_c     ), kill) -- close focused window
    , ((modm,               xK_space ), sendMessage NextLayout) -- Rotate through the available layout algorithms
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- Reset the layouts on the current workspace to default
    , ((modm,               xK_n     ), refresh) -- Resize viewed windows to the correct size
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
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
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- If you change layout bindings be sure to use 'mod-shift-space' after restarting
myLayout = avoidStruts $ smartBorders $ spacing 9 $ tiled ||| Mirror tiled ||| Full
  where tiled   = Tall nmaster delta ratio -- default tiling algorithm partitions the screen into two panes
        nmaster = 1 -- The default number of windows in the master pane
        ratio   = 1/2 -- Default proportion of screen occupied by master pane
        delta   = 3/100 -- Percent of screen to increment by when resizing panes

-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
-- To match on the WM_NAME, you can use 'title' in the same way that 'className' and 'resource' are used below.
myManageHook = composeAll
    [ className =? "Xmessage"       --> doFloat
    , className =? "Pinentry"       --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore ]

-- Event handling
myEventHook = mempty
myPP = xmobarPP { ppCurrent = xmobarColor "#282828" "#a1b56c"
                , ppTitle   = xmobarColor "#a16946" "" . shorten 128 }
myStartupHook = return ()
main = do
  barProc <- spawnPipe "/usr/local/bin/xmobar"
  xmonad defaultConfig {
    terminal           = "urxvt"
  , focusFollowsMouse  = True
  , clickJustFocuses   = False
  , borderWidth        = 3
  , modMask            = mod1Mask
  , workspaces         = ["1","2","3","4","5","6","7","8","9"]
  , normalBorderColor  = "#383838"
  , focusedBorderColor = "#585858"
  , keys               = myKeys
  , mouseBindings      = myMouseBindings
  , layoutHook         = myLayout
  , manageHook         = myManageHook
  , handleEventHook    = myEventHook
  , logHook            = dynamicLogWithPP $ myPP { ppOutput = hPutStrLn barProc }
  , startupHook        = myStartupHook
  }
