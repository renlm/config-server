FROM ubuntu:22.04
ADD . /build
WORKDIR /build
ARG PROFILES_ACTIVE
ENV PROFILES_ACTIVE ${PROFILES_ACTIVE}
RUN --mount=type=cache,target=/root/.m2 \
  . ./graalvm/install.sh \
  && mvn clean -Pnative -P ${PROFILES_ACTIVE} native:compile

FROM alpine
COPY --from=0 "/build/target/config-server" server
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && apk --no-cache add tzdata curl \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && touch /server
EXPOSE 7001
EXPOSE 9001
ARG PROFILES_ACTIVE
ENV PROFILES_ACTIVE ${PROFILES_ACTIVE}
ENTRYPOINT ["sh","-c","./server"]