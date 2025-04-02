soundVolumeViewPath := "C:\Path\To\SoundVolumeView.exe" ; path to SoundVolumeView.exe
targetAppID := "DeltaForce" ; App name
unmuteAppID := "Microphone" ; mic
global gameMuted := false

; Set up timer to check process every 5 seconds
SetTimer, CheckProcess, 5000

F8::
    if (!gameMuted) {
        Run, %soundVolumeViewPath% /Mute "%targetAppID%" ; mutes game sound
        Sleep, 400
        Run, %soundVolumeViewPath% /Unmute "%unmuteAppID%" ; for some reason the mic is getting muted, this will unmute it
        gameMuted := true
    } else {
        Run, %soundVolumeViewPath% /Unmute "%targetAppID%" ; unmutes game sound
        gameMuted := false
    }
return

CheckProcess:
    Process, Exist, df_launcher.exe
    if (ErrorLevel = 0)  ; If process not found script will close
    {
        ExitApp
    }
return
