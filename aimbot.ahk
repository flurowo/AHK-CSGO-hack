init:
#NoEnv
#SingleInstance, Force
#Persistent
#InstallKeybdHook
#UseHook
#KeyHistory, 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127
version = 1.1
traytip, csgo aimbot %version%, Running in background!, 5, 1
Menu, tray, NoStandard
Menu, tray, Tip, csgo aimbot %version%
Menu, tray, Add, csgo aimbot %version%, return
Menu, tray, Add
Menu, tray, Add, Help, info
Menu, tray, Add, Exit, exit
SetKeyDelay,-1, 1
SetControlDelay, -1
SetMouseDelay, -1
SetWinDelay,-1
SendMode, InputThenPlay
SetBatchLines,-1
ListLines, Off
CoordMode, Pixel, Screen, RGB
CoordMode, Mouse, Screen
PID := DllCall("GetCurrentProcessId")
Process, Priority, %PID%, High

EMCol := 0xC5C6C1,0xB4B2AB,0xAFAFA4 ; scanning for these specific pixels which are light coloured
ColVn := 65
AntiShakeX := (A_ScreenHeight // 100)
AntiShakeY := (A_ScreenHeight // 108)
ZeroX := (A_ScreenWidth // 2)
ZeroY := (A_ScreenHeight // 2)
CFovX := (A_ScreenWidth // 8) ; fov if u want to change it
CFovY := (A_ScreenHeight // 64) ; change if u have problems
ScanL := ZeroX - CFovX
ScanT := ZeroY
ScanR := ZeroX + CFovX
ScanB := ZeroY + CFovY
NearAimScanL := ZeroX - AntiShakeX
NearAimScanT := ZeroY - AntiShakeY
NearAimScanR := ZeroX + AntiShakeX
NearAimScanB := ZeroY + AntiShakeY

Loop, {
KeyWait, E, D ; the key to bind it u can change this!
PixelSearch, AimPixelX, AimPixelY, NearAimScanL, NearAimScanT, NearAimScanR, NearAimScanB, EMCol, ColVn, Fast RGB
if (!ErrorLevel=0) {
loop, 10 {
PixelSearch, AimPixelX, AimPixelY, ScanL, ScanT, ScanR, ScanB, EMCol, ColVn, Fast RGB
AimX := AimPixelX - ZeroX
AimY := AimPixelY - ZeroY
DirX := -1
DirY := -1
If ( AimX > 0 ) {
DirX := 1
}
If ( AimY > 0 ) {
DirY := 1
}
AimOffsetX := AimX * DirX
AimOffsetY := AimY * DirY
MoveX := Floor(( AimOffsetX ** ( 1 / 2 ))) * DirX
MoveY := Floor(( AimOffsetY ** ( 1 / 2 ))) * DirY
DllCall("mouse_event", uint, 1, int, MoveX * 1.5925, int, MoveY, uint, 0, int, 0) ; aim speed 1.5 or 1 is good 10 eh
}
}
}

Pause:: pause
return:
goto, init

info:
msgbox, 0, %version%, Made by fluro for CSGO`nIf you experience problems install autohotkey custom installation please.
return

exit:
exitapp