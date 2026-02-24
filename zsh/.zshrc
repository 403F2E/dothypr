# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin/:$HOME/.cargo/bin/:$PATH"

# once installing the android sdk
## export path="$home/desktop/stuff/projects/flutter/flutter/bin:$path"
## export android_home="$home/desktop/stuff/projects/flutter/android/sdk/"
## export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

pfzf() {
  local target
  cd /
  target=$(fzf --preview='bat --color=always {}')
  cd "$(dirname "$target")" && nvim .
}

# Set-up icons for files/directories in terminal using lsd
alias cat="bat"
alias vi="nvim"
alias v='nvim'
alias open="xdg-open"
alias med_encoder="~/Desktop/Editing/script_encoding.sh"

# alias fzf="fzf --preview='bat --color=always {}' --bind 'enter:become( cd $(dirname "{}") && echo $(dirname "{}") && sleep 2 && nvim .)'"

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'



eval "$(oh-my-posh init zsh --config $HOME/.cache/oh-my-posh/themes/catppuccin_mocha.omp.json)"

plugins=( 
    git
    dnf
    zsh-autosuggestions
    zsh-syntax-highlighting
)

keybind () {
  print "Press the key you want to test (Ctrl+C to exit):"
  read -k key
  print
  print "Hex: ${(q)key}"
  print "Char: ${key}"
}


bindkey -s '^F' "pfzf\n"
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3;5~" kill-word

if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
if [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8a8a8a"
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
autoload -Uz tetriscurses
setopt autocd
# source $ZSH/oh-my-zsh.sh

# check the dnf plugins commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dnf


# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
# pokemon-colorscripts --no-title -s -r #without fastfetch
# pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -
fastfetch -c ~/.config/fastfetch/config_new.jsonc

# fastfetch. Will be disabled if above colorscript was chosen to install
# fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Music download function 
ytb-dl() {
  youtube-dl -x --audio-format mp3 --audio-quality 320k -o '%(title)s.%(ext)s' $1
}

doxy() { cd ~/Desktop/Stuff/Books/Docs/ }
ru() { cd ~/Desktop/Stuff/Projects/Rust/ }
pd() { cd ~/Desktop/Stuff/Projects/Python/ }
cdir() { cd ~/Desktop/Stuff/Projects/C/ }
cpd() { cd ~/Desktop/Stuff/Projects/C++/ }
jd() { cd ~/Desktop/Stuff/Projects/Java/ }
phd() { cd ~/Desktop/Stuff/Projects/PHP/ }
flut() { cd ~/Desktop/Stuff/Projects/Flutter/ }
wd() { cd ~/Desktop/Stuff/Projects/Web_Project/ }
home() { cd ~ }
prog() { cd ~/Desktop/Stuff/Projects/ }
leet() { cd ~/Desktop/Stuff/Projects/Leetcode/}
pentest() { cd ~/Desktop/PenTEST/ }
dev() { cd ~/Desktop/Stuff/Projects/Dev/ }
alias cls="clear"
# export PATH="$PATH:$HOME/.dotnet/tools"
