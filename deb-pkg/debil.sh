#!/bin/sh
set -e

if [ -z "$1" ]; then
    echo "Gimme an output name"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Gimme a version"
    exit 1
fi

if [ -z "$3" ]; then
    echo "Gimme a revision"
    exit 1
fi

mkdir -p control
cat <<EOF > control/control
Package: devicetrees-plebian-quartz64
Source: linux-upstream
Version: $2-$3
Architecture: arm64
Maintainer: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Installed-Size: $(du -s data/ | cut -f1)
Section: kernel
Priority: optional
Depends: python3
Homepage: https://github.com/Plebian-Linux/quartz64-images
Description: Plebian specific device trees for Quartz64
 This package contains device trees for booting and running
 PINE64 Quartz64 single board computers.
EOF

mkdir -p data
rm -f control/md5sums
rm -f "$1"

cd data
echo $(find . -type f -exec md5sum {} \;) >> ../control/md5sums
cd ..

tar --create --file control.tar.xz --xz -C control .
tar --create --file data.tar.xz --xz -C data .
ar q "$1" debian-binary control.tar.xz data.tar.xz
rm -f control.tar.xz
rm -f data.tar.xz

exit 0
