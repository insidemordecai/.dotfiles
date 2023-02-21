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

# set default text editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# flutter sdk 
export PATH="$PATH:$HOME/development/flutter/bin"

# required for flutterfire-cli
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Starship.rs prompt
eval "$(starship init bash)"
