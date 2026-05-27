#!/bin/bash
set -euo pipefail

# === Colors ===
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# === Determine script location ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# === Arch Linux check ===
if ! command -v pacman &>/dev/null; then
    echo -e "${RED}This script is intended for Arch Linux only.${NC}"
    exit 1
fi

# === Sudo check ===
if ! sudo -v; then
    echo -e "${RED}Sudo privileges are required for installation.${NC}"
    exit 1
fi

clear
echo -e "${PURPLE}╭──────────────────────────────────────────╮${NC}"
echo -e "${PURPLE}│           DOTFILES INSTALLATION          │${NC}"
echo -e "${PURPLE}╰──────────────────────────────────────────╯${NC}"
echo ""

# === 1. Base system utilities ===
echo -e " ${BLUE}╭─${NC} Installing system utilities..."
sudo pacman -S --noconfirm --needed \
    git kitty zsh dunst swaybg rofi fastfetch imv loupe xdg-utils fzf ImageMagick \
    thunar polkit-gnome network-manager-applet blueman \
    wl-clipboard cliphist grim slurp libnotify brightnessctl
echo -e " ${BLUE}╰─${NC} ${GREEN}System utilities installed${NC}"

# === 2. Hyprland, SDDM, graphical libraries ===
echo -e "\n ${BLUE}╭─${NC} Installing Hyprland, SDDM-Qt6 and dependencies..."
sudo pacman -S --noconfirm --needed \
    hyprland uwsm sddm-qt6 \
    qt6-declarative qt6-svg qt6-5compat qt6-multimedia qt6-multimedia-ffmpeg \
    gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly \
    qt5ct kvantum
echo -e " ${BLUE}╰─${NC} ${GREEN}Graphics and SDDM-Qt6 environment ready${NC}"

# === 3. Fonts ===
echo -e "\n ${BLUE}╭─${NC} Installing required fonts..."
sudo pacman -S --noconfirm --needed \
    ttf-font-awesome otf-font-awesome ttf-nerd-fonts-symbols-common \
    ttf-jetbrains-mono-nerd ttf-dejavu
sudo fc-cache -fv > /dev/null
echo -e " ${BLUE}╰─${NC} ${GREEN}Fonts installed and cached${NC}"

# === 4. Themes and icons ===
echo -e "\n ${BLUE}╭─${NC} Installing themes and icons..."
sudo pacman -S --noconfirm --needed \
    catppuccin-gtk-theme-mocha papirus-icon-theme
echo -e " ${BLUE}╰─${NC} ${GREEN}Themes and icons ready${NC}"

# === 5. Zsh plugins ===
echo -e "\n ${BLUE}╭─${NC} Installing Zsh plugins..."
sudo pacman -S --noconfirm --needed \
    zsh-autosuggestions zsh-syntax-highlighting
echo -e " ${BLUE}╰─${NC} ${GREEN}Zsh plugins installed${NC}"

# === 6. Force library cache update ===
sudo ldconfig

# === 7. AUR helper (yay) ===
echo -e "\n ${BLUE}╭─${NC} Setting up AUR helper (yay)..."
if ! command -v yay &>/dev/null; then
    sudo pacman -S --noconfirm --needed base-devel
    TMPDIR=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$TMPDIR/yay"
    cd "$TMPDIR/yay"
    makepkg -si --noconfirm
    cd "$SCRIPT_DIR"
    rm -rf "$TMPDIR"
fi
echo -e " ${BLUE}╰─${NC} ${GREEN}AUR helper is ready${NC}"

# === 8. Waybar from git ===
echo -e "\n ${BLUE}╭─${NC} Compiling Waybar from git..."
yay -S --noconfirm waybar-git
echo -e " ${BLUE}╰─${NC} ${GREEN}Waybar-git installed${NC}"

# === 9. Copy configuration files ===
echo -e "\n ${BLUE}╭─${NC} Applying configurations..."
if [ ! -d "config" ] || [ ! -d "home" ]; then
    echo -e "${RED}Required folders 'config/' and/or 'home/' not found in $SCRIPT_DIR.${NC}"
    exit 1
fi

mkdir -p ~/.config ~/Pictures
cp -r config/* ~/.config/
cp -r home/Pictures/* ~/Pictures/ 2>/dev/null || true
cp home/.zshrc ~/

# Make scripts executable
find ~/.config/hypr/ -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
find ~/.config/waybar/scripts/ -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
echo -e " ${BLUE}╰─${NC} ${GREEN}Configurations successfully moved${NC}"

# === 10. SDDM theme ===
echo -e "\n ${BLUE}╭─${NC} Setting up SDDM login theme..."
if [ -d "sddm/pixel-dusk-city" ]; then
    sudo mkdir -p /usr/share/sddm/themes/
    sudo cp -r sddm/pixel-dusk-city /usr/share/sddm/themes/
    sudo mkdir -p /etc/sddm.conf.d
    sudo tee /etc/sddm.conf.d/theme.conf > /dev/null << 'THEMEEOF'
[Theme]
Current=pixel-dusk-city
THEMEEOF
    sudo systemctl enable sddm.service
    echo -e " ${BLUE}╰─${NC} ${GREEN}SDDM theme activated and service enabled${NC}"
else
    echo -e " ${BLUE}╰─${NC} ${RED}SDDM theme folder not found, skipping${NC}"
fi

# === 11. Change default shell to Zsh ===
echo -e "\n ${BLUE}╭─${NC} Changing default shell..."
if ! grep -Fxq "/usr/bin/zsh" /etc/shells; then
    echo "/usr/bin/zsh" | sudo tee -a /etc/shells > /dev/null
fi

CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "zsh" ]; then
    sudo chsh -s /usr/bin/zsh "$USER"
    echo -e " ${BLUE}╰─${NC} ${GREEN}Default shell changed to Zsh${NC}"
else
    echo -e " ${BLUE}╰─${NC} Zsh is already the default shell"
fi

echo -e "\n${PURPLE} And remember ── it's Linux, you can do anything here! ${NC}\n"
echo -e "${GREEN} INSTALLATION COMPLETE! Please reboot your system. ${NC}\n"
