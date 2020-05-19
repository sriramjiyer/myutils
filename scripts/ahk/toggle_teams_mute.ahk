;;
;; This script will register a global hotkey that will 
;;
;;  1. Activate Microsoft Teams window if required
;;  2. Send SHIFT CONTROL M keystroke to Microsoft Teams window
;;  3. Send ALT TAB to switch back to your orginal window if teams was not active window to start with
;;
;;  Default hotkey is Media play/pause button. To choose a different button pass it as first parameter to script/exe
;;
;;  Example: Using F12 as hot key
;;
;;  autohotkey toggle_teams.mute.exe F12
;;
;;  To stop script find icon - Green icon with a H - on the windows task bar notification area, right click on it and choose exit.
;;
;;  Create an exe using ahk2exe
;;
;;    ahk2exe.exe /in .\toggle_teams_mute.ahk
;;
;;  Prerequisite : autohotkey is required to run this script, which can be installed using scoop
;;
;;    scoop install autohotkey
;;
;;  Alternatively a standalone compiled version of the script toggle_teams_mute.exe is available in same repository
;;

myHotKey = Media_Play_Pause
if A_Args.Length() > 0
{
  myHotKey = %1%
}
Hotkey, %myHotKey%, MyTeamsMuteToggle
return

MyTeamsMuteToggle:
IfWinActive, ahk_exe Teams.exe
{
  Send, ^+M
  return
}
IfWinExist, ahk_exe Teams.exe
{
  WinActivate
  Send, ^+M
  Send, !{TAB}
  return
}
else
{
  MsgBox, Teams NOT running
}
return
