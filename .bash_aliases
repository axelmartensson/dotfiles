shopt -s expand_aliases
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

###### GIT ALIASES #########
#alias git=hub # wrapper for integration with github
alias gica="git commit -a"
alias gico="git checkout"
alias gist="git status --short --branch"
alias gips="git push"
alias gipu="git pull"
alias gilg="git log"
############################
alias install="sudo apt install"

