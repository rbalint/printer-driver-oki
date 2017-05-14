#!/bin/sh
#############################################################
# Copyright 2010 Oki Data Corporation
#############################################################
# install PPD and/or filter
#############################################################
# version: 2.0
#############################################################

PATH=/bin:/usr/sbin:/usr/bin
export PATH

CP="/bin/cp"
CHMOD="/bin/chmod"
CHOWN="/bin/chown"
CUT="/usr/bin/cut"
ECHO="/bin/echo"
GREP="/bin/grep"
MKDIR="/bin/mkdir"

programName="install.sh"
OKI_FILTER="rastertookidotmatrix"

#####################################################
# generic copy 
#####################################################
copy_stuff()
{
	if [ -f "${2}/${1}" ] ; then
		${ECHO} "${programName}: WARNING: ${2}/${1} already exist."
		return
	fi

	${CHOWN} root ${1} > /dev/null 2>&1
	if [ $? -ne 0 ] ; then
		${ECHO} "${programName}: WARNING: cannot change owner - ${1}."
	fi

	${CP} "${1}" "${2}" > /dev/null 2>&1
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


if [ `id -u` -ne 0 ] ; then
	${ECHO}  "${programName}: ERROR: must be root"
	exit 1
fi

_CUPS="/etc/init.d/cups"
_CUPSD="/etc/init.d/cupsd"
_CUPSYS="/etc/init.d/cupsys"

########################
# paths . . .
########################
PPD_PATH="/usr/share/ppd"
CUPSPPD_PATH="/usr/share/cups/model"
_PPD_PATH=""
CUPSFILTER_PATH="/usr/lib/cups/filter"

if [ -x ${CUPSPPD_PATH} ] ; then
	_PPD_PATH="${CUPSPPD_PATH}"
elif [ -x ${PPD_PATH} ] ; then
	_PPD_PATH="${PPD_PATH}"
fi

_PPD_PATH="${_PPD_PATH:-${CUPSPPD_PATH}}"

for i in `ls ok*ppd*`
do
	## permissions ##
	chg_mode 444 ${i}

	## copy PPDs ##
	copy_stuff ${i} ${_PPD_PATH}
done

if [ ! -x ${OKI_FILTER} ] ; then
	error_msg "cannot find ${OKI_FILTER}"
fi

## permissions ##
chg_mode 555 ${OKI_FILTER}

## copy filter ##
copy_stuff ${OKI_FILTER} ${CUPSFILTER_PATH}

for i in ${_CUPS} ${_CUPSD} ${_CUPSYS}
do
	${i} restart  > /dev/null 2>&1
done

${ECHO} "INFO: ${programName} completed . . ."

exit 0
