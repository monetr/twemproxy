FROM gcc:9.4.0

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
