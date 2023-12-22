#!/bin/sh

set -e
if [ -z $BUILDROOT ]; then
 echo "please define BUILDROOT" >&2
 exit 1
fi

BASE=$(realpath $BUILDROOT/bin)
IMG=$BASE/targets/mediatek/mt7622
PKG=$BASE/packages
rm -rf bpi-pkgs
mkdir bpi-pkgs
cd bpi-pkgs
cp -r $PKG .
cp -r $IMG/packages kernel-packages
mkdir -p etc/opkg
echo 'src/gz openwrt_core file:///kernel-packages' > etc/opkg/distfeeds.conf
echo 'src/gz openwrt_base file:///packages/aarch64_cortex-a53/base' >> etc/opkg/distfeeds.conf
echo 'src/gz openwrt_packages file:///packages/aarch64_cortex-a53/packages' >> etc/opkg/distfeeds.conf
echo 'src/gz openwrt_luci file:///packages/aarch64_cortex-a53/luci' >> etc/opkg/distfeeds.conf
tar cvf ../bpi-pkgs.tar .
