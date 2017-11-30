if [ -d /usr/local/lib ]
then
    LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
fi

export LD_LIBRARY_PATH
