# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libmali"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/filesystem/"
PKG_VERSION="9143da0c1b47b61b0f81ed70b5fb13a582e1602e"
PKG_SHA256="aa57877c9e5b515c8a3e42230133087d53609696315342d45bb9a18acd78dc8a"
PKG_URL="https://github.com/chewitt/libmali/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="libmali-$PKG_VERSION"
PKG_DEPENDS_TARGET="libffi libdrm"
PKG_SECTION="graphics"
PKG_SHORTDESC="Mali userspace libraries for ARM SoC's"
PKG_TOOLCHAIN="manual"

  case $PROJECT-$MALI_FAMILY in
    Amlogic-dvalin)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET minigbm"
      LIB_MALI="dvalin/r12p0"
      LIB_GBM="minigbm"
      ;;
    Amlogic-gondul)
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET minigbm"
      LIB_MALI="gondul/r12p0"
      LIB_GBM="minigbm"
      ;;
    Amlogic-midgard|Rockchip-midgard)
      LIB_MALI="t86x/r14p0"
      ;;
    Amlogic-utgard|*)
      LIB_MALI="m450/r7p0"
      ;;
  esac

makeinstall_target() {
  if [ "$TARGET_ARCH" = "arm" ]; then
    LIB_ARCH="eabihf"
  else
    LIB_ARCH="arm64"
  fi

  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR include/EGL $SYSROOT_PREFIX/usr/include/
    cp -PR include/EGL_platform/platform_dummy/eglplatform.h $SYSROOT_PREFIX/usr/include/EGL/
    if [ "LIB_GBM" != "minigbm" ]; then
      cp -PR include/EGL_platform/platform_wayland/gbm/gbm.h $SYSROOT_PREFIX/usr/include/
    fi
    cp -PR include/GLES $SYSROOT_PREFIX/usr/include/
    cp -PR include/GLES2 $SYSROOT_PREFIX/usr/include/
    cp -PR include/KHR $SYSROOT_PREFIX/usr/include/

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR lib/$LIB_ARCH/$LIB_MALI/dummy/libMali.so $SYSROOT_PREFIX/usr/lib

    ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libEGL.so.1.4
    ln -sf libEGL.so.1.4 $SYSROOT_PREFIX/usr/lib/libEGL.so.1
    ln -sf libEGL.so.1 $SYSROOT_PREFIX/usr/lib/libEGL.so

    ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so.1.1
    ln -sf libGLESv1_CM.so.1.1 $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so.1
    ln -sf libGLESv1_CM.so.1 $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so

    ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libGLESv2.so.2.0
    ln -sf libGLESv2.so.2.0 $SYSROOT_PREFIX/usr/lib/libGLESv2.so.2
    ln -sf libGLESv2.so.2 $SYSROOT_PREFIX/usr/lib/libGLESv2.so

    if [ "$LIB_GBM" != "minigbm" ]; then
      ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libgbm.so
      ln -sf libgbm.so $SYSROOT_PREFIX/usr/lib/libgbm.so.1
    fi

  mkdir -p $INSTALL/usr/lib
    cp -PR lib/$LIB_ARCH/$LIB_MALI/dummy/libMali.so $INSTALL/usr/lib

    ln -sf libMali.so $INSTALL/usr/lib/libEGL.so.1.4
    ln -sf libEGL.so.1.4 $INSTALL/usr/lib/libEGL.so.1
    ln -sf libEGL.so.1 $INSTALL/usr/lib/libEGL.so

    ln -sf libMali.so $INSTALL/usr/lib/libGLESv1_CM.so.1.1
    ln -sf libGLESv1_CM.so.1.1 $INSTALL/usr/lib/libGLESv1_CM.so.1
    ln -sf libGLESv1_CM.so.1 $INSTALL/usr/lib/libGLESv1_CM.so

    ln -sf libMali.so $INSTALL/usr/lib/libGLESv2.so.2.0
    ln -sf libGLESv2.so.2.0 $INSTALL/usr/lib/libGLESv2.so.2
    ln -sf libGLESv2.so.2 $INSTALL/usr/lib/libGLESv2.so

    if [ "$LIB_GBM" != "minigbm" ]; then
      ln -sf libMali.so $INSTALL/usr/lib/libgbm.so
      ln -sf libgbm.so $INSTALL/usr/lib/libgbm.so.1
    fi
}
