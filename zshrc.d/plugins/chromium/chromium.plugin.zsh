if [ ${OSTYPE} = "linux-gnu" ]
then
  CHROMIUM_FLAGS="${CHROMIUM_FLAGS} --enable-remote-extensions"
  CHROMIUM_FLAGS="${CHROMIUM_FLAGS} --password-store=detect"
  CHROMIUM_FLAGS="${CHROMIUM_FLAGS} --user-data-dir"
  
  export CHROMIUM_FLAGS
fi
