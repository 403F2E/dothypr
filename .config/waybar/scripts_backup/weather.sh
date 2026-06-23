#!/usr/bin/env bash
#  weather.sh — London rain for Waybar (custom/weather). wttr.in, cached.
set -euo pipefail
CACHE="${XDG_RUNTIME_DIR:-/tmp}/dw-weather"
LOC="${DW_WEATHER_LOC:-London}"

# refresh cache if older than 15 min
if [[ ! -f "$CACHE" ]] || (( $(date +%s) - $(stat -c %Y "$CACHE" 2>/dev/null || echo 0) > 900 )); then
  curl -s --max-time 5 "https://wttr.in/${LOC}?format=j1" > "$CACHE.tmp" 2>/dev/null \
    && mv "$CACHE.tmp" "$CACHE" || true
fi
[[ -f "$CACHE" ]] || { echo '{"text":" --","tooltip":"weather unavailable"}'; exit 0; }

J="$(cat "$CACHE")"
temp="$(echo "$J"  | grep -oP '"temp_C":"\K[0-9-]+'        | head -1)"
feels="$(echo "$J" | grep -oP '"FeelsLikeC":"\K[0-9-]+'    | head -1)"
hum="$(echo "$J"   | grep -oP '"humidity":"\K[0-9]+'       | head -1)"
desc="$(echo "$J"  | grep -oP '"value":"\K[^"]+'           | head -1)"
wind="$(echo "$J"  | grep -oP '"windspeedKmph":"\K[0-9]+'  | head -1)"

# glyph by description (rain-leaning, as befits London)
g=""; case "${desc,,}" in
  *rain*|*drizzle*) g="" ;; *snow*) g="" ;;
  *cloud*|*overcast*) g="" ;; *fog*|*mist*) g="" ;;
  *clear*|*sun*) g="" ;; *) g="" ;;
esac

printf '{"text":"%s %s°","class":"weather","tooltip":"%s — %s°C (feels %s°)\\nhumidity %s%%\\nwind %s km/h\\nA fog rolls over Baker Street."}\n' \
  "$g" "${temp:-?}" "$LOC" "${temp:-?}" "${feels:-?}" "${hum:-?}" "${wind:-?}"
