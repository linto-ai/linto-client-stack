#!/bin/bash
DEST=$1
REPO_URL=linto-ai/linto-tts-module
LATEST_TAG=$(curl --silent "https://github.com/$REPO_URL/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#';)
VERSION=$(echo $LATEST_TAG | sed -e "s/v//")

if [ $ARCH = "armv7l" ] 
then
    RELEASE=-$(lsb_release -a | grep Codename | sed -e "s/Codename:[ |\t]*//")
fi

echo "Getting command module version $LATEST_TAG for $ARCH on $RELEASE"
ARCHIVE_URI=https://github.com/$REPO_URL/releases/download/$LATEST_TAG/linto_tts-$VERSION-$ARCH$RELEASE.tar.gz

#Install last version
echo "Downloading $ARCHIVE_URI"
wget -P $DEST $ARCHIVE_URI
tar xfz $DEST/${ARCHIVE_URI##*/} -C $DEST
rm $DEST/${ARCHIVE_URI##*/}

#Install picotts
wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico0_1.0+git20130326-9_armhf.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico-utils_1.0+git20130326-9_armhf.deb
apt-get install -fy ./libttspico0_1.0+git20130326-9_armhf.deb ./libttspico-utils_1.0+git20130326-9_armhf.deb

rm libttspico0_1.0+git20130326-9_armhf.deb 
rm libttspico-utils_1.0+git20130326-9_armhf.deb