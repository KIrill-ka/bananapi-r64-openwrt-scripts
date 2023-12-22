#!/bin/sh

set -e
if [ -z $BUILDROOT ]; then
 echo "please define BUILDROOT" >&2
 exit 1
fi
if [ -z $BOARD2BIN ]; then
 echo "please define BOARD2BIN" >&2
 exit 1
fi
BASE=$BUILDROOT/bin
IMG=$BASE/targets/mediatek/mt7622
PKG=$BASE/packages
rm -rf bpi-pkgs
mkdir bpi-pkgs
cd bpi-pkgs
cp -r $PKG .
cp -r $IMG/packages kernel-packages
ATH11KFW=lib/firmware/ath11k/QCN9074
mkdir -p $ATH11KFW/hw1.0
cp $BOARD2BIN $ATH11KFW/hw1.0/board-2.bin
#cp $ATH11KFW_SRC/hw1.0/2.5.0.1/WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1/*.bin $ATH11KFW/hw1.0
mkdir -p etc/opkg
echo 'src/gz openwrt_core file:///kernel-packages' > etc/opkg/distfeeds.conf
echo 'src/gz openwrt_base file:///packages/aarch64_cortex-a53/base' >> etc/opkg/distfeeds.conf
echo 'src/gz openwrt_packages file:///packages/aarch64_cortex-a53/packages' >> etc/opkg/distfeeds.conf
echo 'src/gz openwrt_luci file:///packages/aarch64_cortex-a53/luci' >> etc/opkg/distfeeds.conf
tar cvf ../bpi-pkgs.tar .
