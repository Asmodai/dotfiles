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

# Look for any specific user python directories.
PYTHON_VERSIONS=("3.9" "3.10" "3.11")
for pyver in "${PYTHON_VERSIONS[@]}"
do
  if [ -d "${HOME}/Library/Python/${pyver}/bin" ]
  then
    PATH="${PATH}:${HOME}/Library/Python/${pyver}/bin"
    export PATH
  fi
done
unset PYTHON_VERSIONS
