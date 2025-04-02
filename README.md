# AHK-GameAudioToggle

A lightweight AutoHotkey script that toggles in-game audio on and off—without affecting the microphone—using [SoundVolumeView](https://www.nirsoft.net/utils/soundvolumeview.html). The script automatically exits once the game process is no longer running.

--- 

## Features
- **Single-Key Toggle**: Press <kbd>F8</kbd> to mute or unmute the game audio.
- **Selective Audio Control**: Mutes the game’s audio session while ensuring the microphone remains unmuted.
- **Automatic Exit**: Checks for the game process every 5 seconds and exits automatically when the process is no longer found.
- **Customizable**: Easily update the target audio identifiers and game process name to suit your needs.

---

## Requirements
1. **[AutoHotkey](https://www.autohotkey.com/)**  
   Download and install AutoHotkey to run `.ahk` scripts.
2. **[SoundVolumeView](https://www.nirsoft.net/utils/soundvolumeview.html)**  
   Download and extract `SoundVolumeView.exe` to a known directory; update the path in the script accordingly.
3. **Your Game**  
   Know your game’s process name (e.g., `df_launcher.exe`) so the script can detect when the game is closed.

---

## Installation & Setup
1. **Clone or Download** this repository.
2. **Place `SoundVolumeView.exe`** in your preferred directory (or update the path in the script).
3. **Edit the Script**  
   Open the `.ahk` file and update:
   - `soundVolumeViewPath` with the full path to `SoundVolumeView.exe`.
   - `targetAppID` to the identifier for your game’s audio session (e.g., `"DeltaForce"`).
   - `unmuteAppID` to the identifier for your microphone (e.g., `"Microphone"`).
   - In the `CheckProcess` section, update `"df_launcher.exe"` to match your game’s process name if different.
4. **Test the Script**  
   Run the script using AutoHotkey. With your game running, press <kbd>F8</kbd> to toggle the game audio. The microphone should remain unmuted, and the script will exit automatically when the game is closed.

---

## Usage
1. **Run the Script**  
   Double-click the `.ahk` file or right-click → “Run Script.”
2. **Launch Your Game**  
   Once the game is running, press <kbd>F8</kbd> to toggle the game’s audio on/off.
3. **Automatic Exit**  
   When the game process (e.g., `df_launcher.exe`) is no longer found, the script exits within a few seconds.

---

## Example Script

```ahk
soundVolumeViewPath := "C:\Path\To\SoundVolumeView.exe"  ; Path to SoundVolumeView.exe
targetAppID := "DeltaForce"                              ; Identifier for game audio
unmuteAppID := "Microphone"                              ; Identifier for microphone
global gameMuted := false

; Set up timer to check process every 5 seconds
SetTimer, CheckProcess, 5000

F8::
    if (!gameMuted) {
        Run, %soundVolumeViewPath% /Mute "%targetAppID%"  ; Mute game sound
        Sleep, 400                                        ; Delay to ensure execution
        Run, %soundVolumeViewPath% /Unmute "%unmuteAppID%" ; Unmute microphone if affected
        gameMuted := true
    } else {
        Run, %soundVolumeViewPath% /Unmute "%targetAppID%" ; Unmute game sound
        gameMuted := false
    }
return

CheckProcess:
    Process, Exist, df_launcher.exe
    if (ErrorLevel = 0) {  ; If the game process is not found, exit the script
        ExitApp
    }
return
```

---

## Running the Script Automatically via Batch File

To have the script run automatically with the game, create a batch file (e.g., `GameName.bat`, `Delta Force.bat` ):

```batch
@echo off
rem Start the hotkey script
start "" ""C:\Path\To\script.ahk""
rem Launch the game and wait until it exits
start /wait "" "C:\Path\To\Delta Force.url" rem path to deltaforce launcher shortcut on desktop
rem Once the game closes, kill the hotkey script process
taskkill /IM AutoHotkey.exe /F
exit
```

This will allow you to open the game simply by running the .bat file.

**Consider the following steps:**

1. **Right-click** on the .bat file and select **Properties**.
2. Go to the **Shortcut** tab.
3. Click on **Advanced...** and check the **Run as administrator** option.
4. *Optional*: Copy and convert the Delta Force `icon-logo.png` file to ICO format.  
   For example, use the file located at:  
   `path\Steam\steamapps\common\Delta Force\Launcher\data\client_ui\deltaforce\icon-logo.png`  
   Then, click on **Change Icon...** and select the ICO version of the logo.
5. Click **OK** to apply the changes.

Now, your .bat file will look and act exactly as if you ran the game normally.

---

## Important Notes
- **Administrator Rights**:  
  If your game runs with elevated privileges, you may need to run the script or batch file as an Administrator.
- **Testing**:  
  Always test the script while your game is running and producing audio to ensure only the game’s audio is muted and the microphone remains active.
- **Customization**:  
  Adjust the process name in the `CheckProcess` section if your game uses a different executable name.

---

## License
This project is licensed under the [MIT License](LICENSE).

---

## Contributing
Contributions, bug reports, and feature requests are welcome! Feel free to fork this repository and submit a pull request.
