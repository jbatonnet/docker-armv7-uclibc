
FROM debian:12.8

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y build-essential bash bc binutils build-essential bzip2 cpio g++ gcc git gzip locales libncurses5-dev libdevmapper-dev libsystemd-dev make mercurial whois patch perl python3 rsync sed tar vim unzip wget bison flex libssl-dev libfdt-dev file && \
    rm -rf /var/lib/apt/lists/*

# Sometimes Buildroot need proper locale, e.g. when using a toolchain based on glibc
RUN locale-gen en_US.utf8

WORKDIR /buildroot
RUN git clone https://gitlab.com/buildroot.org/buildroot.git --depth=1 --branch=2023.02.6 /buildroot

COPY gcc-target.patch /buildroot/
RUN git apply gcc-target.patch
