#!/bin/sh
# make commands for rf24 libraries and 
# to compile and run hareceiver in raspi.

 make install --directory=/home/rf24libs/RF24/ && \
    make install --directory=/home/rf24libs/RF24Network/ && \ 
	make install --directory=/home/rf24libs/RF24Mesh/  && \
	make install --directory=/home/rf24libs/RF24Gateway/

 make -B --directory=/home/rf24libs/RF24Gateway/examples/ncurses/ && \
 make -B --directory=/home/rf24libs/

cd /home/rf24libs
chmod +x /home/rf24libs/hareceiver
./hareceiver


 # ./hareceiver