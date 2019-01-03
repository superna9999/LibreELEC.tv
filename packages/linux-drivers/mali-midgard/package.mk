# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mali-midgard"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/products/software/mali-drivers/midgard-kernel"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_LONGDESC="mali-midgard: the Linux kernel driver for ARM Mali Midgard GPUs"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

case $PROJECT in
  Allwinner)
    PKG_VERSION=""
    PKG_SHA256=""
    PKG_URL=""
    PKG_SOURCE_DIR="mali-midgard-$PKG_VERSION*"
    PKG_MALI_PLATFORM_CONFIG="sunxi"
    ;;
  Amlogic)
    PKG_VERSION="b4efb12e2667ec89eb187d8f59977fbb6e10b9bb" #r27p0-01rel0
    PKG_SHA256="b3aa9308bb671b00f0f2a6cf011517df897696ce11d248d3ac0b06cd0a33141b"
    PKG_URL="https://github.com/LibreELEC/mali-midgard/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="mali-midgard-$PKG_VERSION*"
    PKG_MALI_PLATFORM_CONFIG="config.meson-gxm"
    ;;
  Amlogic_Legacy)
    PKG_VERSION=""
    PKG_SHA256=""
    PKG_URL="https://github.com/LibreELEC/mali-midgard/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="mali-midgard-$PKG_VERSION*"
    PKG_MALI_PLATFORM_CONFIG="meson"
    ;;
  Rockchip)
    PKG_VERSION="b4efb12e2667ec89eb187d8f59977fbb6e10b9bb" #r27p0-01rel0
    PKG_SHA256="b3aa9308bb671b00f0f2a6cf011517df897696ce11d248d3ac0b06cd0a33141b"
    PKG_URL="https://github.com/LibreELEC/mali-midgard/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="mali-midgard-$PKG_VERSION*"
    PKG_MALI_PLATFORM_CONFIG="config"
    ;;
esac

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make ARCH=$TARGET_KERNEL_ARCH CROSS_COMPILE=$TARGET_KERNEL_PREFIX KDIR=$(kernel_path) \
       CONFIG_NAME=$PKG_MALI_PLATFORM_CONFIG -C $PKG_BUILD
}

makeinstall_target() {
  DRIVER_DIR=$PKG_BUILD/driver/product/kernel/drivers/gpu/arm/midgard/
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
  cp $DRIVER_DIR/mali_kbase.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME/
}
