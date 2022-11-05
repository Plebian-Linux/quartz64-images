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


## TODO:

* figure out repart weirdness
* regenerate openssh keys on first boot
* repository-ing the kernel packages
    * pushing the packages from the pipeline to a repository
    * rebuilding the repository on incoming packages
    * versioning????
    * adding the repository to the images in apt sources
* package the wireless firmware
* generate ubuntu based images
* add more SOQuartz baseboards as I (or someone else) mainlines device trees for
  them.
* Plebian landing page with the freshest image download links and flashing
  instructions
