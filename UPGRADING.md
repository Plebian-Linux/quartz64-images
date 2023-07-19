# Manual Intervention For Upgrades

Not all of Plebian's stuff is packages in a way where apt can upgrade it as
of the time of writing. That's why occasionally, manual intervention is needed
to fully transition from an earlier release of Plebian to a newer one. This
document tells you how to do this depending on what release you're updating
from.

If you're in need of doing multiple upgrades, do them in order.


## From 2023.01.* to 2023.02.28

During this upgrade, u-boot will need to be updated. The third party repository
needs to be added as well.

### Upgrading u-boot

1. Find the latest release for your device [from the Actions workflow](https://github.com/Plebian-Linux/quartz64-images/actions/workflows/build-image.yml).
2. Unzip it so that you have `idbloader.img` and `u-boot.itb`
3. Find the device you have u-boot on with `lsblk`, it's probably the one your
   `/` resides on as well, i.e. `/dev/mmcblk0` for SD and `/dev/mmcblk1` for
   eMMC.
4. Flash `idbloader.img` to `p1` of that device, e.g.
   `sudo dd if=idbloader.img of=/dev/mmcblk0p1 oflag=dsync bs=4096`
   Remember to change `/dev/mmcblk0p1` to `/dev/mmcblk1p1` if you're using eMMC.
5. Flash `u-boot.itb` to `p2` of that device, e.g.
   `sudo dd if=u-boot.itb of=/dev/mmcblk0p2 oflag=dsync bs=4096`
   Remember to change `/dev/mmcblk0p2` to `/dev/mmcblk1p2` if you're using eMMC.

### Adding The Plebian Repo

Run the following:

```
sudo curl -L https://raw.githubusercontent.com/Plebian-Linux/quartz64-images/main/debos-recipes/overlays/apt/sources.list.d/plebian.sources -o /etc/apt/sources.list.d/plebian.sources
sudo curl -L https://github.com/Plebian-Linux/quartz64-images/raw/main/debos-recipes/overlays/keyrings/plebian-build-key.gpg -o /usr/share/keyrings/plebian-build-key.gpg
sudo apt update
sudo apt install devicetrees-plebian-quartz64
```


## From 2023.02.28 to 2023.03.09

1. Install the package `firmware-brcm80211`.
2. Remove the file `/etc/apt/apt.conf.d/40default-release`
3. Remove the file `/etc/apt/sources.list.d/sid.list`

## To 2023.07.19

During this upgrade, u-boot will need to be updated.

1. Download the u-boot build for your device from the release page.
2. Find the device you have u-boot on with `lsblk`, it's probably the one your
   `/` resides on as well, i.e. `/dev/mmcblk0` for SD and `/dev/mmcblk1` for
   eMMC. We'll henceforth refer to this as `/dev/mmcblkX`.
3. Install parted:
   `sudo apt update && sudo apt install parted`
4. Delete partition 2 of the device:
   `sudo parted /dev/mmcblkX rm 2`
5. Resize partition 1 of the device:
   `sudo parted /dev/mmcblkX resizepart 1 32MiB`
6. Flash u-boot to partition 1 of your device:
   `sudo dd if=u-boot-rockchip.bin of=/dev/mmcblkXp1 oflag=dsync status=progress bs=1M`
