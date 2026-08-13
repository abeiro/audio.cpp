#!/bin/bash

REPO_DIR="/home/dwemer/audio.cpp"

clear
cat << EOF
PocketTTS audio.cpp

This configures the C++ PocketTTS runtime. Python is only used by the installer
to download the model; the running TTS server is build/bin/audiocpp_server.

EOF

if [ ! -x "$REPO_DIR/build/bin/audiocpp_server" ]; then
    echo "Error: audio.cpp is not built. Run /usr/local/bin/install_audiocpp_pockettts first."
    exit 1
fi

while true; do
    echo "Select an option from the list:"
    echo
    echo "1. Enable service"
    echo "0. Disable service"
    echo

    read -r -p "Select an option by picking the matching number: " selection

    case "$selection" in
        0)
            rm "$REPO_DIR/start.sh" &>/dev/null || true
            echo "[OK] PocketTTS audio.cpp disabled"
            exit 0
            ;;
        1)
            ln -sf "$REPO_DIR/start-audiocpp-pockettts.sh" "$REPO_DIR/start.sh"
            echo "[OK] PocketTTS audio.cpp enabled"
            exit 0
            ;;
        *)
            echo "Invalid selection. Enter 0 or 1."
            echo
            ;;
    esac
done
