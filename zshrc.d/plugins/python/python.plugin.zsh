# -*- mode: shell-script -*-

# This is more for macOS 'ports' than anything else.

if [ -x /opt/local/bin/python ]
then
  for bin in /opt/local/bin/python*
  do
    alias $(basename "$bin")="$bin"
  done
fi

if [ -x /opt/local/bin/pip ]
then
  for bin in /opt/local/bin/pip*
  do
    alias $(basename "$bin")="$bin"
  done
fi

