FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

MAINTAINER Rafael Palomar <rafael.palomar@rr-research.no>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils git curl emacs-nox\
    build-essential cmake \
    python3-pip\
    python3-opencv\
    python3-tk\
    libnvidia-compute-390\
    sudo

RUN pip3 install setuptools
RUN pip3 install pandas\
		 nibabel\
		 imgaug\
		 tensorflow-gpu==1.13.0rc0\
		 scipy\
		 scikit-image\
		 keras\
		 sklearn

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

