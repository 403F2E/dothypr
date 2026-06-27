#!/usr/bin/env bash

FG_GREEN="\e[32m"
FG_BLUE="\e[34m"
FG_RESET="\e[39m"

TIMEOUT=10

printf() {
	command printf "$@" >&2
}

check_updates() {
	local output status

	output=$(dnf check-update)
	UPDATES=$?

	if ((UPDATES != 0 && UPDATES != 100)); then
		FAILED=true
    notify-send "Error when checking updates"
		return 1
	fi

  if ((UPDATES == 0)); then
    notify-send "No updates available"
  else 
    notify-send "Available updates"
  fi
}

update_packages() {
	printf "%bUpdating packages...%b\n" "$FG_BLUE" "$FG_RESET"

  sudo dnf upgrade --refresh

	notify-send "Update Complete" -i "package-install"

	printf "\n%bUpdate complete!%b\n" "$FG_GREEN" "$FG_RESET"

	read -rsn 1 -p "Press any key to exit..."
}

display_module() {
	local icon tooltip

  if ((FAILED = true)); then
		icon='󰒑'
		tooltip="<b>Failed to fetch updates</b>\nRight-click to retry"
  elif ((UPDATES == 0)); then
		icon='󰸟'
		tooltip="No updates available"
  else
		icon='󰄠'
		tooltip="<b>DNF</b>: $UPDATES"
	fi

	cat <<- EOF
		{ "text": "$icon", "tooltip": "$tooltip" }
	EOF
}

main() {
	FAILED=false
	UPDATES=0

	get_helper

	case $1 in
    check)
      check_updates
      display_module
      ;;
		*)
			# Update the module on exit
			trap "pkill -RTMIN+1 waybar" EXIT

			printf "%bChecking for updates...%b\n" "$FG_BLUE" "$FG_RESET"

			check_updates
			update_packages
      display_module
			;;
	esac
}

main "$@"
