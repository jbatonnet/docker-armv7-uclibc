I could not find a Docker image ready for ARMv7 and uclibc. So here is one

### 1. Build the root filesystem using Buildroot

```
docker build -t ghcr.io/jbatonnet/docker-armv7-uclibc/buildroot -f buildroot/Dockerfile buildroot
docker run --rm -it -v .\buildroot\.config:/buildroot/.config -v .\buildroot\busybox.config:/buildroot/busybox.config -v .\buildroot:/work ghcr.io/jbatonnet/docker-armv7-uclibc/buildroot /work/build-rootfs.sh
```

### 2. Build the final Docker image

```
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker build --platform=linux/arm/v7 -t ghcr.io/jbatonnet/armv7-uclibc .
docker push ghcr.io/jbatonnet/armv7-uclibc
```

Optional: Tag it for Rinkhals

```
docker tag ghcr.io/jbatonnet/armv7-uclibc ghcr.io/jbatonnet/armv7-uclibc:rinkhals
docker push ghcr.io/jbatonnet/armv7-uclibc:rinkhals
```

### 3. Use it to build anything ARMv7 with uclibc

```
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker run --platform=linux/arm/v7 --rm -it -v .\:/work ghcr.io/jbatonnet/armv7-uclibc
```

Example to build some Python packages:

```
cd /work

rm -rf lib

python -m venv .
. bin/activate

python -m pip install -r requirements.txt

rm -rf bin
rm -rf include
rm -rf lib/python3.*/site-packages/_distutils_hack
rm -rf lib/python3.*/site-packages/pip
rm -rf lib/python3.*/site-packages/pip*
rm -rf lib/python3.*/site-packages/pkg_resources
rm -rf lib/python3.*/site-packages/setuptools
rm -rf lib/python3.*/site-packages/setuptools*
rm -f lib/python3.*/site-packages/distutils-precedence.pth
rm -f pyvenv.cfg
find lib/python3.* -name '*.pyc' -type f | xargs rm
```
