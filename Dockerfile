FROM nvcr.io/nvidia/tensorflow:19.06-py3

MAINTAINER Rafael Palomar <rafael.palomar@rr-research.no>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-utils emacs-nox\
	python3-pip\
	sudo\
	libsm-dev\
	libxrender-dev\
	libxext-dev

RUN pip install setuptools\
	scikit-image\
	opencv-python\
	SimpleITK\
	tqdm\
	niftynet
		 
# Replace 1000 with your user / group id
RUN export uid=1012 gid=1012 && \
	mkdir -p /home/developer && \
	echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
	echo "developer:x:${uid}:" >> /etc/group && \
	echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
	chmod 0440 /etc/sudoers.d/developer && \
	chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

