FROM ubuntu:18.04

LABEL maintainer="Alexis Ahmed"

RUN groupadd -r alexis && useradd -r -g alexis kinjal

# Environment Variables
ENV HOME /home/alexis
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y openssh-server

RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

RUN /bin/sh -c /bin/sh -c ssh-keygen -t rsa 

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]