#!/usr/bin/env bash
# https://maven.apache.org/download.cgi
set -e

# Specify an installation directory for maven:
export MAVEN_HOME=/usr/local/maven

# Unzip bin
tar -xzf graalvm/package/apache-maven-3.9.9-bin.tar.gz -C /usr/local/ --transform="s/apache-maven-3.9.9/maven/g"

# Extend the system path and confirm that maven is available by printing its version
export PATH="$MAVEN_HOME/bin:$PATH"
mvn --version
