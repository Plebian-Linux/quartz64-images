# Plebian Quartz64 Images

This repository contains the GitHub workflow files and debos recipes to create
custom Debian-based operating system images for the Quartz64 line of SBCs from
PINE64, including the SOQuartz.

The goal is to eventually have a fully automated solution for generating
working mainline-kernel-based images for people to use, with a kernel package
that is being updated.


## Sources

* u-boot: https://github.com/CounterPillow/u-boot-quartz64/tree/mainline-ish-2
* kernel: https://github.com/CounterPillow/linux/tree/quartz64-deploy
  - unused at the moment


## Current Features

* Mainline based kernel - no shambling vendor BSP sources
* Kernel that's actually packaged, and gets its own initramfs
* User prompted for new password on first login
* Growing of the root filesystem on first boot
* Regenerating OpenSSH host keys on first boot


## User Documentation

Please see [RUNNING.md](RUNNING.md) for various collected notes regarding how
to use this image to its fullest potential.


## Developer Documentation

For information on how to build images with this repository, see
[HACKING.md](HACKING.md).

For contribution guidelines and hints on how to achieve certain things in the
preferred git workflow, please consult [CONTRIBUTING.md](CONTRIBUTING.md).


## TODO

### Short-term Goals

* generate images for post-Bookworm Debian
* upstream kernel work: mainline a PWM driver for the GP7101 on the Blade
* upstream devicetree work: properly fix USB on CM4IO
* upstream firmware work: submit the firmware files for SOQuartz and Model A
  (if they can be found and their license can be determined)

### Long-term Goals

* set up a website with a guided first time setup UX that handholds users
  through the process of selecting their board, selecting what OS they're using,
  providing flashing instructions and telling them how to plug in their board
  and access its login prompt
* add more SOQuartz baseboards as I (or someone else) mainlines device trees for
  them (e.g. some Waveshare boards)

### Uncertain Goals

* generate Ubuntu based images
* produce images for other PINE64 boards that have mainline kernel support
  (No, I will not ship BSP kernels. You cannot convince me to do so. Go
  mainline things.)
* produce PineTab 2 images


## Donations

If you find these images useful and wish to support the creator(s), you can do
so through GitHub Sponsors by clicking the "Sponsor" button.

Donations help cover the cost of the server hosting the Plebian repository,
and pay for new hardware such as additional boards or SD cards.

Even without donations, this project will still continue, so do not feel
pressured into parting with your hard-earned money. Also, consider making a
donation to [Debian](https://www.debian.org/donations) instead, which makes up
99.99% of what these images consist of.
