# use vimcat instead of cat
# till vimpager doesn't use pipe disable it
#alias cat='vimcat'

# use vimpager instead of less
# find vimpager
if which vimpager &> /dev/null; then
    export PAGER="vimpager"
else
    export PAGER="$HOME/.zsh/bin/vimpager"
fi
alias less="$PAGER"
alias zless="$PAGER"

