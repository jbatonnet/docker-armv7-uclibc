FROM --platform=linux/arm/v7 scratch

ADD buildroot/rootfs.tar.gz /
RUN python -m ensurepip
RUN python -m pip install --upgrade pip

ENV TZ=UTC
ENV LD_LIBRARY_PATH=/lib:/usr/lib:$LD_LIBRARY_PATH
ENV PATH=/bin:/usr/bin:/usr/libexec/gcc/arm-buildroot-linux-uclibcgnueabihf/11.4.0:$PATH
ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++
ENV AR=/usr/bin/ar
ENV PYTHONPATH=

CMD ["/bin/sh"]
