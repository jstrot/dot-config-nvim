
export EDITOR=nvim
export GIT_EDITOR=nvim

if false ; then
    # MANPAGER will not work if you use an appimage version of Neovim!
    export MANPAGER='nvim +Man!'
else
    man() {
	if [ -t 1 ] ; then
	    # stdout is a terminal
	    /usr/bin/man "$@" | nvim +Man!
	else
	    /usr/bin/man "$@"
	fi
    }
fi
