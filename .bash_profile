export PATH="$HOME/Applications/Android Studio.app/sdk/tools":$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH

export ANDROID_HOME="$HOME/Applications/Android Studio.app/sdk"

if [ -x /usr/local/opt/coreutils/libexec/gnubin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
