How To Work On This Repo
========================

This document describes how to use the various components of this repository
to do work, mostly without interacting with the GitHub Actions stuff at all,
so that you can quickly execute part of the pipeline locally.


## Building An Image

We use [debos](https://github.com/go-debos/debos) to build an image. For how to
install debos, please see their [instructions](https://github.com/go-debos/debos#installation-under-debian).

For running it, your host needs to be some Debian-like environment with its
tools, and ideally you have access to kvm (check `ls -l /dev/kvm` for which
group you need to be in).

### Preparing the build inputs

We need a few files:

* `debos-recipes/u-boot/idbloader.img`: SPL u-boot image, feel free to grab it
  from a previous actions run, or build it yourself from the u-boot sources.
* `debos-recipes/u-boot/u-boot.itb`: Main u-boot image, ditto on that.
* `debos-recipes/overlays/linux-kernel/yourkernelhere.deb`: A Debian-installable
  linux kernel package. You can build it on a Debian-like host (not Ubuntu 21.10
  or later for dpkg zstd reasons) with `make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc) deb-pkg`
  in a checkout of the kernel tree, provided you configured the kernel first
  with the provided config (`cp config path/to/your/clone/.config && make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- olddefconfig`),
  or just download it from a previous actions run.

### Running the build

If you want to build e.g. a Quartz64 Model A image, you can use
`debos debian-quartz64a.yaml`. For the other images, use their respective files.
The main `debian-quartz64.yaml` is not to be run directly, that gets included by
the other files.

### Writing the resulting image

Everyone has their own favourite method, but I run (as root):
`xzcat imagename.img.xz | dd of=/dev/sdX bs=4M oflag=dsync status=progress`
