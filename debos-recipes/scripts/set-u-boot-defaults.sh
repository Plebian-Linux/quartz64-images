#!/bin/sh
BOARD="$1"
if [ "$BOARD" = "quartz64b" ] ; then
    FDT_NAME="rk3566-quartz64-b.dtb"
elif [ "$BOARD" = "quartz64a" ] ; then
    FDT_NAME="rk3566-quartz64-a.dtb"
elif [ "$BOARD" = "soquartz-cm4" ] ; then
    FDT_NAME="rk3566-soquartz-cm4.dtb"
elif [ "$BOARD" = "soquartz-blade" ] ; then
    FDT_NAME="rk3566-soquartz-blade.dtb"
elif [ "$BOARD" = "soquartz-model-a" ] ; then
    FDT_NAME="rk3566-soquartz-model-a.dtb"
fi

mkdir -p /usr/share/u-boot-menu/conf.d/
cat <<EOF > /usr/share/u-boot-menu/conf.d/10-plebian.conf
## /usr/share/u-boot-menu/conf.d/10-plebian.conf - configuration file for u-boot-update(8)
## AUTOMATICALLY GENERATED FILE - DO NOT EDIT!
## Instead, put your configuration into /etc/u-boot-menu/conf.d/*.conf
## Files there will override values of config fragments in this directory

#U_BOOT_UPDATE="true"

#U_BOOT_ALTERNATIVES="default recovery"
#U_BOOT_DEFAULT="l0"
#U_BOOT_ENTRIES="all"
#U_BOOT_MENU_LABEL="Debian GNU/Linux"
U_BOOT_PARAMETERS="ignore_loglevel ro rootwait earlycon console=tty0 console=ttyS2,1500000n8 fw_devlink=off"
U_BOOT_ROOT="root=LABEL=root"
U_BOOT_TIMEOUT="30"
U_BOOT_FDT="rockchip/$FDT_NAME"
#U_BOOT_FDT_DIR="/usr/lib/linux-image-"
#U_BOOT_FDT_OVERLAYS=""
#U_BOOT_FDT_OVERLAYS_DIR="/boot/dtbo/"

EOF
