FROM nvcr.io/nvidia/pytorch:19.11-py3

MAINTAINER Rafael Palomar <rafael.palomar@rr-research.no>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-utils emacs-nox\
	python3-pip\
	sudo

RUN pip3 install setuptools\
	tqdm\
	opencv-python\
	torchvision
		 
# Replace 1000 with your user / group id
RUN export uid=1013 gid=1013 && \
	mkdir -p /home/developer && \
	echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
	echo "developer:x:${uid}:" >> /etc/group && \
	echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
	chmod 0440 /etc/sudoers.d/developer && \
	chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

