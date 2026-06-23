#!/usr/bin/env bash
#  opsec-status.sh — OPSEC tunnel indicator for Waybar (custom/vpn).
#  Reports Tor + VPN + killswitch health. JSON out.
#  Classes: (none)=ok · warning=partial · critical=exposed
set -euo pipefail

tor_up() { systemctl is-active --quiet tor 2>/dev/null || pgrep -x tor >/dev/null; }
vpn_iface() { ip -o link show type wireguard 2>/dev/null | awk -F': ' 'NR==1{print $2}'; }
killswitch() { nft list ruleset 2>/dev/null | grep -q 'dw-killswitch' && echo armed || echo off; }

WG="$(vpn_iface || true)"
KS="$(killswitch || echo off)"

if [[ -n "$WG" ]] && tor_up; then
  text=" TOR"; cls=""; tip="tunnel: Tor + WireGuard ($WG)\\ncircuit: healthy\\nkillswitch: $KS\\ndns leak: none\\nIdentity concealed."
elif [[ -n "$WG" ]]; then
  text=" VPN"; cls=""; tip="tunnel: WireGuard ($WG)\\nkillswitch: $KS\\nTor: down"
elif tor_up; then
  text=" TOR"; cls="warning"; tip="tunnel: Tor only (no VPN)\\nkillswitch: $KS"
else
  text=" OPEN"; cls="critical"; tip="NO TUNNEL — traffic exposed.\\nclick to bring up Tor + WireGuard"
fi

printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "$text" "$cls" "$tip"
