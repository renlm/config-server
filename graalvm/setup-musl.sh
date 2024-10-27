#!/usr/bin/env bash
# https://www.graalvm.org/latest/reference-manual/native-image/guides/build-static-executables/
# https://www.graalvm.org/jdk21/reference-manual/native-image/guides/build-static-executables/
# https://github.com/graalvm/graalvm-demos/blob/master/tiny-java-containers/setup-musl.sh
set -e

# Specify an installation directory for musl:
tar -xzf graalvm/package/x86_64-linux-musl-native.tgz -C . --transform="s/x86_64-linux-musl-native/musl-toolchain/g"
export MUSL_HOME=$PWD/musl-toolchain

# Extend the system path and confirm that musl is available by printing its version
export PATH="$MUSL_HOME/bin:$PATH"
x86_64-linux-musl-gcc --version

# Build zlib with musl from source and install into the MUSL_HOME directory
tar -xzvf graalvm/package/zlib-1.2.11.tar.gz -C .
pushd zlib-1.2.11
CC=$MUSL_HOME/bin/x86_64-linux-musl-gcc ./configure --prefix=$MUSL_HOME --static
make
make install
popd

# Delete source
rm -rf zlib-1.2.11