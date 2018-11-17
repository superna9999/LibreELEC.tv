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
    PKG_MALI_PLATFORM_NAME="sunxi"
    ;;
  Amlogic)
    PKG_VERSION="30c56aa749a4f8e582bef4f94f5a809019f79a1a" #r27p0
    PKG_SHA256="6c38f41da44661573272515e88d1a8ebeac51e2cac824d08445f74539ee621de"
    PKG_URL="https://github.com/LibreELEC/mali-midgard/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="mali-midgard-$PKG_VERSION*"
    PKG_MALI_PLATFORM_NAME="meson"
    ;;
  Amlogic_Legacy)
    PKG_VERSION=""
    PKG_SHA256=""
    PKG_URL="https://github.com/LibreELEC/mali-midgard/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="mali-midgard-$PKG_VERSION*"
    PKG_MALI_PLATFORM_NAME="meson"
    ;;
  Rockchip)
    PKG_VERSION=""
    PKG_SHA256=""
    PKG_URL=""
    PKG_SOURCE_DIR="mali-midgard-$PKG_VERSION*"
    PKG_MALI_PLATFORM_NAME="rk"
    ;;
esac

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  DRIVER_DIR=$PKG_BUILD/driver/product/kernel/drivers/gpu/arm/midgard/

  make ARCH=$TARGET_KERNEL_ARCH CROSS_COMPILE=$TARGET_KERNEL_PREFIX KDIR=$(kernel_path) \
       CONFIG_MALI_MIDGARD=m \
       CONFIG_MALI_PLATFORM_NAME=$PKG_MALI_PLATFORM_NAME \
       EXTRA_CFLAGS="-DCONFIG_MALI_MIDGARD=m \
                     -DCONFIG_MALI_PLATFORM_NAME=$PKG_MALI_PLATFORM_NAME" -C $DRIVER_DIR
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
  cp $DRIVER_DIR/mali_kbase.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME/
}
