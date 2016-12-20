FROM ubuntu
MAINTAINER Doug Land <dland@ojolabs.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y default-jre-headless wget bzip2
RUN cd /opt; wget https://github.com/riemann/riemann/releases/download/0.2.12/riemann-0.2.12.tar.bz2 ; tar xvfj riemann-0.2.12.tar.bz2

# Expose the ports for inbound events and websockets
EXPOSE 5555
EXPOSE 5555/udp
EXPOSE 5556

# Share the config directory as a volume
VOLUME /etc/riemann
ADD riemann.config /etc/riemann/riemann.config

# Set the hostname in /etc/hosts so that Riemann doesn't die due to unknownHostException
CMD echo 127.0.0.1 $(hostname) > /etc/hosts; /opt/riemann-0.2.12/bin/riemann /etc/riemann/riemann.config
