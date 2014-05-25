FROM ubuntu:trusty
MAINTAINER Thomas Léveil <thomasleveil@gmail.com>


## setup APT
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse' /etc/apt/sources.list
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse' /etc/apt/sources.list
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive

## Install dependencies
RUN apt-get install -y software-properties-common python-software-properties

## Wine
RUN add-apt-repository -y ppa:ubuntu-wine/ppa
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y wine1.7 
RUN apt-get install -y winetricks xvfb

## SteamCMD
RUN useradd --home-dir /home/steam --create-home steam
RUN apt-get install --no-install-recommends -y \
    ca-certificates \
    lib32gcc1 \
    curl 
RUN mkdir -p /home/steam/steamcmd  && \
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -v -C /home/steam/steamcmd -zx && \
    chown -R steam:steam /home/steam

# Clean up when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


USER steam

## Update steamcmd
RUN /home/steam/steamcmd/steamcmd.sh +quit

WORKDIR /home/steam/steamcmd
CMD ["/home/steam/steamcmd/steamcmd.sh"]


