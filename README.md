# Taskbar Volume Scroll for Voicemeeter Banana

A minimalist AutoHotkey script to control Voicemeeter Banana's virtual input volumes by scrolling the mouse wheel over the Windows taskbar. It provides a clean, text-only OSD (On-Screen Display) to show the current volume percentage.

This project is a fork of the original "Mouse Wheel to Voicemeeter" script, modified to provide a more modern and minimalist user experience.


*(Feel free to replace this with your own screenshot)*

## Features

*   **Minimalist UI:** A clean, floating text display shows only the volume percentage.
*   **Taskbar Zones:** Your taskbar is divided into zones, allowing you to control different Voicemeeter virtual inputs based on your mouse's horizontal position.
*   **Adjustable Sensitivity:** Customize the "slow" and "fast" scroll speeds to fit your preference.
*   **Lightweight:** The script is optimized for low resource usage and instant responsiveness.
*   **Plug and Play:** Simply run the script alongside Voicemeeter.

## Requirements

1.  **Voicemeeter Banana** (or Potato) installed and running.
2.  **AutoHotkey v1.1** installed. You can download it from the [official AutoHotkey website](https://www.autohotkey.com/).
3.  The **`VMR.ahk` library** by SaifAqqad. This is included in this repository for convenience.

## Installation

1.  Click the green **`< > Code`** button on this repository's main page and select **`Download ZIP`**.
2.  Extract the ZIP file to a permanent location on your computer (e.g., `C:\Scripts\VoicemeeterScroll`).
3.  Ensure that `Taskbar-Volume-Scroll.ahk` (or whatever you name the main script) and `VMR.ahk` are in the **same folder**.
4.  Run Voicemeeter Banana.
5.  Run the script by double-clicking `Taskbar-Volume-Scroll.ahk`. A new "H" icon will appear in your system tray.

To have the script run automatically when your computer starts, right-click the tray icon and select **"Start on Boot"**.

## Usage

1.  Move your mouse cursor over your main or secondary Windows taskbar.
2.  Scroll the mouse wheel up or down.
3.  The volume for the corresponding virtual input will change, and a small percentage indicator will appear above your cursor.

### Fader Zones

The script divides your taskbar's width into equal zones based on how many virtual inputs your version of Voicemeeter has.

*   **For Voicemeeter Banana:**
    *   The left half of the taskbar controls **Virtual Input 1**.
    *   The right half of the taskbar controls **Virtual Input 2**.
*   **For Voicemeeter Potato:** The taskbar is divided into thirds for the three virtual inputs.

## Customization

You can easily edit the script to change its behavior. Right-click the `.ahk` file and select "Edit Script".

### Scroll Sensitivity

To make the volume change faster or slower, adjust the `gainsteps` values at the top of the script. The values are in decibels (dB).

```autohotkey
; Slow steps for changing volume (in dB). Increased for more "sensibility".
gainsteps1 := 3.0

; Fast steps for changing volume (in dB).
gainsteps2 := 5.0
