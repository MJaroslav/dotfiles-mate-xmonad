--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
{-# OPTIONS_GHC -Wno-deprecations #-} -- Don't give a fuck.

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
import XMonad.Actions.CopyWindow
import XMonad.Actions.TagWindows
import XMonad.Prompt.ConfirmPrompt
import XMonad.Hooks.RefocusLast -- (refocusLastLayoutHook, refocusLastWhen, isFloat)
import XMonad.Layout.TrackFloating
import XMonad.Layout.Spiral

import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Data.List
import Data.Char

import Colors

include :: String -> String -> Bool
include xs ys = (any (isPrefixOf ys) . tails) xs

data Cond a = a :? a

infixl 0 ?
infixl 1 :?

(?) :: Bool -> Cond a -> a
True  ? (x :? _) = x
False ? (_ :? y) = y

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "kitty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 3

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
myNormalBorderColor  = color2
myFocusedBorderColor = color1

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawnHere "rofi -show combi -modes combi -combi-modes \"drun,run\"")

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
    , ((modm .|. shiftMask, xK_q     ), confirmPrompt def "exit" $ io exitSuccess)

    -- Restart xmonad
    , ((modm              , xK_q     ), confirmPrompt def "restart" $ spawn "xmonad --recompile && xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn "gxmessage -title \"XMonad help\" -center -fn \"JetBrainsMono Nerd Font\" -file ~/.dotfiles/xmonad/help.txt")

        -- Lock screen
        , ((modm .|. shiftMask, xK_l ), spawn "mate-screensaver-command -l")

        -- Open caja
        , ((modm, xK_f), spawn "caja")

        -- Open default browser
        , ((modm, xK_b), runOrRaise "x-www-browser" (stringProperty "WM_WINDOW_ROLE" =? "browser"))

        -- Open discord
        , ((modm, xK_d), runOrRaise "discord" (resource =? "discord"))

        -- Open vanilla discord
        , ((modm .|. shiftMask, xK_d), raiseMaybe (spawn "discord --vanilla") (resource =? "discord"))

        , ((modm, xK_period), spawn "emoji-picker")

    -- Open VK messenger
    , ((modm, xK_v), runOrRaise "vk-messenger" (className =? "VK Messenger"))

    -- Open Telegram
    , ((modm, xK_t), runOrRaise "telegram-desktop" (className =? "TelegramDesktop"))

        -- Open IDEA
        , ((modm, xK_i), spawn "idea")

    -- Toggle FullScreen
    , ((modm .|. shiftMask, xK_b), sequence_ [spawn "polybar-msg cmd toggle", toggleScreenSpacingEnabled, toggleWindowSpacingEnabled])
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)

    -- you may also bind events to the mouse scroll wheel (button4 and button5)

    -- swap focus by mod + scroll
    , ((modm, button4), \w -> windows W.focusDown)
    , ((modm, button5), \w -> windows W.focusUp)

    -- resize master by mod + scroll
    , ((modm .|. shiftMask, button4), \w -> sendMessage Expand)
    , ((modm .|. shiftMask, button5), \w -> sendMessage Shrink)
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
myLayout = refocusLastLayoutHook . trackFloating $ avoidStruts (reflectHoriz $ smartBorders tiled ||| smartBorders Full ||| spiral (4/3))
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 2 / 3

     -- Percent of screen to increment by when resizing panes
     delta   = 2 / 100

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
    , className                         =? "Gxmessage"                              --> doFloat
    , className                         =? "scrcpy"                                 --> doFloat <+> doF copyToAll
    , className                         =? "Key-mon"                                --> doFloat <+> doF copyToAll
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
myEventHook = mconcat
    [
        refocusLastWhen (refocusingIsActive <||> isFloat),
        handleEventHook def <+> fullscreenEventHook
    ]

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    spawn "~/.xmonad/scripts/restartable.sh &"
    spawnOnce "setxkbmap -model pc105 -layout us,ru -option -option grp:caps_toggle -option compose:ralt"
    -- spawnOnce "xautolock -time 15 -locker \"mate-screensaver-command -l\" -detectsleep &"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main :: IO ()
main = do
    spawnPipe "~/.dotfiles/polybar/polybar.sh"
    xmonad $ docks . ewmhFullscreen . ewmh $ defaults

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
        layoutHook         = smartSpacingWithEdge 2 $ myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook
    } `additionalKeys` [
        ((0, xF86XK_AudioLowerVolume), spawn "amixer -q -D pulse set Master 5%- unmute") -- minus 5% to volume and unmute
        , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q -D pulse set Master 5%+ unmute") -- plus 5% to volume and unmute
        , ((0, xF86XK_AudioMute), spawn "amixer -q -D pulse set Master toggle") -- toggle mute
        , ((0, xK_Print), spawn "flameshot screen -c && update-last-screenshot") -- make screenshot and copy to clipboard
        , ((0 .|. shiftMask, xK_Print), spawn "flameshot gui && update-last-screenshot") -- make screenshot by GUI
        , ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl -d \"radeon_bl0\" set 5%+") -- plus 5% to brightness
        , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl -d \"radeon_bl0\" set 5%-") -- minus 5% from brightness        	
    ]
