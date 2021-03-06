################
#### Divers ####
################

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"



################
#### Prompt ####
################

#256 colors term
export TERM=xterm-256color

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
if [[ ${EUID} == 0 ]] ; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]${STATUS} \t> '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]${STATUS} \t> '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# bash-git-prompt
if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
    source ~/.bash-git-prompt/gitprompt.sh
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_THEME=Custom
fi


#################
#### Couleur ####
#################

if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
fi



###############
#### Alias ####
###############

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'
alias svi='sudo vim'

alias svna='svn add'
alias svnm='svn mv'
alias svnd='svn del'
alias svnr='svn rm'
alias svni='svn info'
alias svns='svn status'
alias svnc='svn commit'
alias svndi='svn diff'

alias gita='git add'
alias gitci='git commit'
alias gitcl='git clone'
alias gitco='git checkout'
alias gits='git status'
alias gitb='git branch'
alias gitl='git log --color --graph --pretty=format:"%C(red)%h%Creset -%C(yellow)%d%Creset %s %C(green)(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

alias api='sudo apt install'
alias apupd='sudo apt update'
alias apupg='sudo apt upgrade'
alias apse='sudo apt search'
alias apsh='sudo apt show'
alias app='sudo apt purge'
alias apar='sudo apt-get autoremove'
alias apri='sudo aptitude reinstall'

alias service='sudo service'

alias avent='startct'



###################
#### Fonctions ####
###################

# Infos sur la session courante
function info()
{
	echo -e " You are logged on $HOSTNAME"
	echo -e " Additionnal information: " ; uname -a
	echo -e " Users logged on: " ; w -h
	echo -e " Current date : " ; date
	echo -e " Machine stats : " ; uptime
	echo -e " Memory stats : " ; free
	echo ""
}

# Kill d'un processus
killd () {
       DISPLAY="" ps xae | grep DISPLAY=:$1 | grep -v grep | awk '{print $1}' | xargs kill -9
}



####################
#### Completion ####
####################

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# hosts
complete -A hostname rsh telnet rlogin ssh ping nmap ftp

# sudo
complete -cf sudo

# cd
bind "set completion-ignore-case on"
bind "set show-all-if-ambigous on"
