FROM ubuntu:trusty
MAINTAINER Thomas Léveil <thomasleveil@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y software-properties-common python-software-properties \
    && add-apt-repository -y ppa:ubuntu-wine/ppa
    
RUN DEBIAN_FRONTEND=noninteractive dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y wine1.7 winetricks xvfb

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


