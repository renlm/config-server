#!/usr/bin/env bash
# https://github.com/graalvm/graalvm-ce-builds/releases
# https://www.graalvm.org/jdk21/reference-manual/native-image/guides/build-static-executables/
set -e

# Specify an installation directory for graalvm:
export GRAALVM_HOME=/usr/local/graalvm

# Unzip tar.gz
cat graalvm/package/graalvm-community-jdk-21.0.2_linux-x64_bin.tar.gz_* > graalvm-community-jdk-21.0.2.tar.gz
tar -zxvf graalvm-community-jdk-21.0.2.tar.gz -C /usr/local/ --transform="s/graalvm-community-openjdk-21.0.2+13.1/graalvm/g"
rm -fr graalvm-community-jdk-21.0.2.tar.gz

# Extend the system path and confirm that graalvm is available by printing its version
export PATH="$GRAALVM_HOME/bin:$PATH"
java --version
native-image --version
