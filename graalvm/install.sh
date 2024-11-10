#!/bin/sh

set +e

# Init
sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
apt update
apt install -y build-essential zlib1g-dev

# Graalvm
. ./graalvm/setup-graalvm.sh

# Maven
. ./graalvm/setup-maven.sh

# Musl
. ./graalvm/setup-musl.sh

# Upx
. ./graalvm/setup-upx.sh
