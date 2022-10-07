# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

########################
### MY EXTRA CONFIGS ###
########################

# flutter sdk 
export PATH="$PATH:$HOME/development/flutter/bin"

# Starship.rs prompt
eval "$(starship init bash)"

### ALIASES ###

# listing operation
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'

# interactive operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# changing directories
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'

# making directories 
alias mkdir='mkdir -pv' 

# git 
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gac='git add . && git commit -m' # only when sure
alias gclone='git clone'
alias gp='git push'
alias gpl='git pull'

# DNF package manager and Flatpak
alias dnf='sudo dnf'
alias dnfi='sudo dnf install'
alias dnfrm='sudo dnf remove'
alias dnfup='sudo dnf update -y && flatpak update -y'
alias flati='flatpak install'
alias flatrm='flatpak remove'
