#!/bin/sh
# https://github.com/upx/upx/releases
# https://github.com/graalvm/graalvm-demos/blob/master/tiny-java-containers/setup-upx.sh

set -e

UPX_VERSION=4.2.4
UPX_ARCHIVE=upx-${UPX_VERSION}-amd64_linux.tar.xz 

tar -xJf graalvm/package/${UPX_ARCHIVE} -C .
mv upx-${UPX_VERSION}-amd64_linux/upx /usr/bin
rm -rf upx-${UPX_VERSION}-amd64_linux
chmod +x /usr/bin/upx
