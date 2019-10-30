#!/bin/bash
DEST=$1
ARCHIVE_URI=https://github.com/linto-ai/linto-tts-module/releases/download/v0.2/linto_tts-0.1-$ARCH.tar.gz

#Install last version
echo "Downloading module TTS..."
wget -P $DEST $ARCHIVE_URI
tar xfz $DEST/${ARCHIVE_URI##*/} -C $DEST
rm $DEST/${ARCHIVE_URI##*/}

#Install picotts
wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico0_1.0+git20130326-9_armhf.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico-utils_1.0+git20130326-9_armhf.deb
apt-get install -fy ./libttspico0_1.0+git20130326-9_armhf.deb ./libttspico-utils_1.0+git20130326-9_armhf.deb

rm libttspico0_1.0+git20130326-9_armhf.deb 
rm libttspico-utils_1.0+git20130326-9_armhf.deb