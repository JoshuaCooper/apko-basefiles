#!/bin/sh
WOLFI_REPO=https://packages.wolfi.dev/os
PKGS="bash curl busybox"
 
for pkg in $PKGS; do
  apk fetch --repository="$WOLFI_REPO" --simulate --output /tmp "$pkg"
done
