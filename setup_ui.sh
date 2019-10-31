#!/bin/bash
DEST=$1
REPO_URL=linto-ai/linto-ui-module
LATEST_TAG=$(curl --silent "https://github.com/$REPO_URL/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#';)
VERSION=$(echo $LATEST_TAG | sed -e "s/v//")
ARCHIVE_URI=https://github.com/$REPO_URL/releases/download/$LATEST_TAG/linto_ui-$VERSION-$ARCH.tar.gz

#Install last version
echo "Downloading $ARCHIVE_URI"
wget -P $DEST $ARCHIVE_URI
tar xfz $DEST/${ARCHIVE_URI##*/} -C $DEST
rm $DEST/${ARCHIVE_URI##*/}