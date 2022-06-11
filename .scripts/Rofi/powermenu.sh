# #!/usr/bin/env bash

# Determine `systemd-logind` or `(e)logind`.
if [ -x "$(command -v systemctl)" ]; then
    SEATCTL='systemctl'
elif [ -x "$(command -v loginctl)" ]; then
    SEATCTL='loginctl'
else
    echo "failed"
fi

uptime=$(uptime -p | sed 's/up //' | sed 's/\ years\?,/y/' | sed 's/\ weeks\?,/w/' | sed 's/\ days\?,/d/' | sed 's/\ hours\?,\?/h/' | sed 's/\ minutes\?/m/')
ROFI="rofi -theme ~/.scripts/Rofi/themes/power.rasi" 

A='' B='' C='' D='' E=''

MENU="$(printf "${A}\n${B}\n${C}\n${D}\n${E}\n" | ${ROFI} -dmenu -p "Up - $uptime" -selected-row 0)"

case "$MENU" in
    "$A") exec "${HOME}/.scripts/Rofi/promptmenu.sh" --yes-command "${SEATCTL} poweroff" -q 'ShutDown?'
    ;;
    "$B") exec "${HOME}/.scripts/Rofi/promptmenu.sh" --yes-command "${SEATCTL} reboot" -q 'Reboot?'
    ;;
    "$C") betterlockscreen -l
    ;;
    "$D") if [[ "$("$MUSIC_CONTROLLER" status)" = *'laying'* ]]; then
              "$MUSIC_CONTROLLER" toggle
          fi
          exec "$SEATCTL" suspend
    ;;
    "$E") exec "${HOME}/.scripts/Rofi/promptmenu.sh" --yes-command "pkill -KILL -u $(id -nu || whoami)" -q 'Logout?'
    ;;
esac 

exit ${?}