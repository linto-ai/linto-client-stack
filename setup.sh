#!/bin/bash

usage () {
	echo "Install LinTO modules"
	echo "Usage is:"
	echo "sudo ./setup.sh [--help | target_directory]"
	echo "Default target directory is HOME"
	exit 1
}

if [ "$1" = "--help" ]
then
	usage
fi

if [ -z "$1" ]
then
	TARGET_DIR=$HOME
elif [ ! -d "$1" ]
then
	echo "ERROR: Specified directory does not exist"
	exit 1
else
	TARGET_DIR="$1"
fi

echo "Target directory is $TARGET_DIR"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ "$USER" != "root" ]; then
	echo "ERROR: Script must be run as root"
	exit 1
fi

echo "The script will now install the client modules on the device ..."
echo "Installing dependencies ..."
sudo apt-get install -y portaudio19-dev libasound2-dev python3-pip libttspico-utils sox wget tar git

if [ ! $ARCH ]
then
	ARCH="$(arch)"
fi

if [ $ARCH != "armv7l" ] && [ $ARCH != "x86_64" ]
then
	echo "ERROR: Supported architures are armv7l and x86_64 ($ARCH detected)"
	exit 1
fi
echo "Detected architecture is $ARCH"
export ARCH

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

echo "SUCCESS: Modules have been successfully downloaded"

if  [ $ARCH = "armv7l" ]
then
	echo "Copying services ..."
	cp $DIR/services/linto_ui.service /lib/systemd/system/
	cp $DIR/services/linto_tts.service /lib/systemd/system/
	cp $DIR/services/linto_command.service /libash get argumentsb/systemd/system/

	echo "Enabling services ..."
	systemctl daemon-reload
	systemctl enable linto_ui linto_tts linto_command

	echo "... DONE (Reboot needed to start the modules)"
fi


