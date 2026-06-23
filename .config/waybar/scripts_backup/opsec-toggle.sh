#!/usr/bin/env bash
#  opsec-toggle.sh — bring the anonymity tunnel up/down.
#  {up|down|toggle}. Edit WG_CONF to your WireGuard profile.
set -euo pipefail
WG_CONF="${DW_WG_CONF:-osint}"   # /etc/wireguard/osint.conf

up()   { sudo systemctl start tor; sudo wg-quick up "$WG_CONF" 2>/dev/null || true;
         notify-send -a OPSEC -u low "OPSEC" "Tunnel up — Tor + WireGuard"; }
down() { sudo wg-quick down "$WG_CONF" 2>/dev/null || true; sudo systemctl stop tor;
         notify-send -a OPSEC -u normal "OPSEC" "Tunnel down — exposed"; }

case "${1:-toggle}" in
  up) up ;;
  down) down ;;
  toggle) ip link show type wireguard 2>/dev/null | grep -q . && down || up ;;
esac
pkill -RTMIN+0 waybar 2>/dev/null || true   # nudge interval refresh
