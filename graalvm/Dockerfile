FROM ubuntu:22.04 as builder
ADD . /build
WORKDIR /build
ARG PROFILES_ACTIVE
ENV PROFILES_ACTIVE ${PROFILES_ACTIVE}
RUN \
  . ./graalvm/install.sh \
  && mvn clean -Pnative -P ${PROFILES_ACTIVE} native:compile

FROM alpine
COPY --from=builder "/build/target/config-server" server
RUN touch /server
EXPOSE 7001
EXPOSE 9001
ARG PROFILES_ACTIVE
ENV PROFILES_ACTIVE ${PROFILES_ACTIVE}
ENTRYPOINT ["sh","-c","./server"]