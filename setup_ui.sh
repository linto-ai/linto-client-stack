#!/bin/bash
ARCHIVE_URI=https://github.com/linto-ai/linto-ui-module/releases/download/v0.1/linto_ui-0.1-armv7l.tar.gz

#Install last version
echo "Downloading module UI..."
wget $ARCHIVE_URI
tar xfz ${ARCHIVE_URI##*/}
rm ${ARCHIVE_URI##*/}