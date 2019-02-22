FROM nvidia/cuda:9.0-cudnn7-devel

MAINTAINER Rafael Palomar <rafael.palomar@rr-research.no>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils emacs-nox\
    python3-pip\
    sudo\
    cuda-cublas-9-0

RUN pip3 install setuptools
RUN pip3 install pandas\
		 tensorflow-gpu\
		 scipy\
		 scikit-image\
		 keras\
		 sklearn

ENV LD_LIBRARY_PATH="${PATH}:/usr/local/cuda-9.0/targets/x86_64-linux/lib/"

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

