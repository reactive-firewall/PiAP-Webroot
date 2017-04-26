#! /bin/bash

WPA_PASSWORD="${1:-BlueAndSecure0rNot}"
WIFI_SSID="${2:-PocketAP}"
WIFI_CHAN="${3:-11}"
rm -f /etc/hostapd/hostapd.conf.new ; wait ;
/usr/bin/head -n 999999999 "/etc/hostapd/hostapd_conf_template" | /bin/sed -E -e "s/^([[:print:]]+)+([$]{1}[W]{1}[P]{1}[A]{1}[_]{1}[P]{1}[A]{1}[S]{2}[W]{1}[O]{1}[R]{1}[D]{1}){1}([[:print:]]+)*$/\1${WPA_PASSWORD}\3/g" | /bin/sed -E -e "s/^([[:print:]]+)+([$]{1}[W]{1}[I]{1}[F]{1}[I]{1}[_]{1}[S]{2}[I]{1}[D]{1}){1}([[:print:]]+)*$/\1${WIFI_SSID}\3/g" | /bin/sed -E -e "s/^([[:print:]]+)+([$]{1}[W]{1}[I]{1}[F]{1}[I]{1}[_]{1}[C]{1}[H]{1}[A]{1}[N]{1}){1}([[:print:]]+)*$/\1${WIFI_CHAN}\3/g" > /etc/hostapd/hostapd.conf.new 2>/dev/null || exit 2 ; 


sync ; wait ;

nohup /usr/sbin/service wirelessPiAP delayed-restart 2>/dev/null & disown ;

exit 0;
