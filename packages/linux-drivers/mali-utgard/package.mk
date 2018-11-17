# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mali-utgard"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/products/software/mali-drivers/utgard-kernel"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="mali-utgard: the Linux kernel driver for ARM Mali Utgard GPUs"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

case $PROJECT in
  Allwinner)
    PKG_VERSION="e657205b068c25775dc764d067efa35264a0d4f1" #r7p0
    PKG_SHA256="4eb2902efdcfda3a4c4544f337af2d5e517f4a7a7cdebe9371889197f91c5e18"
    PKG_URL="https://github.com/LibreELEC/mali-utgard/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="mali-utgard-$PKG_VERSION*"
    PKG_MAKE_MALI_PLATFORM="sunxi"
    ;;
  Amlogic)
    PKG_VERSION="1a07195da6771be08ec322ff30085ae12cc74e6c" #r9p0
    PKG_SHA256="7cea33057bd6e2775a1619838001dc393ec640efd54ea20c0ef5d7a4a0d6e90e"
    PKG_URL="https://github.com/LibreELEC/mali-utgard/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="mali-utgard-$PKG_VERSION*"
    PKG_MAKE_MALI_PLATFORM="meson"
    ;;
  Amlogic_Legacy)
    PKG_VERSION="e657205b068c25775dc764d067efa35264a0d4f1" #r7p0
    PKG_SHA256="4eb2902efdcfda3a4c4544f337af2d5e517f4a7a7cdebe9371889197f91c5e18"
    PKG_URL="https://github.com/LibreELEC/mali-utgard/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="mali-utgard-$PKG_VERSION*"
    PKG_MAKE_MALI_PLATFORM="meson"
    ;;
  Rockchip)
    PKG_VERSION="87e4d86a55b1758dc6173fb4af886490d0728823" #r8p1
    PKG_SHA256="a602e9697113f6afc95a77cab4875614ec41f9b886b85a0dde90569a03c87129"
    PKG_URL="https://github.com/LibreELEC/mali-utgard/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="mali-utgard-$PKG_VERSION*"
    PKG_MAKE_MALI_PLATFORM="rk"
    ;;
esac

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make ARCH=$TARGET_KERNEL_ARCH \
       CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
       KDIR=$(kernel_path) \
       GIT_REV="" \
       USING_UMP=0 \
       BUILD=release \
       MALI_DMA_BUF_MAP_ON_ATTACH=1 \
       USING_PROFILING=0 \
       MALI_PLATFORM=$PKG_MAKE_MALI_PLATFORM \
       USING_DVFS=0 -C driver/src/devicedrv/mali
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
  cp driver/src/devicedrv/mali/mali.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME/
}
