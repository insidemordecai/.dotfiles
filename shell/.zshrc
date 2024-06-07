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

# Starship prompt
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"
