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
umask 137
PATH="/bin:/sbin:/usr/sbin:/usr/bin"
ulimit -t 600

declare SWAP_SCAN_FILE=/dev/shm/PiAP_wifi_scan_cache.txt

eval $(grep -a "DEFAULT_*_IFACE=" /srv/PiAP/files/db/defaults ) 2>/dev/null
eval $(grep -a "WAN_IFACE=" /srv/PiAP/files/db/defaults ) 2>/dev/null
eval $(grep -a "*_FILE=" /srv/PiAP/files/db/defaults ) 2>/dev/null
# Caveat: this is a CWE-20 as result of the upstream spec that wifi ssid can be any bytes even code.
NODE_DATA=$(sudo USE_HTML=0 /srv/PiAP/bin/scan_that_air.bash | fgrep -m1 "${1}" ) ;

# non-US users NO SUPPORT FOR LOCAL RADIO ENERGY REGULATIONS. USE AT OWN RISK.
# In theory one can change this to local region code if Hostapd supports it.
echo "country=US"
#
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev"
#echo "update_config=1"
echo ""
echo "network={"
if [[ ( -n $(echo -n "$NODE_DATA" | cut -d- -f 1 2>/dev/null | fgrep -v "\"\"" ) ) ]] ; then
echo -ne "\t\tssid="
echo -n $(echo -n "$NODE_DATA" | cut -d- -f 1 )
echo ""
fi
WIFI_PROTO=$(echo -n "$NODE_DATA" | cut -d- -f 3 )
if [[ ( -n "${WIFI_PROTO:-}" ) ]] ; then
echo -ne "\t\tkey_mgmt="
if [[ ( $(echo -n $WIFI_PROTO | fgrep --count "WPA" 2>/dev/null ) -gt 0) ]] ; then
echo "WPA-PSK"
GROUP_CIPHER=$(echo -n "$NODE_DATA" | cut -d- -f 6- | cut -dm -f 2- | cut -d- -f 3 | tr -d ' ' )
PAIRWISE=$(echo -n "$NODE_DATA" | cut -d- -f 6- | cut -dm -f 2- | cut -d- -f 3 | tr -d ' ' )
if [[ ( -n $PAIRWISE ) ]] ; then
	echo -ne "\t\tpairwise="
	echo "${PAIRWISE}"
fi
if [[ ( -n $GROUP_CIPHER ) ]] ; then
	echo -ne "\t\tgroup="
	echo "${GROUP_CIPHER}"
fi
elif [[ ( $(echo -n $WIFI_PROTO | fgrep --count "WEP" 2>/dev/null ) -gt 0) ]] ; then
echo -n ${WIFI_PROTO:-NONE}
else
echo -n "NONE"
fi
echo ""
else
echo -e "\t\tkey_mgmt=NONE"
fi
echo -e "\t\tscan_ssid=1"
if [[ ( $(echo -n $WIFI_PROTO | fgrep --count "WPA" 2>/dev/null ) -gt 0) ]] ; then
#echo -ne "\t\tpsk="
#echo -n "\""
#echo -n "${2:-password}"
#echo "\""
# already compromised in local memory and on commandline when input to this script
# need to test this input for CWE-20
echo "${2:-password}" | wpa_passphrase $(echo -n "$NODE_DATA" | cut -d- -f 1 ) | fgrep "psk=" ; wait ;
elif [[ ( $(echo -n $WIFI_PROTO | fgrep --count "WEP" 2>/dev/null ) -gt 0) ]] ; then
# this feature probably will go away and be replaced by aircrack-ng results for WEP. DON'T USE WEP.
echo -ne "\t\tpassword="
echo -n "\""
echo -n "${2:-password}"
echo "\""
fi
echo "}"
#               ssid="${2:-$(sudo USE_HTML=0 /srv/PiAP/bin/scan_the_air.bash | fgrep "${1}" | cut -d- -f 1)}"
#               proto=WPA2
#               scan_ssid=1
#               key_mgmt=WPA-PSK
#               psk="${1}"
#               pairwise=CCMP TKIP
#               group=TKIP
#          }
exit 0 ;
