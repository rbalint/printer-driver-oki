#!/bin/sh
#############################################################
# Copyright 2012 Oki Data Corporation
#############################################################
# uninstalls PPD and/or filter
#############################################################

PATH=/bin:/usr/sbin:/usr/bin
export PATH

ECHO="/bin/echo"
RM="/bin/rm"
FIND="/usr/bin/find"
ID="/usr/bin/id"

programName="uninstall.sh"
FILTER_PATH="/usr/lib/cups/filter"

OKI_FILTER="okijobaccounting"
PPD="MC56XPS.ppd*"

if [ `${ID} -u` -ne 0 ] ; then
	${ECHO}  "${programName}: ERROR: must be root"
	exit 1
fi

${FIND} /usr/share -name  "${PPD}" -exec ${RM} {} \; 2>/dev/null
${FIND} ${FILTER_PATH} -name  ${OKI_FILTER} -exec ${RM} {} \; 2>/dev/null

CUPS="/etc/init.d/cups"
CUPSD="/etc/init.d/cupsd"
CUPSYS="/etc/init.d/cupsys"

for i in ${CUPS} ${CUPSD} ${CUPSYS}
do
	${i} restart > /dev/null 2>&1
done

${ECHO} "INFO: ${programName} completed . . ."

exit 0
