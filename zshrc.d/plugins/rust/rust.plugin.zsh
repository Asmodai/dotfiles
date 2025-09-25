# Configure Rust.

if [ -d "${HOME}/.cargo/bin" ]
then
    export PATH=$PATH:${HOME}/.cargo/bin
fi

if [ -f "${HOME}/.cargo/env" ]
then
    . "${HOME}/.cargo/env"
fi
