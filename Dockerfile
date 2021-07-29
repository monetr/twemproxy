FROM gcc:11.2.0 AS builder

COPY ./twemproxy /usr/src/twemproxy
WORKDIR /usr/src/twemproxy
RUN \
  autoreconf -h && \
  autoreconf -fvi && \
  ./configure && \
  make && \
  make install

FROM debian:bullseye

COPY --from=builder /usr/local/sbin/nutcracker /bin/nutcracker

ENTRYPOINT [ "nutcracker" ]
