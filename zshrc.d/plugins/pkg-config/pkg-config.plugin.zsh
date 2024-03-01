if [ -d /usr/local/lib/pkgconfig ]
then
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:${PKG_CONFIG_PATH}
fi

if [ -d /usr/lib/pkgconfig ]
then
    PKG_CONFIG_PATH=/usr/lib/pkgconfig:${PKG_CONFIG_PATH}
fi

export PKG_CONFIG_PATH
