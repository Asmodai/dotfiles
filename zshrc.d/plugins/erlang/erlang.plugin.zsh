if [ -d ~/erlang ]
then
  if [ -d ~/erlang/R16 ]
  then
    alias erlang16="source ~/erlang/R16/activate"
  fi

  if [ -d ~/erlang/R18 ]
  then
    alias erlang18="source ~/erlang/R18/activate"
  fi

  # R19 is the default.
  if [ -d ~/erlang/R19 ]
  then
    alias erlang19="source ~/erlang/R19/activate"
    source ~/erlang/R19/activate
  fi
fi

