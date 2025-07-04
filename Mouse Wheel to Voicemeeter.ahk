; Mouse Wheel to Voicemeeter
; version 1.6.2 (UI Tweak Edition)
; by Melo (melo@meloprofessional.com) & AI Assistant
; 
; Credits to:
; VMR AHK https://github.com/SaifAqqad/VMR.ahk
; dvingerh for the robust MouseIsOverTaskbar function https://github.com/dvingerh/tb-vol-scroll

; --- VOICEMEETER CONSTANTS ---
global MIN_GAIN := -60.0
global MAX_GAIN := 12.0

MacroButtonMuteUnmuteVirtualInput:=[]
; --- CUSTOMIZATION START ---
; Your macro button ID for mute / unmute 1st virtual input, if any
MacroButtonMuteUnmuteVirtualInput[1] :=

; Your macro button ID for mute / unmute 2nd virtual input, if any
MacroButtonMuteUnmuteVirtualInput[2] :=

; Your macro button ID for mute / unmute 3rd virtual input, if any
MacroButtonMuteUnmuteVirtualInput[3] :=

; Slow steps for changing volume (in dB). Increased for more "sensibility".
gainsteps1 := 3.0

; Fast steps for changing volume (in dB).
gainsteps2 := 5.0
; --- CUSTOMIZATION END ---

SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#MaxThreadsPerHotkey 200
;OPTIMIZATIONS
#NoEnv
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input

Appname := "Mouse Wheel to Voicemeeter"
Version := 1.6.2
global Appname, Version, voicemeeter

Coordmode, Mouse, Screen
SM_CMONITORS := 80
SysGet, monCount, % SM_CMONITORS
Loop, % monCount
    SysGet, mon%A_Index%, Monitor, %A_Index%
Menu, Tray, Icon, %A_ScriptDir%\mwvm.ico
Menu, Tray, Tip , WAITING VOICEMEETER...
Menu, Tray, NoStandard
Menu, Tray, deleteall
Menu, Tray, Add, Waiting for Voicemeeter start, opener
Menu, Tray, Default, 1&
Menu, Tray, Click, 1
Menu, Tray, Rename, 1&
Menu, Tray, Add, --- Waiting Voicemeeter --- , opener
Menu, Tray, Disable, --- Waiting Voicemeeter ---
Menu, Tray, Add, Voicemeeter , Voice_Meeter
Menu, Tray, Disable, Voicemeeter
Menu, Tray, Add, Restart Audio Engine , Voice_Meeter_Restart
Menu, Tray, Disable, Restart Audio Engine
Menu, Tray, Add, Macro Buttons , Macro_Buttons
Menu, Tray, Disable, Macro Buttons
Menu, Tray, Add
Menu, Tray, Add, Control Panel Sounds , Sounds
Menu, Tray, Add, Windows Volume Mixer , Volume_Mixer
Menu, Tray, Add
Menu, Tray, Add, Start on Boot, BootMenu
If (CheckStartOnBoot())
    Menu, Tray, Check, Start on Boot
else
    Menu, Tray, Uncheck, Start on Boot
Menu, Tray, Add, Restart , Restart
Menu, Tray, Add, About, About
Menu, Tray, Add, Exit, Exit
Menu, Tray, Click, 1

