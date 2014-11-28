export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=/usr/local/bin:$PATH

export ANDROID_HOME=/usr/local/opt/android-sdk

if [ -x /usr/local/bin/gdircolors ]; then
    eval "$(gdircolors -b)"
    alias ls='gls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi
