FROM tensorflow/tensorflow:latest-gpu

MAINTAINER Rafael Palomar <rafael.palomar@rr-research.no>

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils git curl emacs-nox \
    build-essential cmake 
