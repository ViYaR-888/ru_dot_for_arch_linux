# === System Paths ===
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

# === Plugins ===
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Suggestion highlight color (grey, Fish-style)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Tab completion settings
autoload -Uz compinit && compinit -d ~/.zcompdump
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory sharehistory

# === Prompt Fix ===
PROMPT='%F{5}   %F{4}%~ %F{5}%(?.❯.%F{1}❯)%f '

# Screen clearing
clear() {
    command clear && printf '\e[3J'
}
alias cls="clear"
alias fetch="fastfetch"

# === Welcome Message ===
clear
echo -e "\e[0;35m╭──────────────────────────────────────────────────────────╮\e[0m"
echo -e "\e[0;35m│                      SYSTEM STATUS                       │\e[0m"
echo -e "\e[0;35m╰──────────────────────────────────────────────────────────╯\e[0m"
echo ""
fastfetch
echo ""
alias setavatar="curl -L -o ~/Pictures/avatar.png"
