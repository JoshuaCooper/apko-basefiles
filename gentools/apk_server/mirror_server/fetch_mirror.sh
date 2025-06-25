#!/bin/sh
CGR_REPO=https://apk.cgr.dev/chainguard/x86_64/APKINDEX.tar.gz
WOLFI_REPO=https://packages.wolfi.dev/os

mkdir /work/workingfiles
mkdir /work/packages

wget https://apk.cgr.dev/chainguard/x86_64/APKINDEX.tar.gz -O /work/workingfiles/APKINDEX.tar.gz
tar -xf /work/workingfiles/APKINDEX.tar.gz -C /work/workingfiles/

#for package in $(cat /tmp/workingfiles/APKINDEX | grep P: | sed 's/^P://'D)
for package in $(cat /work/workingfiles/APKINDEX | grep P: | cut -d':' -f2-)
do
	#apk fetch --repository="$WOLFI_REPO" --simulate --output /work/packages "$package"
	echo $package
	#apk fetch --repository=https://packages.wolfi.dev/os "$package" --output /work/packages/
	apk fetch --arch=x86_64 --allow-untrusted --repository=https://packages.wolfi.dev/os "$package" --output /work/packages/ --no-cache --no-check-certificate
done 
