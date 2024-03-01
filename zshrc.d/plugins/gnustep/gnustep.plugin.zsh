# Set this to your GNUstep library directory
export GSTEP_LIBRARY_PATH=/usr/GNUstep/System/Library/Makefiles

if [ -d ${GSTEP_LIBRARY_PATH} ]
then
    source ${GSTEP_LIBRARY_PATH}/GNUstep.sh
fi

