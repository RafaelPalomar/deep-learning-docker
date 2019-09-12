FROM nvcr.io/nvidia/tensorflow:19.03-py3

MAINTAINER Rafael Palomar <rafael.palomar@rr-research.no>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-utils emacs-nox\
	python3-pip\
	sudo\
	libsm-dev\
	libxrender-dev\
	libxext-dev



RUN pip3 install setuptools\
	scikit-image\
	h5py\
	MedPy\
	scipy\
	Keras\
	nibabel\
	Pillow\
	torch\
	numpy==1.14.0\
	opencv-python==3.3.0.10\
	tqdm==4.19.4\
	torchvision

# Replace 1000 with your user / group id
RUN export uid=1008 gid=1008 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

