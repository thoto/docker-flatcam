FROM ubuntu:groovy

RUN apt-get update -y && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		git ca-certificates sudo python3-serial freeglut3-dev && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		libfreetype6 libfreetype6-dev libgeos-dev libpng-dev \
		libspatialindex-dev qt5-style-plugins python3-dev python3-gdal \
		python3-pip python3-pyqt5 python3-pyqt5.qtopengl python3-simplejson \
		python3-tk && \
	apt-get clean && rm -rf /var/lib/apt/lists/* 

RUN git clone -b Beta --depth 1 https://bitbucket.org/jpcgt/flatcam /flatcam

WORKDIR /flatcam

RUN apt-get update -y && export DEBIAN_FRONTEND=noninteractive && \
	bash -c "source ./setup_ubuntu.sh" && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m flatcam

USER flatcam
WORKDIR /home/flatcam
RUN mkdir ~data

CMD [ "python3", "/flatcam/FlatCAM.py" ]
