FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get install -y tzdata
RUN apt-get install -y build-essential make gcc
RUN apt-get install -y git
RUN apt-get install -y texlive-full 

WORKDIR /work

RUN git clone https://github.com/ImageMagick/ImageMagick --depth 1 --branch 7.1.1-21
RUN cd ImageMagick && ./configure && make -j && make install && ldconfig /usr/local/lib

RUN cpan App::cpanminus
RUN cpanm Image::Magick
RUN cpanm LaTeXML -v

LABEL org.opencontainers.image.source=https://github.com/anurudhp/latexml-docker
LABEL org.opencontainers.image.description="LaTeXML docker"
LABEL org.opencontainers.image.licenses=MIT
