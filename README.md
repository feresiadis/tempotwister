# tempotwister

A Bash script to control MP3 playback with tempo adjustment and navigation using keyboard controls.

Description

TempoTuner is a command-line MP3 player for Linux that emulates the functionality of the Pacemaker plugin for Winamp. It allows users to:

    Play MP3 files with real-time tempo adjustment.
    Control playback using intuitive keyboard shortcuts.
    Navigate through audio tracks with ease.
    Continuously display the current tempo rate and playback time.

This script is ideal for musicians, language learners, or anyone who needs to adjust the playback speed of audio files without affecting the pitch.
Features

    Tempo Adjustment: Increase or decrease the playback speed using the Up and Down arrow keys.
    Playback Navigation: Fast-forward and rewind through the track using the Right and Left arrow keys.
    Play/Pause Control: Toggle playback with the Space Bar.
    Track Selection: Choose an MP3 file from any directory.
    Status Display: Continuously shows the current tempo rate and playback time.
    Simple Interface: Easy-to-use keyboard controls in a terminal environment.

Installation of Dependencies

Ensure you have the following installed on your Linux system:

    mpv: A media player that supports various audio and video formats.
    socat: A utility for data transfer between two bidirectional data streams.

    For Debian/Ubuntu-based systems:
    sudo apt-get update
    sudo apt-get install mpv socat

    For CentOS/RHEL-based systems:
    sudo yum install epel-release
    sudo yum install mpv socat

    For Arch Linux:
    sudo pacman -S mpv socat

Instructions to run the script:

    Make sure to place this script in a directory that contains your MP3 files or adjust the script to point to the correct directory.
    Default Directory:
    If you frequently use the same directory, you can set a default directory in the script by modifying the line: read -e mp3_dir
    Make the Script Executable: chmod +x tempotwister.sh
    Run the Script: ./tempotwister.sh

User Guide

    Select an MP3 File:
    The script will display a numbered list of MP3 files in the directory you specified.
    At the prompt #?, enter the number corresponding to the MP3 file you wish to play, then press Enter.

    Control Playback:
    Up Arrow (↑): Increase tempo by 0.1x.
    Down Arrow (↓): Decrease tempo by 0.1x.
    Right Arrow (→): Fast-forward 10 seconds.
    Left Arrow (←): Rewind 10 seconds.
    Space Bar (Space): Play/Pause the track.
    Quit (q): Exit the player.
    Upon exiting (pressing q or Ctrl+C), the script will clean up by:
    Killing the mpv process.
    Removing the IPC socket.
    Resetting the terminal settings.

    Status Display:
    Tempo Rate: 1.2x | Time: 00:45/03:30

Adjustable Parameters

    Tempo Step:
    Modify the tempo adjustment step by changing the values in the script:
    # Increase tempo by 0.1x
    echo '{"command": ["add", "speed", 0.1]}' | socat - "$socket_path" 2>/dev/null

    # Decrease tempo by 0.1x
    echo '{"command": ["add", "speed", -0.1]}' | socat - "$socket_path" 2>/dev/null
    
    Seek Time:
    Change the fast-forward and rewind intervals:
    # Fast-forward 10 seconds
    echo '{"command": ["seek", 10]}' | socat - "$socket_path" 2>/dev/null

    # Rewind 10 seconds
    echo '{"command": ["seek", -10]}' | socat - "$socket_path" 2>/dev/null

Troubleshooting
    
    No MP3 Files Found:
    Ensure the directory you entered contains MP3 files. The script looks for files with the .mp3 extension.
    
    Controls Not Responding:
    Make sure the terminal window is active and that you're using the correct keys as per the controls summary.

    Script Exits Immediately:
    Check for any error messages regarding missing dependencies or incorrect directory paths.

Acknowledgments

    mpv: For providing a versatile media player with IPC capabilities.

    socat: For enabling communication between processes.

    Inspiration: Based on the functionality of the Pacemaker plugin for Winamp.

    





    

