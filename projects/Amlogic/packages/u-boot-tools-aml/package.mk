# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="u-boot-tools-aml"
PKG_VERSION="2016.03"
PKG_SHA256="e49337262ecac44dbdeac140f2c6ebd1eba345e0162b0464172e7f05583ed7bb"
PKG_ARCH="any"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="ftp://ftp.denx.de/pub/u-boot/u-boot-$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="u-boot-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain dtc:host u-boot-tools-aml:host"
PKG_LICENSE="GPL"
PKG_SECTION="tools"
PKG_SHORTDESC="u-boot-tools-aml: u-boot utility tools, including mkimage and fw_* programs to read/modify env"

make_host() {
  make mrproper
  make dummy_defconfig
  make tools-only
}

make_target() {
  CROSS_COMPILE="$TARGET_PREFIX" LDFLAGS="" ARCH=arm make dummy_defconfig
  CROSS_COMPILE="$TARGET_PREFIX" LDFLAGS="" ARCH=arm make env
  CROSS_COMPILE="$TARGET_PREFIX" LDFLAGS="" ARCH=arm make cross_tools
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp tools/mkimage $TOOLCHAIN/bin
}

makeinstall_target() {
  mkdir -p $INSTALL/etc
  cp $PKG_DIR/config/fw_env.config $INSTALL/etc/fw_env.config

  mkdir -p $INSTALL/usr/sbin
  cp tools/env/fw_printenv $INSTALL/usr/sbin/fw_printenv
  cp tools/env/fw_printenv $INSTALL/usr/sbin/fw_setenv
  cp tools/dumpimage $INSTALL/usr/sbin/dumpimage
  cp tools/fdtgrep $INSTALL/usr/sbin/fdtgrep
  cp tools/gen_eth_addr $INSTALL/usr/sbin/gen_eth_addr
  cp tools/img2srec $INSTALL/usr/sbin/img2srec
  cp tools/mkenvimage $INSTALL/usr/sbin/mkenvimage
  cp tools/mkimage $INSTALL/usr/sbin/mkimage
  cp tools/proftool $INSTALL/usr/sbin/proftool
  cp tools/relocate-rela $INSTALL/usr/sbin/relocate-rela
}
