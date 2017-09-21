#! /bin/bash
# Disclaimer of Warranties. 
# A. YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT, TO THE EXTENT PERMITTED BY
#    APPLICABLE LAW, USE OF THIS SHELL SCRIPT AND ANY SERVICES PERFORMED
#    BY OR ACCESSED THROUGH THIS SHELL SCRIPT IS AT YOUR SOLE RISK AND
#    THAT THE ENTIRE RISK AS TO SATISFACTORY QUALITY, PERFORMANCE, ACCURACY AND
#    EFFORT IS WITH YOU.
#
# B. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THIS SHELL SCRIPT
#    AND SERVICES ARE PROVIDED "AS IS" AND “AS AVAILABLE”, WITH ALL FAULTS AND
#    WITHOUT WARRANTY OF ANY KIND, AND THE AUTHOR OF THIS SHELL SCRIPT AND PIAP TOOL'S LICENSORS
#    (COLLECTIVELY REFERRED TO AS "THE AUTHOR OF PIAP" FOR THE PURPOSES OF THIS DISCLAIMER)
#    HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH RESPECT TO THIS SHELL SCRIPT
#    SOFTWARE AND SERVICES, EITHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
#    NOT LIMITED TO, THE IMPLIED WARRANTIES AND/OR CONDITIONS OF
#    MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE,
#    ACCURACY, QUIET ENJOYMENT, AND NON-INFRINGEMENT OF THIRD PARTY RIGHTS. 
#    
# C. THE AUTHOR OF PIAP DOES NOT WARRANT AGAINST INTERFERENCE WITH YOUR ENJOYMENT OF THE
#    THE AUTHOR OF PIAP SOFTWARE AND SERVICES, THAT THE FUNCTIONS CONTAINED IN, OR
#    SERVICES PERFORMED OR PROVIDED BY, THIS SHELL SCRIPT WILL MEET YOUR
#    REQUIREMENTS, THAT THE OPERATION OF THIS SHELL SCRIPT OR SERVICES WILL
#    BE UNINTERRUPTED OR ERROR-FREE, THAT ANY SERVICES WILL CONTINUE TO BE MADE
#    AVAILABLE, THAT THIS SHELL SCRIPT OR SERVICES WILL BE COMPATIBLE OR
#    WORK WITH ANY THIRD PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES,
#    OR THAT DEFECTS IN THIS SHELL SCRIPT OR SERVICES WILL BE CORRECTED.
#    INSTALLATION OF THIS THE AUTHOR OF PIAP SOFTWARE MAY AFFECT THE USABILITY OF THIRD
#    PARTY SOFTWARE, APPLICATIONS OR THIRD PARTY SERVICES.
#
# D. YOU FURTHER ACKNOWLEDGE THAT THIS SHELL SCRIPT AND SERVICES ARE NOT
#    INTENDED OR SUITABLE FOR USE IN SITUATIONS OR ENVIRONMENTS WHERE THE FAILURE
#    OR TIME DELAYS OF, OR ERRORS OR INACCURACIES IN, THE CONTENT, DATA OR
#    INFORMATION PROVIDED BY THIS SHELL SCRIPT OR SERVICES COULD LEAD TO
#    DEATH, PERSONAL INJURY, OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE,
#    INCLUDING WITHOUT LIMITATION THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
#    NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, LIFE SUPPORT OR
#    WEAPONS SYSTEMS.
#
# E. NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY THE AUTHOR OF PIAP
#    SHALL CREATE A WARRANTY. SHOULD THIS SHELL SCRIPT OR SERVICES PROVE DEFECTIVE,
#    YOU ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
#
#    Limitation of Liability.
# F. TO THE EXTENT NOT PROHIBITED BY APPLICABLE LAW, IN NO EVENT SHALL THE AUTHOR OF PIAP
#    BE LIABLE FOR PERSONAL INJURY, OR ANY INCIDENTAL, SPECIAL, INDIRECT OR
#    CONSEQUENTIAL DAMAGES WHATSOEVER, INCLUDING, WITHOUT LIMITATION, DAMAGES
#    FOR LOSS OF PROFITS, CORRUPTION OR LOSS OF DATA, FAILURE TO TRANSMIT OR
#    RECEIVE ANY DATA OR INFORMATION, BUSINESS INTERRUPTION OR ANY OTHER
#    COMMERCIAL DAMAGES OR LOSSES, ARISING OUT OF OR RELATED TO YOUR USE OR
#    INABILITY TO USE THIS SHELL SCRIPT OR SERVICES OR ANY THIRD PARTY
#    SOFTWARE OR APPLICATIONS IN CONJUNCTION WITH THIS SHELL SCRIPT OR
#    SERVICES, HOWEVER CAUSED, REGARDLESS OF THE THEORY OF LIABILITY (CONTRACT,
#    TORT OR OTHERWISE) AND EVEN IF THE AUTHOR OF PIAP HAS BEEN ADVISED OF THE
#    POSSIBILITY OF SUCH DAMAGES. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION
#    OR LIMITATION OF LIABILITY FOR PERSONAL INJURY, OR OF INCIDENTAL OR
#    CONSEQUENTIAL DAMAGES, SO THIS LIMITATION MAY NOT APPLY TO YOU. In no event
#    shall pak tool's total liability to you for all damages (other than as may
#    be required by applicable law in cases involving personal injury) exceed
#    the amount of five dollars ($5.00). The foregoing limitations will apply
#    even if the above stated remedy fails of its essential purpose.
################################################################################
ulimit -t 600
PATH="/bin:/sbin:/usr/sbin:/usr/bin"
umask 137

