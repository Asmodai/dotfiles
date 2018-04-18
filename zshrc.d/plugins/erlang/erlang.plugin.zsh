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

  if [ -d ~/erlang/R19 ]
  then
    alias erlang19="source ~/erlang/R19/activate"
  fi

  if [ -d ~/erlang/R19.1 ]
  then
    alias erlang19.1="source ~/erlang/R19.1/activate"
  fi

  if [ -d ~/erlang/R19.3 ]
  then
    alias erlang19.3="source ~/erlang/R19.3/activate"
  fi

  # R20.1 is the default.
  if [ -d ~/erlang/R20.1 ]
  then
    alias erlang20.1="source ~/erlang/R20.1/activate"
    source ~/erlang/R20.1/activate
  fi

fi

