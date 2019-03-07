# base image
FROM alpine:3.8
LABEL maintainer "Sleepy Mario <theonesleepymario@gmail.com>"

# environment variables
ARG PV=10

# install dependencies
RUN apk add --no-cache make g++ wget ca-certificates

# fetch and compile stockfish
RUN mkdir -p /root/tmp && \
	cd /root/tmp && \
	wget https://github.com/official-stockfish/Stockfish/archive/sf_${PV}.tar.gz && \
	tar xvf /root/tmp/sf_${PV}.tar.gz && \
	cd /root/tmp/Stockfish-sf_${PV}/src && \
	make build ARCH=x86-64-modern && \
	mv /root/tmp/Stockfish-sf_${PV}/src/stockfish /usr/local/bin/stockfish

# remove leftovers
RUN apk del --no-cache wget ca-certificates
RUN rm -rf /root/tmp

# run stockfish
ENTRYPOINT /usr/local/bin/stockfish
