#!/bin/bash
TARGET_DIR=/home/pi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ "$USER" != "root" ]; then
	echo "Script must be run as root"
	exit 1
fi

echo "The script will now install the client modules on the device ..."
echo "Installing dependencies ..."
sudo apt-get install -y portaudio19-dev libasound2-dev python3-pip libttspico-utils sox wget tar git

cd $TARGET_DIR
# UI MODULE
$DIR/setup_ui.sh

# TTS_MODULE
$DIR/setup_tts.sh

# COMMAND MODULE 
$DIR/setup_command.sh

#MODEL
git clone https://github.com/linto-ai/linto-models.git
rm -rf model
mv linto-models model

echo "Copying services ..."
cp $DIR/services/linto_ui.service /lib/systemd/system/
cp $DIR/services/linto_tts.service /lib/systemd/system/
cp $DIR/services/linto_command.service /lib/systemd/system/

echo "Enabling services ..."
systemctl daemon-reload
systemctl enable linto_ui linto_tts linto_command

echo "... DONE (Reboot needed to start the modules)"