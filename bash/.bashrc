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

##################
# my extra stuff
# ###############

# flutter sdk 
export PATH="$PATH:$HOME/development/flutter/bin"

# command prompt
eval "$(starship init bash)"

###########
# aliases
###########

# listing, moving and deleting
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias mv='mv -i'
alias rm='rm -i'

# change or make directories
alias ..='cd ..'
alias down='cd ~/Downloads'
alias docs='cd ~/Documents'
alias dev='cd ~/dev'
alias mkdir='mkdir -pv' # create parent dir by default

# git 
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gac='git add . && git commit -m' # only when sure
alias gp='git push'
alias gpl='git pull'

# system update
alias dnf='sudo dnf'
alias dnfup='sudo dnf update -y && flatpak update -y'
