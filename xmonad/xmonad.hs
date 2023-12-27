--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit
import System.IO
import XMonad.Util.SpawnOnce
import XMonad.Actions.SpawnOn
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.EwmhDesktops
import XMonad.ManageHook
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Reflect
import XMonad.Layout.Spacing
import XMonad.Actions.WindowGo

import XMonad.Hooks.DynamicLog

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Data.List
import Data.Char

include :: String -> String -> Bool
include xs ys = or . map (isPrefixOf ys) . tails $ xs

data Cond a = a :? a

infixl 0 ?
infixl 1 :?

(?) :: Bool -> Cond a -> a
True  ? (x :? _) = x
False ? (_ :? y) = y

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "sakura"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    :: [String]
myWorkspaces    = map show [1..9]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#e6744c"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawnHere "dmenu_run -nb \\#070C19 -sb \\#233875")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawnHere "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm .|. shiftMask, xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "killall xmobar && xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
	
	-- Lock screen
	, ((modm .|. shiftMask, xK_l ), spawn "mate-screensaver-command -l")

	-- Open caja
	, ((modm, xK_f), spawn "caja")

	-- Open default browser
	, ((modm, xK_b), runOrRaise "x-www-browser" (stringProperty "WM_WINDOW_ROLE" =? "browser"))

	-- Open discord
	, ((modm, xK_d), runOrRaise "discord" (resource =? "discord"))

    -- Open VK messenger
    , ((modm, xK_v), runOrRaise "vk-messenger" (className =? "VK Messenger"))

    -- Open Telegram
    , ((modm, xK_t), runOrRaise "telegram-desktop" (className =? "TelegramDesktop"))

	-- Open IDEA
	, ((modm, xK_i), spawn "idea")

    -- Toggle FullScreen
    , ((modm .|. shiftMask, xK_b), sequence_ [sendMessage ToggleStruts, toggleScreenSpacingEnabled, toggleWindowSpacingEnabled])
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
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

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts (reflectHoriz $ smartBorders tiled {-||| Mirror tiled-} ||| smartBorders Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 2/3

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className                         =? "MPlayer"                                --> doFloat
    , className                         =? "Gimp"                                   --> doFloat
    , resource                          =? "desktop_window"                         --> doIgnore
    , resource                          =? "kdesktop"                               --> doIgnore
	, title                             =? "Список друзей" >> className =? "Steam"  --> doFloat
    , className                         =? "discord"                                --> doShift "2"
    , className                         =? "VK Messenger"                           --> doShift "2"
    , stringProperty "WM_WINDOW_ROLE"   =? "browser"                                --> doShift "1"
    , className                         =? "TelegramDesktop"                        --> doShift "2"
	-- , isFullscreen                                                                  --> doFullFloat
	]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = handleEventHook def <+> fullscreenEventHook

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    spawn "~/.dotfiles/xmonad/scripts/trayer.sh &"
    spawn "~/.dotfiles/xmonad/scripts/restartable.sh &"
    spawnOnce "setxkbmap -model pc105 -layout us,ru -option -option grp:caps_toggle -option compose:ralt"
    spawnOnce "xautolock -time 15 -locker \"mate-screensaver-command -l\" -detectsleep &"
    setWMName "LG3D" -- Used for Java Swing Apps

---------
-- xmobar settings
--


myTitleColor     = "#eeeeee"  -- color of window title
myTitleLength    = 60         -- truncate window title to this length
myCurrentWSColor = "#e6744c"  -- color of active workspace
myVisibleWSColor = "#c185a7"  -- color of inactive workspace
myUrgentWSColor  = "#cc0000"  -- color of workspace with 'urgent' window
myCurrentWSLeft  = "["        -- wrap active workspace with these
myCurrentWSRight = "]"
myVisibleWSLeft  = "("        -- wrap inactive workspace with these
myVisibleWSRight = ")"
myUrgentWSLeft  = "{"         -- wrap urgent workspace with these
myUrgentWSRight = "}"
myFullIcon = "\60340"
myTallIcon = "\60341"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP {
    -- ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"
    ppTitle = xmobarColor myTitleColor "" . shorten myTitleLength
    , ppCurrent = xmobarColor myCurrentWSColor ""
       . wrap myCurrentWSLeft myCurrentWSRight
    , ppVisible = xmobarColor myVisibleWSColor ""
       . wrap myVisibleWSLeft myVisibleWSRight
    , ppUrgent = xmobarColor myUrgentWSColor ""
       . wrap myUrgentWSLeft myUrgentWSRight
    , ppLayout = \(l) -> (l `include` "Full" ? myFullIcon :? myTallIcon)
    , ppOrder = \(ws:l:t:_) -> [ws,l,t]
    , ppHidden = \(wid) -> []
    , ppHiddenNoWindows = \(wid) -> []
}

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar -x 0 ~/.xmonad/xmobarrc"
    xmonad $ docks $ ewmh defaults {
        logHook = dynamicLogWithPP $ myPP {
            ppOutput = System.IO.hPutStrLn xmproc
        }
    }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = {--myLogHook $--} dynamicLogWithPP $ myPP,
        startupHook        = myStartupHook
    } `additionalKeys` [
        ((0, 0x1008FF11), spawn "amixer -q -D pulse set Master 5%- unmute") -- minus 5% to volume and unmute
        , ((0, 0x1008FF13), spawn "amixer -q -D pulse set Master 5%+ unmute") -- plus 5% to volume and unmute
        , ((0, 0x1008FF12), spawn "amixer -q -D pulse set Master toggle") -- toggle mute
        , ((0, 0xff61), spawn "flameshot screen -c") -- make screenshot and copy to clipboard
        , ((0 .|. shiftMask, 0xff61), spawn "flameshot gui") -- make screenshot by GUI
        , ((0, 0x1008FF02), spawn "brightnessctl -d \"radeon_bl0\" set 5%+") -- plus 5% to brightness
        , ((0, 0x1008FF03), spawn "brightnessctl -d \"radeon_bl0\" set 5%-") -- minus 5% from brightness        	
    ]

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The modifier key is 'super'. Keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
	"mod-f            Launch Caja file manager",
	"mod-b            Launch or focus default browser",
    "mod-v            Launch or focus VK Messenger",
	"mod-d            Launch or focus Discord",
    "mod-t            Launch or focus Telegram",
	"mod-i            Launch IDEA",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-Shift-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
