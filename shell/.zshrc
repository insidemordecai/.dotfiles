# User specific aliases and functions
if [ -d ~/.shell.d ]; then 
  for rc in ~/.shell.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

# set detault text editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Flutter SDK
export PATH=$HOME/development/flutter/bin:$PATH

# Starship prompt
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# History setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward


# NOTE: Load last
if [[ `uname` == "Darwin" ]]; then
  # zsh-autosuggestions & zsh-syntax-highlighting plugins via Homebrew on macOS
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else 
  # Linux
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 
fi
