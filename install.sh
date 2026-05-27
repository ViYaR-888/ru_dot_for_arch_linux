#!/bin/bash
set -euo pipefail # Exit immediately on error, uninitialized variable, or pipeline failure

# === Colors ===
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# === Determine the directory where the script resides ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# === Ensure we are running on an Arch-based system ===
if ! command -v pacman &>/dev/null; then
    echo -e "${RED}This script is intended for Arch Linux only.${NC}"
    exit 1
fi

# === Pre-check sudo privileges ===
if ! sudo -v; then
    echo -e "${RED}Sudo privileges are required for installation.${NC}"
    exit 1
fi

clear
echo -e "${PURPLE}╭──────────────────────────────────────────╮${NC}"
echo -e "${PURPLE}│           DOTFILES INSTALLATION          │${NC}"
echo -e "${PURPLE}╰──────────────────────────────────────────╯${NC}"
echo ""

# === 1. Base system packages and utilities ===
echo -e " ${BLUE}╭─${NC} Installing system utilities..."
sudo pacman -S --noconfirm --needed \
    git kitty zsh dunst swaybg rofi fastfetch imv loupe xdg-utils fzf ImageMagick
echo -e " ${BLUE}╰─${NC} ${GREEN}System utilities installed${NC}"

# === 2. Graphical environment, Display manager, and Libraries ===
echo -e "\n ${BLUE}╭─${NC} Installing Hyprland, SDDM-Qt6 and dependencies..."
sudo pacman -S --noconfirm --needed \
    hyprland uwsm sddm-qt6 \
    qt6-declarative qt6-svg qt6-5compat qt6-multimedia qt6-multimedia-ffmpeg \
    gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly
echo -e " ${BLUE}╰─${NC} ${GREEN}Graphics and SDDM-Qt6 environment ready${NC}"

# === 3. Fonts (fixes missing glyphs / squares in the panel) ===
echo -e "\n ${BLUE}╭─${NC} Installing required fonts..."
sudo pacman -S --noconfirm --needed \
    ttf-font-awesome otf-font-awesome ttf-nerd-fonts-symbols-common \
    ttf-jetbrains-mono-nerd ttf-dejavu
sudo fc-cache -fv > /dev/null
echo -e " ${BLUE}╰─${NC} ${GREEN}Fonts installed and cached${NC}"

# === 4. Force library cache update ===
# Ensures SDDM-Qt6 immediately sees the Qt5Compat module
sudo ldconfig

# === 5. AUR helper (yay) ===
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

# === 6. Waybar from git ===
echo -e "\n ${BLUE}╭─${NC} Compiling Waybar from git..."
yay -S --noconfirm waybar-git
echo -e " ${BLUE}╰─${NC} ${GREEN}Waybar-git installed${NC}"

# === 7. Copy configuration files ===
echo -e "\n ${BLUE}╭─${NC} Applying configurations..."
if [ ! -d "config" ] || [ ! -d "home" ]; then
    echo -e "${RED}Required folders 'config/' and/or 'home/' not found in $SCRIPT_DIR.${NC}"
    exit 1
fi

mkdir -p ~/.config ~/Pictures
cp -r config/* ~/.config/
cp -r home/Pictures/* ~/Pictures/ 2>/dev/null || true   # ignore if no pictures
cp home/.zshrc ~/

# Make any scripts executable
find ~/.config/hypr/ -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
find ~/.config/waybar/scripts/ -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
echo -e " ${BLUE}╰─${NC} ${GREEN}Configurations successfully moved${NC}"

# === 8. SDDM theme ===
echo -e "\n ${BLUE}╭─${NC} Setting up SDDM login theme..."
if [ -d "sddm/pixel-dusk-city" ]; then
    sudo mkdir -p /usr/share/sddm/themes/
    sudo cp -r sddm/pixel-dusk-city /usr/share/sddm/themes/
    sudo mkdir -p /etc/sddm.conf.d
    sudo tee /etc/sddm.conf.d/theme.conf > /dev/null << 'EOF'
[Theme]
Current=pixel-dusk-city
EOF
    # Enable SDDM service so it starts automatically
    sudo systemctl enable sddm.service
    echo -e " ${BLUE}╰─${NC} ${GREEN}SDDM theme activated and service enabled${NC}"
else
    echo -e " ${BLUE}╰─${NC} ${RED}SDDM theme folder not found, skipping${NC}"
fi

# === 9. Change default shell to Zsh ===
echo -e "\n ${BLUE}╭─${NC} Changing default shell..."
# Ensure zsh is listed in /etc/shells
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
