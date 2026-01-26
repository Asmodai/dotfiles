if [ ! -z "$(whence fzf 2>/dev/null)" ]
then
    alias cdfz='cd $(dirname $(fzf))'
fi
