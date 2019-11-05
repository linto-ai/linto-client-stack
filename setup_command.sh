#!/bin/bash
DEST=$1
REPO_URL=linto-ai/linto-command-module
LATEST_TAG=$(curl --silent "https://github.com/$REPO_URL/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#';)
VERSION=$(echo $LATEST_TAG | sed -e "s/v//")

if [ $ARCH = "armv7l" ] 
then
    RELEASE=-$(lsb_release -a | grep Codename | sed -e "s/Codename:[ |\t]*//")
fi

echo "Getting command module version $LATEST_TAG for $ARCH on $RELEASE"
ARCHIVE_URI=https://github.com/$REPO_URL/releases/download/$LATEST_TAG/linto-command-$VERSION-$ARCH$RELEASE.tar.gz

#Install last version
echo "Downloading $ARCHIVE_URI"
wget -P $DEST $ARCHIVE_URI
echo "Extracting module to $DEST"
tar xfz $DEST/${ARCHIVE_URI##*/} -C $DEST
echo "Removing archive $DEST/${ARCHIVE_URI##*/}"
rm $DEST/${ARCHIVE_URI##*/}