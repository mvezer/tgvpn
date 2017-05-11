#!/bin/bash
# TorGuard openVPN launcher

CONFIG_FOLDER="/home/$(whoami)/.ovpn"
ROOT_PASS="$CONFIG_FOLDER/.root_pass"
VPN_LOGIN="$CONFIG_FOLDER/.vpn_login"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PS3='Please enter your choice: '
options=("Netherlands" "Switzerland" "Luxembourg" "Hungary" "Poland" "  -- EXIT --")
select opt in "${options[@]}"
do
	if [ "$opt" = "  -- EXIT --" ];
		then
			exit 0;
	fi

	OVPN_CONFIG="$CONFIG_FOLDER/$opt.ovpn"

	echo "Connecting to $opt..."
	echo $(cat $ROOT_PASS) | sudo -S openvpn --config "$OVPN_CONFIG" --auth-user-pass "$VPN_LOGIN" --script-security 2 --up "$DIR/onvpnconnect.sh" --down "$DIR/onvpndisconnect.sh"
	exit 0;
done