#!/bin/sh
#############################################################
# Copyright 2011 Oki Data Corporation
#############################################################
# uninstalls PPD and/or filter
#############################################################

PATH=/bin:/usr/sbin:/usr/bin
export PATH

ECHO="/bin/echo"
RM="/bin/rm"
FIND="/usr/bin/find"

programName="uninstall.sh"
FILTER_PATH="/usr/lib/cups/filter"

OKI_FILTER="okijobaccounting"
PPD="ok361u1.ppd*"

if [ `id -u` -ne 0 ] ; then
	${ECHO}  "${programName}: ERROR: must be root"
	exit 1
fi

${FIND} /usr/share -name  "${PPD}" -exec /bin/rm {} \; 2>/dev/null
${FIND} ${FILTER_PATH} -name  ${OKI_FILTER} -exec /bin/rm {} \; 2>/dev/null

CUPS="/etc/init.d/cups"
CUPSD="/etc/init.d/cupsd"
CUPSYS="/etc/init.d/cupsys"

for i in ${CUPS} ${CUPSD} ${CUPSYS}
do
	${i} restart > /dev/null 2>&1
done

${ECHO} "INFO: ${programName} completed . . ."

exit 0
