export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

PATH="/usr/local/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
#PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
#PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="$PATH:$HOME/.composer/vendor/bin"

#MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
#MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

#ANDROID_HOME=/usr/local/opt/android-sdk
#STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk

if [ -x /usr/local/bin/gdircolors ]; then
    eval "$(gdircolors -b)"
    alias ls='gls --color=auto'
    alias grep='ggrep --color=auto'
    alias fgrep='gfgrep --color=auto'
    alias egrep='gegrep --color=auto'
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
