# 🎚️ Mouse Wheel to Voicemeeter

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Stars](https://img.shields.io/github/stars/angeliust/TaskbarVolumeScrollForVB.svg?style=social)](https://github.com/angeliust/TaskbarVolumeScrollForVB/stargazers)

> Effortlessly control your Voicemeeter virtual input volumes using your mouse wheel over the Windows Taskbar!

---

## 🚀 Features

- Seamless integration with Voicemeeter (Standard, Banana, Potato)
- Auto-detects running Voicemeeter version and adapts controls
- Minimalist on-screen display (customizable)
- No installation required—just run and go!

## 📸 Screenshot

![App Screenshot](https://i.imgur.com/TVbvvDW.png)

## 📥 Quick Start

```sh
1. Download all files from this repository.
2. Run `Mouse Wheel to Voicemeeter.exe`.
3. Scroll your mouse wheel over the taskbar to control your audio!
```

## ⚙️ Customization

- **Change UI appearance:**  
  Edit these lines in the script:
  ```autohotkey
  Gui, OSD:Font, s10 Bold cFFFFFF, Segoe UI ; Change font size/color
  Gui, OSD:Show, % "x" mX - 30 . " y" mY - 160 . " NoActivate" ; Adjust position
  ```

## 🙏 Credits

- [VMR.ahk by SaifAqqad](https://github.com/SaifAqqad/VMR.ahk)
- [Taskbar detection by trismarck](https://www.autohotkey.com/board/topic/96139-detect-screen-edges-two-monitors/)
- Original script by Melo (melo@meloprofessional.com)
- Modifications & AI Assistance: Google AI Studio

---

## 📄 License

Licensed under the [MIT License](LICENSE).
