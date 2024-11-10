FROM ubuntu:22.04
ADD . /build
WORKDIR /build
RUN . ./graalvm/install.sh

FROM ubuntu:22.04
WORKDIR /build
RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && apt update \
    && apt install -y build-essential zlib1g-dev
COPY --from=0 "/usr/local/graalvm" /usr/local/graalvm
COPY --from=0 "/usr/local/maven" /usr/local/maven
COPY --from=0 "/usr/local/musl-toolchain" /usr/local/musl-toolchain
COPY --from=0 "/usr/bin/upx" /usr/bin
ENV GRAALVM_HOME=/usr/local/graalvm
ENV MAVEN_HOME=/usr/local/maven
ENV MUSL_HOME=/usr/local/musl-toolchain
ENV PATH=$GRAALVM_HOME/bin:$MAVEN_HOME/bin:$MUSL_HOME/bin:$PATH