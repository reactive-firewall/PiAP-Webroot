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

LOCK_FILE="/tmp/PiAP_service_Throttle_lock"

if [[ -f ${LOCK_FILE} ]] ; then
	exit 0 ;
fi

trap 'rm -f ${LOCK_FILE} 2>/dev/null || true ; wait ; exit 1 ;' SIGKILL
trap 'rm -f ${LOCK_FILE} 2>/dev/null || true ; wait ; exit 1 ;' SIGHUP
trap 'rm -f ${LOCK_FILE} 2>/dev/null || true ; wait ; exit 1 ;' SIGTERM
trap 'rm -f ${LOCK_FILE} 2>/dev/null || true ; wait ; exit 1 ;' SIGQUIT
trap 'rm -f ${LOCK_FILE} 2>/dev/null || true ; wait ; exit 1 ;' SIGINT
trap 'rm -f ${LOCK_FILE} 2>/dev/null || true ; wait ; exit 0 ;' EXIT

touch ${LOCK_FILE} 2>/dev/null || exit 0 ;


eval $(grep -a "DEFAULT_*_IFACE=" /srv/PiAP/files/db/defaults ) 2>/dev/null
eval $(grep -a "*_FILE=" /srv/PiAP/files/db/defaults ) 2>/dev/null
eval $(fgrep "USE_HTML=" /srv/PiAP/files/db/defaults ) 2>/dev/null

#ip addr | grep -oE '\s[aehltw]{3}[n]?[0-9]+[:]{1}' | grep -oE '[aehltw]{3}[n]?[0-9]+' | sort | uniq ;
WAN_IFACE="${DEFAULT_WAN_IFACE:-wlan0}"
LAN_IFACE="${DEFAULT_LAN_IFACE:-lan0}"
LAN_IS_BRIDGED="${LAN_IS_BRIDGED:-1}"
CLEAN_UP=0;

if [[ ( -n $(pgrep dnsmasq 2>/dev/null) ) ]] && [[ ( -n $(pgrep hostapd 2>/dev/null) ) ]] ; then
	EXIT_CODE=0 ;
else
	/usr/sbin/service dnsmasq restart ;
	/srv/PiAP/bin/interface_AP_heal.bash ${WAN_IFACE} ;
	sleep 0.5
	/srv/PiAP/bin/interface_AP_heal.bash ${LAN_IFACE} ; wait ;
	if [[ ( $LAN_IS_BRIDGED -gt 0 ) ]] ; then
		for SUB_LAN_IFACE in $(brctl show ${LAN_IFACE} 2>/dev/null | column -t | tr -s \\t ' ' | cut -d\  -f 4 | tail -n +2 ) ; do
			/srv/PiAP/bin/interface_AP_heal.bash ${SUB_LAN_IFACE} ;
			sleep 0.5
		done
	fi
	sleep 1
	/usr/sbin/service dnsmasq restart || exit $? ;
	CLEAN_UP=1;
fi

DATA_SIZE=$(( $(ip link show | fgrep -m1 ${WAN_IFACE:-"mtu"} | grep -aoE "mtu\s[0-9]+\s*" | cut -d \  -f 2 )-78))

if [[ ( ${CLEAN_UP:-0} -gt 0 ) ]] || [[ ( -z $(ping -nc 1 -s ${DATA_SIZE:-55} $(ip route | fgrep default | grepip 2>/dev/null | head -n 1 ) 2>/dev/null >/dev/null || echo "$?" ) ) ]]; then
	/etc/cron.hourly/clear_zeroconf_ip.sh 2>/dev/null || exit $? ;
	/usr/sbin/service dnsmasq restart || exit $? ;
	sleep 1
	ulimit -t 3300
	prep_dns_cache 2>/dev/null >/dev/null ; EXIT_CODE=$? ; wait ;
fi

if [[ ( $( ntpq -np | tr -s ' ' | cut -d\  -f 8 | tail -n +3 | fgrep -v 0 | wc -l ) -le 0 ) ]] ; then 
	# this is a huristic. BEWARE of falshoods believed about time.
	/etc/cron.hourly/ntp_opengate ;
	service ntp restart 2>/dev/null || true ;
	sleep 1;
	/etc/cron.hourly/ntp_opengate ;
	sleep 1;
	/etc/cron.hourly/ntp_opengate ;
	fake-hwclock save 2>/dev/null || true ;
	sync ; sync ;
fi

rm -f ${LOCK_FILE} >/dev/null || true ; wait ;

exit ${EXIT_CODE:-255} ;
