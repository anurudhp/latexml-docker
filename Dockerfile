FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get install -y tzdata
RUN apt-get install -y build-essential make gcc
RUN apt-get install -y git
RUN apt-get install -y texlive-full 

WORKDIR /work

# ImageMagick deps: https://github.com/ImageMagick/ImageMagick/issues/6148#issuecomment-1474244740
RUN apt-get purge -y *magick*
RUN apt-get install -y gsfonts libbz2-dev libdjvulibre-dev libexif-dev libfftw3-dev libfontconfig1-dev \
		libfreetype6-dev libheif-dev libjpeg-dev liblcms2-dev liblqr-1-0-dev libltdl-dev liblzma-dev \
		libopenexr-dev libopenjp2-7-dev libpango1.0-dev libperl-dev libpng-dev librsvg2-dev librsvg2-bin \
		libtiff-dev libwebp-dev libwmf-dev libx11-dev libxext-dev libxml2-dev libxt-dev zlib1g-dev \
		doxygen doxygen-latex graphviz jdupes libxml2-utils xsltproc

RUN git clone https://github.com/ImageMagick/ImageMagick --depth 1 --branch 7.1.1-21
RUN cd ImageMagick && ./configure --with-modules --enable-shared && make -j && make install && make distclean && ldconfig /usr/local/lib

RUN cpan App::cpanminus
RUN cpanm Image::Magick
RUN cpanm LaTeXML -v

LABEL org.opencontainers.image.source=https://github.com/anurudhp/latexml-docker
LABEL org.opencontainers.image.description="LaTeXML docker"
LABEL org.opencontainers.image.licenses=MIT
