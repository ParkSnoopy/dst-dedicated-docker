FROM sunwoo2539/steamcmd-nonroot:debian-12

LABEL name="dont_starve_together-dedicated-docker"
LABEL version="v0.1.0"
LABEL description="Don't Starve Together dedicated server docker"
LABEL repository="https://github.com/ParkSnoopy/dst-dedicated-docker.git"
LABEL license="MIT"
LABEL authors="[ ParkSnoopy <ParkSnoopy@users.noreply.github.com> ]"

USER root
RUN \
	apt update				&&\
	apt upgrade -y				&&\
	apt install -y --no-install-recommends	\
		ca-certificates			\
		lib32stdc++6			\
		libcurl3-gnutls:i386		\
		libcurl3-gnutls			&&\
	rm -rf /var/lib/apt/lists/*

USER steam
WORKDIR /home/steam

RUN \
	mkdir -p .klei/DoNotStarveTogether server_dst/mods

VOLUME ["/home/steam/.klei/DoNotStarveTogether", "/home/steam/server_dst/mods"]

##
COPY ["start-container-server.sh", "/home/steam/"]
ENTRYPOINT ["/home/steam/start-container-server.sh"]
