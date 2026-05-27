#!/bin/bash

PURPLE='\033[0;35m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

clear
echo -e "${PURPLE}╭──────────────────────────────────────────╮${NC}"
echo -e "${PURPLE}│           DOTFILES INSTALLATION          │${NC}"
echo -e "${PURPLE}╰──────────────────────────────────────────╯${NC}"
echo ""

# 1. Install base packages via pacman
echo -e " ${BLUE}╭─${NC} Installing system packages..."
sudo pacman -S --noconfirm --needed \
    git kitty zsh dunst swaybg rofi fastfetch imv loupe xdg-utils \
    qt6-declarative qt6-svg qt6-5compat qt6-multimedia qt6-multimedia-ffmpeg \
    gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly fzf ImageMagick
echo -e " ${BLUE}╰─${NC} ${GREEN}System packages installed${NC}"

# 2. Install AUR helper (yay)
echo -e "\n ${BLUE}╭─${NC} Setting up AUR helper (yay)..."
if ! command -v yay &> /dev/null; then
    sudo pacman -S --noconfirm --needed base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
fi
echo -e " ${BLUE}╰─${NC} ${GREEN}AUR helper is ready${NC}"

# 3. Install actual git version of Waybar from AUR
echo -e "\n ${BLUE}╭─${NC} Compiling Waybar from git..."
yay -S --noconfirm waybar-git
echo -e " ${BLUE}╰─${NC} ${GREEN}Waybar-git installed${NC}"

# 4. Copy configuration files
echo -e "\n ${BLUE}╭─${NC} Applying configurations..."
mkdir -p ~/.config ~/Pictures
cp -r config/* ~/.config/
cp -r home/Pictures/* ~/Pictures/
cp home/.zshrc ~/

# Set executable permissions for local scripts
chmod +x ~/.config/hypr/*.sh 2>/dev/null
chmod +x ~/.config/waybar/scripts/*.sh 2>/dev/null
echo -e " ${BLUE}╰─${NC} ${GREEN}Configurations successfully moved${NC}"

# 5. Install SDDM theme
echo -e "\n ${BLUE}╭─${NC} Setting up SDDM login theme..."
sudo mkdir -p /usr/share/sddm/themes/
sudo cp -r sddm/pixel-dusk-city /usr/share/sddm/themes/

# Enable the theme in system configuration
sudo mkdir -p /etc/sddm.conf.d
sudo bash -c 'cat << SEC > /etc/sddm.conf.d/theme.conf
[Theme]
Current=pixel-dusk-city
SEC'
echo -e " ${BLUE}╰─${NC} ${GREEN}SDDM theme activated${NC}"

# 6. Change default shell to Zsh
echo -e "\n ${BLUE}╭─${NC} Changing default shell..."
sudo chsh -s /usr/bin/zsh $USER
echo -e " ${BLUE}╰─${NC} ${GREEN}Default shell changed to Zsh${NC}"

echo -e "\n${PURPLE} And remember ── it's Linux, you can do anything here! ${NC}\n"
echo -e "${GREEN} INSTALLATION COMPLETE! Please reboot your system. ${NC}\n"
