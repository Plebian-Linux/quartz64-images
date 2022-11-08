#!/bin/sh
set -e

DTDEB_VERSION=$(date -u +"%Y%m%d%H%M%S")
DTDEB_REVISION="1"  # hardcode this as there's no reason to ever use it if we
                    # datestamp things
DTDEB_ARCH="arm64"  # not passed on, just for file naming reasons
DTDEB_OUTNAME="devicetrees-plebian-quartz64-$DTDEB_VERSION-$DTDEB_REVISION_$DTDEB_ARCH.deb"

# Download quartz64-deploy branch archive
rm -f linux-quartz64-deploy.zip
rm -rf linux-quartz64-deploy
wget -q -O linux-quartz64-deploy.zip https://github.com/CounterPillow/linux/archive/refs/heads/quartz64-deploy.zip
unzip -q linux-quartz64-deploy.zip

# Build the DTBs
cd linux-quartz64-deploy
make mrproper
cp ../../config .config
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- olddefconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- dtbs
cd ..

# Install to data folder
rm -rf data/
mkdir -p data/usr/lib/devicetrees-plebian-quartz64/rockchip/
install --mode=644 linux-quartz64-deploy/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtb \
    data/usr/lib/devicetrees-plebian-quartz64/rockchip/
install --mode=644 linux-quartz64-deploy/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dtb \
    data/usr/lib/devicetrees-plebian-quartz64/rockchip/
install --mode=644 linux-quartz64-deploy/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dtb \
    data/usr/lib/devicetrees-plebian-quartz64/rockchip/

./debil.sh "$DTDEB_OUTNAME" "$DTDEB_VERSION" "$DTDEB_REVISION"

# Clean up after ourselves
rm -f linux-quartz64-deploy.zip
rm -rf linux-quartz64-deploy
