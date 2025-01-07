#!/bin/bash

VPN_CONFIG="/home/medo/.config/vless/vless1.json"
PNAME="sing-box"

# check_sudo() {
#   # if ! sudo -l >/dev/null 2>&1; then
#   #   echo "Run this script as a sudo user!"
#   #   exit 1
#   # fi
# }

start_vpn() {
  if pgrep -x "$PNAME" >/dev/null; then
    echo "VPN is already running (pid: $(pgrep -x $PNAME))"
  else
    # check_sudo
    sing-box run -c $VPN_CONFIG >/dev/null 2>&1 &
    echo "VPN started (pid: $!)"
  fi
}

stop_vpn() {
  if pgrep -x "$PNAME" >/dev/null; then
    # check_sudo
    pkill -x "$PNAME"
    echo "VPN stopped"
  else
    echo "VPN is not running"
  fi
}

status_vpn() {
  if pgrep -x "$PNAME" >/dev/null; then
    echo "VPN is running (pid: $(pgrep -x $PNAME))"
  else
    echo "VPN is not running"
  fi
}

restart_vpn() {
  stop_vpn
  sleep 1
  start_vpn
}

case "$1" in
on) start_vpn ;;
off) stop_vpn ;;
status) status_vpn ;;
restart) restart_vpn ;;
*)
  echo "Usage: $(basename $0) {on|off|status|restart}"
  ;;
esac
