# My rice ──❯ YOUR RICE!

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white" alt="Arch Linux">
  <img src="https://img.shields.io/badge/Hyprland-58E1FF?style=for-the-badge&logo=hyprland&logoColor=black" alt="Hyprland">
  <img src="https://img.shields.io/badge/Catppuccin-Mocha-EE99A0?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0iI0VFOTlBMCIgZD0iTTEyIDJDNi40NyAyIDIgNi40NyAyIDEyczQuNDcgMTAgMTAgMTAgMTAtNC40NyAxMC0xMFMxNy41MyAyIDEyIDJ6Ii8+PC9zdmc+" alt="Catppuccin">
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" alt="MIT License">
</p>

Hi. These are my dotfiles for Arch Linux, as I'm incredibly lazy and too lazy to set it all up again. If you like them, feel free to use them!


## Screenshots


| Real Hardware (Host) | Virtual Machine (VMware/VirtualBox) |
|---|---|
| ![Real Hardware](./screenshots/base.png) | ![Virtual Machine](./screenshots/vm.png) |


## For the lazy (Quick Start):

> [!WARNING]
>
> Before you run the installation script, open `install.sh` and read it in full.  
> The script applies changes with little user interaction:
> - It installs packages from official repositories and the AUR **without asking for confirmation** (`--noconfirm`).
> - It alters system files (SDDM configuration, user groups, etc.).
> - It is designed for a **clean Arch Linux installation** and is **not idempotent** — interrupting it or running it more than once may leave your system in an inconsistent state.
>
> **What you should modify before execution if you want control:**
> - Remove the `--noconfirm` flag from every `pacman` and `yay` command so you can review each package.
> - Review the package lists and delete anything you do not intend to install.
> - Verify the AUR helper installation method and adapt it to your preferences.
> - Make sure you understand every step. Do not trust the script blindly.

```bash
git clone https://github.com/ViYaR-888/ru_dot_for_arch_linux.git
cd ru_dot_for_arch_linux
./install.sh
```

That's it. The script will automatically install and configure everything for you.

##  What's inside:
* **WM:** Hyprland (Smooth & Fast)
* **Status Bar:** Waybar (Catppuccin Mocha)
* **Terminal:** Kitty + Zsh (with Fish-like autosuggestions)
* **Display Manager:** SDDM (Pixel Dusk City theme)
* **Application Launcher:** Rofi
* **Notifications:** Dunst



## How to control windows?

If you don't understand how to manage all of this without a mouse, or if you want to grasp my philosophy of movement, then definitely read **[MyTailing for Dummies](./MyTailing%20for%20Dummies.md)** — it's exactly what you need!

If something doesn't feel right — you can always tweak `~/.config/hypr/hyprland.conf`!



## Testing on a Virtual Machine? Read this!

If you are trying out this rice inside a VM (like VMware or VirtualBox), you will probably run into two annoying issues: a crashing terminal and keys not working. Here is how to fix them in 2 minutes:

### 1. Terminal instantly closes? (Kitty ──> Foot)
`kitty` uses your GPU for hardware acceleration. VM graphics drivers hate this, so Kitty will just crash on startup. 
* **The Fix:** Switch to `foot`, a super lightweight terminal that doesn't care about GPU acceleration.
* Open `~/.config/hypr/hyprland.conf` and change the terminal variable to:

  ```ini
  $terminal = foot
  ```

### 2. Can't open the terminal? (Host Key Conflict)
Your main OS (the host) loves to steal the **`Super` (Win)** key. Because of this, combos like `Super + Q` won't reach the VM.
* **The Fix:** Tell your VM to lock your mouse and keyboard fully. In VMware, just click inside the window or press `Ctrl + G`. In VirtualBox, use your `Host Key` (Right Ctrl) to capture input.
* If it still doesn't work, just temporarily change the bind inside `hyprland.conf` to something like:
  
  ```ini
  bind = $mainMod, Q, exec, $terminal
  ```



## Troubleshooting: Missing Wi-Fi or Bluetooth icons?

If your top bar looks clean but the system tray on the right is completely empty, don't panic! The fonts are fine. The apps are just sleeping. 

Since this is a fresh Arch install, you need to manually enable and autostart the network and bluetooth background services:

1. **Wake up the system services** (run this in your terminal):
   
   ```bash
   sudo systemctl enable --now NetworkManager
   sudo systemctl enable --now bluetooth
   ```

2. **Add them to Hyprland's autostart**:
   Open `~/.config/hypr/hyprland.conf` and add these two lines at the bottom so they launch every time you log in:
   
   ```ini
   exec-once = nm-applet --indicator
   exec-once = blueman-applet
   ```

Reboot your system, and the neat little tray icons will pop right up!



## Huge Thanks / Credits

This rice wouldn't exist without the amazing open-source community. Huge thanks to everyone who made this possible:

* **Linus Torvalds & The Linux Community** — For creating the best kernel and ecosystem on the planet.
* **The Arch Linux Team** — For keeping it lightweight, simple, and bleeding-edge. (BTW, I use Arch!)
* **Hyprland Team (vaxry & contributors)** — For building the most beautiful, smooth, and modern Wayland compositor out there.
* **The Catppuccin Team** — For the gorgeous, soothing Mocha color palette that saves our eyes.
* **The Creators of "Pixel Dusk City" Theme** — For making the incredibly stylized pixel-art SDDM login screen.
* **The Open Source Devs** — Everyone behind Waybar, Rofi, Kitty, Dunst, and all the tiny CLI tools we use every single day. 

----

> **And remember ── it's Linux, you can do anything here!** 


## 📜 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


#btwiusearch
