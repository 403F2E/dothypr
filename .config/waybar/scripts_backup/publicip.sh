#!/usr/bin/env bash
#  publicip.sh — exit IP + geo for Waybar (custom/publicip).
#  Flags warning if exit ASN matches your home network (leak check).
#  --copy copies the IP to clipboard.
set -euo pipefail

HOME_ASN="${DW_HOME_ASN:-AS5089}"   # set to your home ISP's ASN

fetch() { curl -s --max-time 4 "https://ipinfo.io/json" 2>/dev/null; }

J="$(fetch || true)"
if [[ -z "$J" ]]; then
  printf '{"text":"—","class":"warning","tooltip":"exit lookup failed"}\n'; exit 0
fi
ip="$(echo "$J"  | grep -oP '"ip":\s*"\K[^"]+'      || echo '?')"
city="$(echo "$J"| grep -oP '"city":\s*"\K[^"]+'    || echo '?')"
region="$(echo "$J"|grep -oP '"region":\s*"\K[^"]+' || echo '')"
org="$(echo "$J" | grep -oP '"org":\s*"\K[^"]+'     || echo '?')"

if [[ "${1:-}" == "--copy" ]]; then echo -n "$ip" | wl-copy; notify-send -a NET "Exit IP copied" "$ip"; exit 0; fi

cls=""; leak="NO"
[[ "$org" == *"$HOME_ASN"* ]] && { cls="warning"; leak="YES — exit matches home ASN"; }

# obscure last two octets in the bar; full detail in tooltip
masked="$(echo "$ip" | sed -E 's/\.[0-9]+\.[0-9]+$/.x.x/')"
printf '{"text":"%s","class":"%s","tooltip":"public ip: %s\\ngeo: %s, %s\\nasn: %s\\nmatches home: %s"}\n' \
  "$masked" "$cls" "$ip" "$city" "$region" "$org" "$leak"