##Bug [PiAP-03] issue with delimiter and positive signal values
declare SWAP_SCAN_FILE=/dev/shm/PiAP_wifi_scan_cache.txt

HAS_POCKET_USER=$(id pocket-www 1>&2 2>/dev/null >> /dev/null && echo -n 0 || echo -n $?)
POCKET_WEB_USER="www-data"
if [[ ( ${HAS_POCKET_USER:-1} -lt 1 ) ]] ; then 
	POCKET_WEB_USER="pocket-www"
fi

eval $(grep -a "DEFAULT_*_IFACE=" /srv/PiAP/files/db/defaults ) 2>/dev/null
eval $(grep -a "*_FILE=" /srv/PiAP/files/db/defaults ) 2>/dev/null
eval $(fgrep "USE_HTML=" /srv/PiAP/files/db/defaults ) 2>/dev/null

if [[ !( -f $SWAP_SCAN_FILE) ]] ; then
	iwlist ${DEFAULT_RECON_IFACE:-wlan0} scan last | fgrep -v "IE: Unknown:" >"${SWAP_SCAN_FILE}"
	chown ${POCKET_WEB_USER}:${POCKET_WEB_USER} "${SWAP_SCAN_FILE}"
fi

USE_HTML=${USE_HTML:-1}
if [[ ( $USE_HTML -le 0 ) ]] ; then
echo "Scan:"
else
echo -n "<table class=\"table table-striped\">"
echo -n "<thead><tr><th>ESSID</th><th>MAC</th><th>Security</th><th>RF Band</th><th>Signal</th><th>Group Cipher</th><th>Pairwise Cipher</th></tr></thead><tbody>"
fi

for AP_ADDR in $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep "Cell" | tr -s ' ' ' ' | cut -d \  -f 6 | sort -t\: -n | uniq ) ; do
if [[ ( $USE_HTML -le 0 ) ]] ; then
COL_DELIM=" - "
else
echo -n "<tr><td>"
COL_DELIM="</td><td>"
fi
if [[ ( $USE_HTML -ge 1 ) ]] ; then
echo -n $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep -m 1 --after-context=6 "${AP_ADDR}" | grep -F -m1 "ESSID:" | cut -d ':' -f 2 | sed -E -e 's/\"\"/<i>Hidden Network<\/i>/g' | sed -E -e 's/\\/\\\\/g' )"${COL_DELIM}"
else
echo -n $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep -m 1 --after-context=6 "${AP_ADDR}" | grep -F -m1 "ESSID:" | cut -d ':' -f 2 | sed -E -e 's/\\/\\\\/g' )"${COL_DELIM}"
fi
echo -n $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep -m 1 "${AP_ADDR}" | tr -s ' ' ' ' | cut -d \  -f 6)"${COL_DELIM}"
if [[ ( $USE_HTML -ge 1 ) ]] ; then
if [[ ( -n $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep --after-context=8 "${AP_ADDR}" | grep -F -m 1 "Encryption key:" | cut -d ':' -f 2 | fgrep "on" ) ) ]] ; then
echo -n "<span class=\"label label-info\">encrypted</span>" ;
else
echo -n "<span class=\"label label-warning\">Open</span>" ;
fi
fi
if [[ ( $USE_HTML -ge 1 ) ]] ; then
echo -n $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep -m1 --after-context=12 "${AP_ADDR}" | grep -oE "(RSN|WPA2|WPA|WEP){1}" | sed -E -e 's/^[ANPRW]{3}[2]?$/<span class=\"label label-success\">&<\/span>/g' | sed -E -e 's/^[WEP]{3}$/<span class=\"label label-warning\">&<\/span>/g' )"${COL_DELIM}"
else
echo -n $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep -m1 --after-context=12 "${AP_ADDR}" | grep -oE "(RSN|WPA2|WPA|WEP){1}" )"${COL_DELIM}"
fi

echo -n $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep -m1 --after-context=6 "${AP_ADDR}" | grep -F -m 1 "Frequency:" | cut -d ':' -f 2)"${COL_DELIM}"
echo -n $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep -m1 --after-context=6 "${AP_ADDR}" | grep -i -F -m 1 "Signal level" | cut -d \= -f 3)"${COL_DELIM}"
echo -n $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep --after-context=20 "Cell" | grep -aE "(Cell|Cipher){1}" | fgrep --after-context=4 -m1 -a "${AP_ADDR}" | fgrep -m1 "Group Cipher" | grep -aoE "(CCMP|TKIP|CCMP\sTKIP){1}" )"${COL_DELIM}"
echo -n $(fgrep -v "IE: Unknown:" "${SWAP_SCAN_FILE}" | fgrep --after-context=20 "Cell" | grep -aE "(Cell|Cipher){1}" | fgrep --after-context=4 -m1 -a "${AP_ADDR}" | fgrep -m1 "Pairwise Cipher" | grep -aoE "(CCMP|TKIP|CCMP\sTKIP){1}" )"${COL_DELIM}"

if [[ ( $USE_HTML -le 0 ) ]] ; then
echo ""
else
echo "</td></tr>"
fi
done ;

if [[ ( $USE_HTML -le 0 ) ]] ; then
echo ""
else
echo "</tbody></table>"
fi


rm -f "${SWAP_SCAN_FILE}" 2>/dev/null || true

exit 0;
