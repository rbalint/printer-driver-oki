#!/bin/sh
#############################################################
# Copyright 2010 Oki Data Corporation
#############################################################
# uninstalls PPD and/or filter
#############################################################
# version: 2.0
#############################################################

PATH=/bin:/usr/sbin:/usr/bin
export PATH

ECHO="/bin/echo"
RM="/bin/rm"

programName="uninstall.sh"
FILTER="rastertookidotmatrix"
PPD="okdotmatrix*.ppd*"

SHAREPPD_PATH="/usr/share/ppd"
CUPSPPD_PATH="/usr/share/cups/model"

CUPS_PPD="${CUPSPPD_PATH}/${PPD}"
SHARE_PPD="${SHAREPPD_PATH}/${PPD}"

CUPSFILTER_PATH="/usr/lib/cups/filter"
OKI_FILTER="${CUPSFILTER_PATH}/${FILTER}"

if [ `id -u` -ne 0 ] ; then
	${ECHO}  "${programName}: ERROR: must be root"
	exit 1
fi

${RM} -f ${OKI_FILTER} ${SHARE_PPD} ${CUPS_PPD} > /dev/null 2>&1

CUPS="/etc/init.d/cups"
CUPSD="/etc/init.d/cupsd"
CUPSYS="/etc/init.d/cupsys"

for i in ${CUPS} ${CUPSD} ${CUPSYS}
do
	${i} restart > /dev/null 2>&1
done

${ECHO} "INFO: ${programName} completed . . ."

exit 0
