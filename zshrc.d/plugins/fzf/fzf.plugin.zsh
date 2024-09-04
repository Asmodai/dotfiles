if [ ! -z "$(whence fzf)" ]
then
  alias cdfz='cd $(dirname $(fzf))'
fi

