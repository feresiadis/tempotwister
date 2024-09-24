#!/bin/bash

# Function to cleanup on exit
cleanup() {
    rm -f "$socket_path"
    kill "$mpv_pid" 2>/dev/null
    stty echo
    echo    # Move to a new line after script exit
}
trap cleanup EXIT

# Disable echo to prevent displaying typed characters
stty -echo

# Prompt user to select an MP3 file
echo "Please select an MP3 file:"
select mp3_file in *.mp3; do
    if [[ -n "$mp3_file" ]]; then
        echo "You selected $mp3_file"
        break
    else
        echo "Invalid selection. Please try again."
    fi
done

# Start mpv with IPC server
socket_path="/tmp/mpvsocket_$$"
mpv --input-ipc-server="$socket_path" "$mp3_file" > /dev/null 2>&1 &

mpv_pid=$!

# Wait for socket to be ready
while [ ! -S "$socket_path" ]; do
    sleep 0.1
done

# Function to get properties from mpv
get_property() {
    property="$1"
    response=$(echo '{"command": ["get_property", "'"$property"'"]}' | socat - "$socket_path" 2>/dev/null)
    value=$(echo "$response" | grep -oP '"data":\K[^}]*' | tr -d '",')
    echo "$value"
}

# Function to display current tempo rate and time
display_status() {
    speed=$(get_property "speed")
    time_pos=$(get_property "time-pos")
    duration=$(get_property "duration")

    # Handle empty values
    speed=${speed:-1.0}
    time_pos=${time_pos:-0}
    duration=${duration:-0}

    # Convert time_pos and duration to minutes and seconds
    time_pos_formatted=$(printf "%02d:%02d" $((${time_pos%.*} / 60)) $((${time_pos%.*} % 60)))
    duration_formatted=$(printf "%02d:%02d" $((${duration%.*} / 60)) $((${duration%.*} % 60)))

    echo -ne "\r\033[KTempo Rate: ${speed}x | Time: ${time_pos_formatted}/${duration_formatted}"
}

# Main loop to read user input and control playback
while true; do
    read -rsn1 -t 0.5 input

    if [[ $? -eq 0 ]]; then
        if [[ "$input" == $'\e' ]]; then
            # Escape sequence (arrow keys)
            read -rsn2 -t 0.1 rest
            input+="$rest"
        fi

        case "$input" in
            $'\e[A') # Up arrow - Increase tempo
                echo '{"command": ["add", "speed", 0.1]}' | socat - "$socket_path" 2>/dev/null
                ;;
            $'\e[B') # Down arrow - Decrease tempo
                echo '{"command": ["add", "speed", -0.1]}' | socat - "$socket_path" 2>/dev/null
                ;;
            $'\e[C') # Right arrow - Fast-forward
                echo '{"command": ["seek", 10]}' | socat - "$socket_path" 2>/dev/null
                ;;
            $'\e[D') # Left arrow - Rewind
                echo '{"command": ["seek", -10]}' | socat - "$socket_path" 2>/dev/null
                ;;
            ' ') # Space bar - Play/Pause
                echo '{"command": ["cycle", "pause"]}' | socat - "$socket_path" 2>/dev/null
                ;;
            q)  # Press 'q' to quit
                break
                ;;
            *)
                ;;
        esac
    fi

    display_status
done

# Cleanup
echo
