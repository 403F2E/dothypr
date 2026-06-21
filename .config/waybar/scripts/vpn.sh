#!/bin/bash

if nmcli connection show --active | grep -qi vpn; then
    echo "🔒 VPN"
else
    echo "🔓"
fi
