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

alias e="vim"

alias cmx="chmod +x"

###### GIT ALIASES #########
#alias git=hub # wrapper for integration with github
alias gca="git commit -va"
alias gcaa="git commit -va --amend --no-edit"
alias gco="git checkout"
alias ghe="git help"
alias gbr="git branch"
alias gst="git status --short --branch -uno"
alias grb="git rebase -i"
alias gps="git push"
alias gpu="git pull"
alias glg="git log"
alias gdf="git diff"
alias gdt="git difftool"
############################

###### SVN ALIASES #########
alias sco="svn checkout"
alias sca="svn commit"
alias sst="svn status --ignore-externals"
alias slg="svn log"
alias sdf="svn diff"
############################


###### DOCKER ALIASES ######
alias drrun="sudo docker run -it"

alias install="sudo apt install -y"

###### KUBERNETES ALIASES ######
if command -v kubectl > /dev/null; then
	alias kc=kubectl
	declare -F __start_kubectl > /dev/null && complete -F __start_kubectl kc
fi
