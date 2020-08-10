import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Util.Run
import XMonad.Layout.IndependentScreens

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]
myManageHook = manageDocks
myLayoutHook = avoidStruts (Full ||| tall ||| Mirror tall)
                   where  tall = Tall 1 (3/100) (1/2)
myHandleEventHook = docksEventHook

myConfig = defaultConfig
        { terminal = "urxvt",
          modMask = mod1Mask,
          manageHook = myManageHook,
          layoutHook = myLayoutHook,
          handleEventHook = myHandleEventHook,
          workspaces = withScreens 2 myWorkspaces
        }`additionalKeys` myKeys
        

myKeys = [
        ((mod1Mask, xK_p), spawn "dmenu_run -fn '-*-*-*-*-*-*-16-*-*-*-*-*-*-*'"),
        ((mod1Mask, xK_Escape), spawn "/home/axel/.xmonad/keyboardSwitch.sh"),
        ((mod1Mask, xK_Super_L), spawn "/home/axel/.xmonad/lockScreen.sh"),
        ((mod4Mask, xK_j), spawn "urxvt -e dbk"),
        ((mod1Mask, xK_b), sendMessage ToggleStruts),
        ((mod1Mask, xK_z), spawn "urxvt")
        ]++
        [((m .|. mod1Mask, k), windows $ onCurrentScreen f i) -- Replace 'mod1Mask' with your mod key of choice.
        | (i, k) <- zip myWorkspaces [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

main = do
    spawn "conky | dzen2 -ta r -p"
    xmonad myConfig
    xmonad =<< dzen myConfig
    
