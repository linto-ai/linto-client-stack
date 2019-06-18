#!/bin/bash
ARCHIVE_URI=https://github.com/linto-ai/linto-command-module/releases/download/v0.1/linto-command-0.1-$ARCH.tar.gz

#Install last version
echo "Downloading module COMMAND..."
wget $ARCHIVE_URI
tar xfz ${ARCHIVE_URI##*/}
rm ${ARCHIVE_URI##*/}