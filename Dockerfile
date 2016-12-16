FROM ubuntu
MAINTAINER Doug Land <dland@ojolabs.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y default-jre-headless wget bzip2 rubygems supervisor
RUN gem install --no-rdoc --no-ri riemann-client riemann-tools riemann-dash
RUN cd /opt; wget https://github.com/riemann/riemann/releases/download/0.2.12/riemann-0.2.12.tar.bz2 ; tar xvfj riemann-0.2.12.tar.bz2
RUN sed -i "s/logfile/nodaemon=true\nlogfile/g" /etc/supervisor/supervisord.conf
RUN printf "[program:riemann-dash]\ndirectory=/etc/riemann\ncommand=/usr/local/bin/riemann-dash\n" > /etc/supervisor/conf.d/riemann-dash.conf
RUN printf "[program:riemann]\ncommand=/opt/riemann-0.2.12/bin/riemann /etc/riemann/riemann.config\n" > /etc/supervisor/conf.d/riemann.conf

# Expose the ports for inbound events and websockets
EXPOSE 5555
EXPOSE 5555/udp
EXPOSE 5556
EXPOSE 4567

# Share the config directory as a volume
VOLUME /etc/riemann
ADD riemann.config /etc/riemann/riemann.config
ADD config.rb /etc/riemann/config.rb

# Set the hostname in /etc/hosts so that Riemann doesn't die due to unknownHostException
CMD echo 127.0.0.1 $(hostname) > /etc/hosts; /usr/bin/supervisord
