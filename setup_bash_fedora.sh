#!/bin/bash

echo "Installing dependencies..."
sudo dnf install cmake gcc git

echo "Installing cargo..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Sourcing cargo environment..."
source "$HOME/.cargo/env"

echo "Installing eza..."
cargo install eza

echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

source ~/.bashrc

# Define the new .bashrc content
BASHRC_CONTENT=$(cat <<'EOF'
# .bashrc
export HISTSIZE=1000000
export HISTFILESIZE=1000000

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

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
        for rc in ~/.bashrc.d/*; do
                if [ -f "$rc" ]; then
                        . "$rc"
                fi
        done
fi

unset rc
. "$HOME/.cargo/env"
if [ -n "$PS1" ]; then
        df -h
fi
# export PS1="\[\e[32m\]\u\[\e[m\]@\[\e[34;40m\]\h\[\e[m\] \t | \w \\$ "
export PS1="\[\e[36m\]\u\[\e[m\]@\[\e[35m\]\h\[\e[m\] \[\e[33m\]\t\[\e[m\] | \[\e[32m\]\w\[\e[m\] \\$ "
export PATH="$HOME/.local/bin:$HOME/.local/usr/bin:$PATH"
export PYTHONPATH=$HOME/run_now
export RECKLESS_WORKER_AFFINITY=0

alias python3.8='/opt/python/3.8.5/bin/python3.8'
alias pip3.8='/opt/python/3.8.5/bin/pip3.8'

# Basic listing (equivalent to 'ls')
alias ls='eza --color=always --group-directories-first --icons=never'

# Long listing (equivalent to 'ls -l')
alias ll='eza -glh --color=always --group-directories-first --icons=never --header'

# Long listing including hidden files (equivalent to 'ls -la')
alias lla='eza -glh -a --color=always --group-directories-first --icons=never --header'

# List only directories (similar to 'ls -d */')
alias lsd='eza -D --color=always --group-directories-first --icons=never'

# Recursive tree listing (similar to 'ls -R' or using 'tree')
alias lst='eza -T --color=always --group-directories-first --icons=never'

# Detailed tree listing
alias llt='eza -T -glh --color=always --group-directories-first --icons=never --header'

# Sort by modification time (newest first)
alias lsn='eza -glh --sort=modified --reverse --color=always --group-directories-first --icons=never --header'

# Sort by file size (largest first)
alias lss='eza -glh --sort=size --reverse --color=always --group-directories-first --icons=never --header'


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
EOF
)

echo "${BASHRC_CONTENT}" > ~/.bashrc
echo ".bashrc file has been replaced."

# Source the new .bashrc
source ~/.bashrc

