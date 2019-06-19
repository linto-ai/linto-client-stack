#!/bin/bash
ARCHIVE_URI=https://github.com/linto-ai/linto-tts-module/releases/download/v0.2/linto_tts-0.1-$ARCH.tar.gz

#Install last version
echo "Downloading module TTS..."
wget $ARCHIVE_URI
tar xfz ${ARCHIVE_URI##*/}
rm ${ARCHIVE_URI##*/}
