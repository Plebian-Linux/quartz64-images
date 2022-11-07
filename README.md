# Plebian Quartz64 Images

***This is a work-in-progress project. Things don't work yet. Please do not
flash these images yet unless you are trying to help develop this pipeline.***

This repository contains the GitHub workflow files and debos recipes to create
custom Debian-based operating system images for the Quartz64 line of SBCs from
PINE64, including the SOQuartz.

The goal is to eventually have a fully automated solution for generating
working mainline-kernel-based images for people to use, with a kernel package
that is being updated.


## Sources

* u-boot: https://github.com/CounterPillow/u-boot-quartz64/tree/deploy
* kernel: https://github.com/CounterPillow/linux/tree/quartz64-deploy


## Current Features

* Mainline based kernel - no shambling vendor BSP sources
* Kernel that's actually packaged, and gets its own initramfs
* User prompted for new password on first login
* Growing of the root filesystem on first boot
* Regenerating OpenSSH host keys on first boot


## User Documentation

Please see [RUNNING.md](RUNNING.md) for various collected notes regarding how
to use this image to its fullest potential, so you don't make yourself look
like an idiot on YouTube as you "explain computers".


## TODO:

* make a device tree package instead of a kernel package, ship 6.1 experimental
  Debian kernel package instead
    * write packaging scripts to `make dtbs` and install only the required dtbs
      into a plebian subdirectory of the normal device tree blob dir
    * have a post install script in the package that finds-and-replaces the
      vanilla FDT path with the plebian one, and runs u-boot-update
    * have a post (or pre?) remove script in the package that finds-and-replaces
      the plebian FDT path with the vanilla one, and runs u-boot-update
* repository-ing the devicetree package
    * pushing the packages from the pipeline to a repository
    * rebuilding the repository on incoming packages
    * versioning???? (probably git describe on the kernel source tree)
    * adding the repository to the images in apt sources
* ***First Public "Beta" Release Here***
    * forum post
    * wiki listing
    * tweet?
* package the wireless firmware
* get a newer rkbin working with u-boot
* base pg's stuff on a newer version of u-boot
* get FDT overlays working in u-boot
* generate ubuntu based images
* add more SOQuartz baseboards as I (or someone else) mainlines device trees for
  them.
* Plebian landing page with the freshest image download links and flashing
  instructions
