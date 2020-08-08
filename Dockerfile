# sudo docker build --tag docgs  .
FROM ubuntu:18.04
COPY . /home

# General environment setup
WORKDIR /
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install build-essential -y
RUN apt-get install wget -y
RUN apt-get install gcc-multilib g++-multilib -y

RUN apt install git -y

# install python
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# install zmq
RUN wget https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz
RUN tar xvzf zeromq-4.2.2.tar.gz
RUN apt-get install -y libtool pkg-config build-essential autoconf automake uuid-dev
WORKDIR /zeromq-4.2.2
RUN ./autogen.sh
RUN ./configure
RUN make && make install
RUN apt-get install libzmq5 -y

WORKDIR /home
RUN git submodule init
RUN git submodule update

# build CSP
WORKDIR /home/libcsp
RUN python3 waf configure --with-os=posix --enable-rdp --enable-hmac --enable-xtea --with-loglevel=debug --enable-debug-timestamp --enable-python3-bindings --with-driver-usart=linux --enable-if-zmqhub --enable-examples
RUN python3 waf build

WORKDIR /home
RUN make clean && make all
CMD ./libcsp/build/zmqproxy & ./SatelliteSim