FROM sylvainlasnier/ubuntu
MAINTAINER  Sylvain Lasnier <sylvain.lasnier@gmail.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install openssh-server supervisor

# Setup ssh environement
RUN mkdir -p /var/run/sshd
RUN chmod 755 /var/run/sshd

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config


# Setup root password as root
RUN echo root:root | chpasswd


EXPOSE 22

# supervisor drive lthe daemon
CMD ["/usr/local/bin/supervisord","-n"]