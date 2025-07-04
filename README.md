# Mouse Wheel to Voicemeeter
To control Voicemeeter virtual inputs volumes from mouse wheel over Taskbar.

<a href="url"><img src="https://i.imgur.com/TVbvvDW.png" align="left" height="48" width="48" ></a>

This is an AutoHotKey script to control volume strips (virtual inputs) from Voicemeeter (https://vb-audio.com/Voicemeeter/) scrolling mouse wheel over Windows Taskbar.


Voicemeeter

The initial Voicemeeter version has one virtual inputs, then taskbar will have a single whole area from where you can scroll wheel mouse to control audio volume.
So you can control its volume from anywhere in taskbar.

Voicemeeter Banana

Since the second Voicemeeter version has two virtual inputs, you taskbar will have two areas (left and right) from where you can scroll wheel mouse to control audio volumes.
You can control the first virtual input volume from left side of taskbar, control the second virtual input volume from the right side of taskbar.


Voicemeeter Potato

Since the third Voicemeeter version has three virtual inputs, you taskbar will have three areas (left, center and right) from where you can scroll wheel mouse to control audio volumes.
You can control the first virtual input volume from left side of taskbar, control the second virtual input volume from the center of taskbar and control the third virtual input volume from the right side of taskbar.


It will automatically detect Voicemeeter version currently running and apply the number of areas accordingly.


How to use

Just download all files from this repository into the same folder (directory). No install needed. Run 'Mouse Wheel to Voicemeeter.exe' program. It will place a system tray icon from where you will have some usefull options.

### UI Position and Size

You can change the appearance and position of the percentage display by editing these two lines:

```autohotkey
; In the "MINIMALIST UI CREATION" section:
Gui, OSD:Font, s10 Bold cFFFFFF, Segoe UI ; Change s10 to a different size

; In the "ShowVolumeOSD" function:
Gui, OSD:Show, % "x" mX - 30 . " y" mY - 160 . " NoActivate" ; Change y -160 to adjust height


Credits to:

VMR AHK https://github.com/SaifAqqad/VMR.ahk

trismarck code from here: https://www.autohotkey.com/board/topic/96139-detect-screen-edges-two-monitors/

Voicemeeter by Vincent Burel

Credits and Acknowledgements
This project would not be possible without the foundational work of others in the community.
Original Author: This script is a direct fork and modification of "Mouse Wheel to Voicemeeter" by Melo (melo@meloprofessional.com).
Voicemeeter API Library: It relies entirely on the excellent VMR.ahk library created by SaifAqqad.
Taskbar Detection: The robust MouseIsOverTaskbar() function concept was adapted from a forum post by trismarck.
Modifications and AI Assistance: The extensive modifications, UI/UX changes, and iterative debugging to create this specific version were developed with the assistance of Google AI Studio.
License
This project is licensed under the MIT License - see the LICENSE file for details.
