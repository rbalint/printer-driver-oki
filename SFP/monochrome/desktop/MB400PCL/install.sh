#!/bin/sh
#############################################################
# Copyright 2012 Oki Data Corporation
#############################################################
# install PPD and/or filter
#############################################################

PATH=/bin:/usr/sbin:/usr/bin
export PATH

CP="/bin/cp"
CHMOD="/bin/chmod"
CHOWN="/bin/chown"
CHGRP="/bin/chgrp"
ECHO="/bin/echo"
ID="/usr/bin/id"
RM="/bin/rm"

programName="install.sh"
OKI_FILTER="rastertookimonochrome"

#####################################################
# generic copy 
#####################################################
copy_stuff()
{
	${CHOWN} root ${1} > /dev/null 2>&1
	${CHGRP} root ${1} > /dev/null 2>&1
	if [ $? -ne 0 ] ; then
		${ECHO} "${programName}: WARNING: cannot change owner - ${1}."
	fi

	${RM} -f "${2}/${1}"  > /dev/null 2>&1
	${CP} -p "${1}" "${2}" > /dev/null 2>&1
	if [ $? -ne 0 ] ; then
		error_msg "cannot copy ${1}."
	fi

}

#####################################################
# error routine
#####################################################
error_msg()
{
	${ECHO} "${programName}: ERROR: ${1}"
	exit 1
}

#####################################################
# change mode
#####################################################
chg_mode() 
{ 
	${CHMOD} "${1}" "${2}"  > /dev/null 2>&1
	if [ $? -ne 0 ] ; then
		${ECHO} "${programName}: WARNING: cannot change mode - ${2}"
	fi
}


if [ `${ID} -u` -ne 0 ] ; then
	${ECHO}  "${programName}: ERROR: must be root"
	exit 1
fi

_CUPS="/etc/init.d/cups"
_CUPSD="/etc/init.d/cupsd"
_CUPSYS="/etc/init.d/cupsys"

########################
# paths . . .
########################
FILTER_PATH="/usr/lib/cups/filter"
SHARE_PATH="/usr/share/ppd"
MODEL_PATH="/usr/share/cups/model"
_PPD_PATH=""

if [ ! -x "${FILTER_PATH}" ] ; then
	error_msg "cannot find ${FILTER_PATH}"
fi

if [ -x "${MODEL_PATH}" ] ; then
	_PPD_PATH="${MODEL_PATH}"
elif [ -x "${SHARE_PATH}" ] ; then
	_PPD_PATH="${SHARE_PATH}"
fi

_PPD_PATH="${_PPD_PATH:-${MODEL_PATH}}"

for i in `ls *ppd*`
do
	## permissions ##
	chg_mode 444 ${i}

	## copy PPDs ##
	copy_stuff ${i} ${_PPD_PATH}
done


## permissions ##
chg_mode 555 ${OKI_FILTER}

## copy filter ##
copy_stuff ${OKI_FILTER} ${FILTER_PATH}

for i in ${_CUPS} ${_CUPSD} ${_CUPSYS}
do
	${i} restart  > /dev/null 2>&1
done

${ECHO} "INFO: ${programName} completed . . ."

exit 0
