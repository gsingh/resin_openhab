FROM resin/rpi-raspbian:jessie

# Install OpenJDK 7
# Remove package lists to free up space
RUN apt-get update && apt-get install -y openjdk-7-jdk wget build-essential && rm -rf /var/lib/apt/lists/* 

RUN wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key && apt-key add mosquitto-repo.gpg.key
RUN rm mosquitto-repo.gpg.key

# RUN cd /etc/apt/sources.list.d/
RUN wget --directory-prefix /cd/apt/sources.list.d/ http://repo.mosquitto.org/debian/mosquitto-wheezy.list  && sudo apt-get update
RUN apt-get install -y mosquitto mosquitto-clients \
	build-essential \
	libncurses5-dev \
	supervisor
# RUN echo_supervisord_conf
	# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD supervisord.conf /etc/supervisor/conf.d/

ADD ./install.sh /tmp/install.sh
RUN /bin/sh /tmp/install.sh
# ADD rf24libs /home/rf24libs
# COPY startRF.sh /App/startRF.sh
# RUN echo ls /home/rf24libs && /
 # echo ls /home/rf24libs/RF24

# WORKDIR /home/rf24libs
# RUN apt-get install -y build-essential && apt-get install -y libncurses5-dev
# RUN make install --directory=/home/rf24libs/RF24/ && \
# 	make install --directory=/home/rf24libs/RF24Network/ && \ 
# 	make install --directory=/home/rf24libs/RF24Mesh/  && \
# 	make install --directory=/home/rf24libs/RF24Gateway/
# RUN make -B --directory=/home/rf24libs/RF24Gateway/examples/ncurses/
# RUN wget https://github.com/gsingh/resin_openhab/blob/master/install.sh
# RUN chmod +x install.sh
# RUN /bin/bash /install.sh
# RUN rm install.sh

RUN wget --directory-prefix /home/rf24libs http://www.homeautomationforgeeks.com/code/hareceiver.cpp
RUN	wget --directory-prefix /home/rf24libs http://www.homeautomationforgeeks.com/code/Makefile
ADD rf24libs /home/rf24libs

# RUN cd /home/rf24libs/
# RUN /bin/bash /home/rf24libs/hareceiver

# RUN make -B --directory=/home/rf24libs/
# cd /home/rf24libs
# chmod +x /home/rf24libs/hareceiver

ADD . /App/

RUN chmod +x /App/start.sh
RUN chmod +x /App/startRF.sh

EXPOSE 80
EXPOSE 443
# Install the UPS Support
RUN dpkg -i /App/ups/upsd_1.2-1.deb
 
# mv /App/start.sh /start.sh
CMD ["/usr/bin/supervisord"]
# CMD ["bash", "/App/start.sh"]
