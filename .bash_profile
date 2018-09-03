# bash_profile is exclusive to Mac OS.  Any configuration in here will not work on Linux.
# Put any configurations into .bashrc that linux specific for future use
source ~/.bashrc

# 'brew install git bash-completion'
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Bash Prompt
function parse_git_dirty {
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]]
  then
    echo " ✗"
  else
    echo " ✓"
  fi
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

# Black       0;30     Dark Gray     1;30
# Blue        0;34     Light Blue    1;34
# Green       0;32     Light Green   1;32
# Cyan        0;36     Light Cyan    1;36
# Red         0;31     Light Red     1;31
# Purple      0;35     Light Purple  1;35
# Brown       0;33     Yellow        1;33
# Light Gray  0;37     White         1;37

case $TERM in
  ansi|screen|xterm*)
    PS1='\[\033[1;36m\][\u@\h:\w]\[\033[0m\]\[\033[1;36m\]$(parse_git_branch)$\[\033[0m\] '
    export SUDO_PS1='\[\033[1;31m\][\@][\u@\h:\w]\[\033[0m\]\n>: '
  ;;
  *)
    PS1="\[\033[1;32m\][\@][\u@\h:\w]\[\033[0m\]\n>: "
    export SUDO_PS1="\[\033[1;31m\][\@][\u@\h:\w]\[\033[0m\]\n>: "
  ;;
esac

# ls colors
export CLICOLOR=1
export LSCOLORS=GxFxcxdxCxegedabagacad

# grep colors
export GREP_OPTIONS='--color=auto'

# For Homebrew
export PATH="/usr/local/bin:$PATH"

# Aliases
alias 'tcstart'='/usr/local/Cellar/tomcat/8.0.14/libexec/bin/startup.sh'
alias 'tcstop'='/usr/local/Cellar/tomcat/8.0.14/libexec/bin/shutdown.sh'
alias 'r'='rails'
alias 'rs'='r server'
alias 'b'='bundle'
alias 'bi'='b install'
alias 'ra'='rake'
alias 'rai'='ra install'
alias ll="ls -la"
alias reinstall="ra install[prawlings@assetricity.com,securepassword]"
alias 'getbrew'='ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"'
alias resetfinder="rm ~/Library/Preferences/com.apple.finder.plist&&killall Finder"
alias showdot="defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder"
alias hidedot="defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder"
alias sqlstart="mysql.server start"
alias sqlstop="mysql.server stop"
alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
# Since java sucks, I had ot add the '-swf-version=13' parameter to the javasmall cmd to prevent an error with rspec
alias javasmall="export JAVA_OPTS='-d32-swf-version=13' && echo 'Switching to 32 bit java'"
alias javabig="export JAVA_OPTS='-d64' && echo 'Switching to 64 bit java'"
alias wifion="networksetup -setairportpower airport on"
alias wifioff="networksetup -setairportpower airport off"
alias rewifi="networksetup -setairportpower airport off; networksetup -setairportpower airport on"
