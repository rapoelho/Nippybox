#!/usr/bin/env bash

## Copyright (C) 2020-2024 Aditya Shakya <adi1090x@gmail.com>

# Colors
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CDIR=`cd "$DIR" && cd .. && pwd`

# Checks if bluetooth controller is powered on
power_on() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        return 0
    else
        return 1
    fi
}

# Checks if a device is connected
device_connected() {
    device_info=$(bluetoothctl info "$1")
    if echo "$device_info" | grep -q "Connected: yes"; then
        return 0
    else
        return 1
    fi
}

# Prints a short string with the current bluetooth status
# Useful for status bars like polybar, etc.
print_status() {
    if power_on; then
		if [[ -z `bluetoothctl info "$device" | grep "Alias" | cut -d ' ' -f 2-` ]]; then
			#echo "%{F$POWER_ON}%{T1}%{T-} %{F-}ON"
			echo "  ON"
		fi
		
        paired_devices_cmd="devices Paired"

        mapfile -t paired_devices < <(bluetoothctl $paired_devices_cmd | grep Device | cut -d ' ' -f 2)
        counter=0

        for device in "${paired_devices[@]}"; do
            if device_connected "$device"; then
                device_alias=$(bluetoothctl info "$device" | grep "Alias" | cut -d ' ' -f 2-)

                if [ $counter -gt 0 ]; then
                    echo " $device_alias"
                else
                    echo " $device_alias"
                fi

                ((counter++))
            fi
        done
    else
        echo " OFF"
    fi
}

# Print Status
print_status
