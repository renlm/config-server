#!/bin/sh

set +e

# Xz
# https://yum.oracle.com/repo/OracleLinux/OL9/baseos/latest/x86_64/index.html
rpm -ivh graalvm/package/xz-5.2.5-8.el9_0.x86_64.rpm

# Maven
source ./graalvm/setup-maven.sh

# Musl
source ./graalvm/setup-musl.sh

# Upx
source ./graalvm/setup-upx.sh