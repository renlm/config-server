#!/usr/bin/env bash
# https://www.graalvm.org/jdk21/reference-manual/native-image/guides/build-static-executables/
# https://github.com/graalvm/graalvm-demos/blob/master/tiny-java-containers/setup-musl.sh
set -e

# Specify an installation directory for musl:
tar -xzf graalvm/package/x86_64-linux-musl-native.tgz -C /usr/local/ --transform="s/x86_64-linux-musl-native/musl-toolchain/g"

# Extend the system path and confirm that musl is available by printing its version
export MUSL_HOME=/usr/local/musl-toolchain
export PATH="$MUSL_HOME/bin:$PATH"
x86_64-linux-musl-gcc --version

# Build zlib with musl from source and install into the MUSL_HOME directory
tar -xzvf graalvm/package/zlib-1.2.11.tar.gz -C .
cd zlib-1.2.11
CC=$MUSL_HOME/bin/x86_64-linux-musl-gcc ./configure --prefix=$MUSL_HOME --static
make
make install
cd ..

# Delete source
rm -rf zlib-1.2.11
