import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe, unsafeSpawn)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Actions.GridSelect
import System.IO
import XMonad.Prompt.Window(windowPromptGoto)
import XMonad.Prompt(defaultXPConfig)
import XMonad.Actions.SpawnOn

-- Imports for TwinView
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Hooks.SetWMName

-- startup :: X ()
-- startup =
--     spawn "kopete"
--     --setWMName "LG3D"
    


main = do
  xmproc <- spawnPipe "xmobar"
  trayerproc <- unsafeSpawn "trayer --edge top --align right --SetDockType true --SetPartialStrut true --transparent true --expand true --width 7 --tint 0x191970 --height 12 &"
  kopete <- unsafeSpawn "if [[ `pgrep -u aaron kopete` == '' ]] then; kopete; fi"
  nmApplet <- unsafeSpawn "cmst"
  pulseaudio <- unsafeSpawn "start-pulseaudio-kde"
  xmonad $ defaultConfig {
               manageHook = manageDocks <+> manageHook defaultConfig,
               layoutHook = avoidStruts $ layoutHook defaultConfig,
               logHook = dynamicLogWithPP $ xmobarPP
               {
                   ppOutput = hPutStrLn xmproc,
                   ppTitle = xmobarColor "green" "" .shorten 50
               },
               startupHook = setWMName "LG3D",
               -- startupHook = startup,
               modMask = mod4Mask,
               terminal = "konsole"
               
             }
    `additionalKeysP`
    [
      ("M-p", spawn "dmenu_run"),
      ("M-l", windowPromptGoto defaultXPConfig)
    ]


-- myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
-- myKeys conf@(XConfig {XMonad.modM
-- TwinView
-- myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
-- myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
--     [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
--     | (key, sc) <- zip [xK_e, xK_w] [0..],
--     (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
--        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command-lock")
--        ]