; --- MINIMALIST UI CREATION ---
Gui, OSD:New, +LastFound +AlwaysOnTop -Caption +ToolWindow +E0x08000000
Gui, OSD:Color, 000000  ; A solid color that we will make transparent
Gui, OSD:Font, s10 Bold cFFFFFF, Segoe UI ; <<< CHANGE: Font size is now ~3x smaller
Gui, OSD:Add, Text, vVolumeText w60 Center, 100`% ; <<< CHANGE: Width adjusted for smaller text
WinSet, TransColor, 000000, ahk_id %OSD_hwnd% ; Makes the black background invisible
; --- END UI CREATION ---

Loop
{
    try {
        #Include %A_ScriptDir%\VMR.ahk
        break
    }
    catch
        sleep 1000
}

Menu, Tray, Tip , %Appname%
Menu, Tray, Delete, --- Waiting Voicemeeter ---
Menu, Tray, Enable, Voicemeeter
Menu, Tray, Enable, Restart Audio Engine
Menu, Tray, Enable, Macro Buttons

voicemeeter := new VMR().login()
vm_type := voicemeeter.getType()
;vm_type := 3

Fader := []
Switch vm_type {
    case 1: Fader[1]:= 3
    case 2: Fader[1]:= 4, Fader[2]:= 5
    case 3: Fader[1]:= 6, Fader[2]:= 7, Fader[3]:= 8
}
Total_Faders := 0
for i, v in Fader
   Total_Faders++
Return

;--- TRAY MENU FUNCTIONS ---
opener:
    Menu, Tray, Show
return
CheckStartOnBoot(){
RegRead, StartupReg, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run, %Appname%
return StartupReg
}
Sounds:
runwait control mmsys.cpl sounds
Return
Volume_Mixer:
runwait sndvol.exe
Return
Voice_Meeter:
voicemeeter.command.show(1)
return
Voice_Meeter_Restart:
voicemeeter.command.restart()
return
Macro_Buttons:
voicemeeter.macroButton.show(1)
return
BootMenu:
If (CheckStartOnBoot()){
    RegDelete, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run, %Appname%
    Menu, Tray, Uncheck, Start on Boot
}else{
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run, %Appname%, %A_AhkPath%
    Menu, Tray, Check, Start on Boot
}
Return
Restart:
Reload
Return
About:
MsgBox ,,%Appname%,Mouse Wheel to Voicemeeter`nversion %Version%`n`nTo control Voicemeeter virtual inputs volumes from mouse wheel over Taskbar.`n`n`n`nBy Melo`nmelo@meloprofessional.com`n© Melo. All rights reserved.
return
Exit:
ExitApp
Return

; =================================================================================
; HOTKEY SECTION
; =================================================================================
#if MouseIsOverTaskbar()
WheelUp::ChangeVolume("up")
WheelDown::ChangeVolume("down")
#If

; =================================================================================
; CORE LOGIC & UI FUNCTIONS
; =================================================================================

MouseIsOverTaskbar() {
    MouseGetPos,,, Win
    WinGetClass, Class, ahk_id %Win%
    return (Class = "Shell_TrayWnd" || Class = "Shell_SecondaryTrayWnd")
}

ChangeVolume(direction) {
    global gainsteps1, gainsteps2, monCount, Total_Faders, Fader, MacroButtonMuteUnmuteVirtualInput, voicemeeter
    
    If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 80)
        gainsteps := gainsteps2
    else
        gainsteps := gainsteps1

    MouseGetPos, x
    Loop, % monCount {
        i := A_Index
        if ( x >= mon%i%Left ) && ( x <= mon%i%Right )
            break
    }
    width := (mon%i%Right - mon%i%Left) / Total_Faders
    Loop, % Total_Faders {
        portion := A_Index
        if ( x < (mon%i%Left + (width * portion)) )
            break
    }
    
    stripnum := Fader[portion]
    if !IsObject(voicemeeter.strip[stripnum])
        return

    currentGain := voicemeeter.strip[stripnum].gain

    if (direction = "up") {
        if (voicemeeter.strip[stripnum].mute)
            voicemeeter.strip[stripnum].mute := 0
        if(voicemeeter.macroButton.getStatus(MacroButtonMuteUnmuteVirtualInput[portion]))
            voicemeeter.macroButton.setStatus(MacroButtonMuteUnmuteVirtualInput[portion],1,0)
        newGain := currentGain + gainsteps
    } else {
        newGain := currentGain - gainsteps
    }

    newGain := Min(Max(newGain, MIN_GAIN), MAX_GAIN)
    voicemeeter.strip[stripnum].gain := newGain
    
    ShowVolumeOSD(newGain)
}

ShowVolumeOSD(finalGain) {
    global OSD_hwnd
    
    percent := Round(((finalGain - MIN_GAIN) / (MAX_GAIN - MIN_GAIN)) * 100)
    
    GuiControl, OSD:, VolumeText, %percent%`%
    
    MouseGetPos, mX, mY
    ; <<< CHANGES: Centered for smaller text (x - 30) and positioned higher (y - 160)
    Gui, OSD:Show, % "x" mX - 30 . " y" mY - 160 . " NoActivate"
    
    SetTimer, HideOSD, -1200 ; Hide the OSD after 1.2 seconds of inactivity
}

HideOSD:
    Gui, OSD:Hide
Return