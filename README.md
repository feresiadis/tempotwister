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

Installation

    

