###############################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="opengl-meson-gbm"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/filesystem/"
PKG_VERSION="kernel_4.9_20180131"
PKG_URL="https://github.com/superna9999/meson_gx_mali_450/releases/download/for-4.15/buildroot_openlinux_${PKG_VERSION}_mali.tar.gz"
PKG_SOURCE_DIR="buildroot_openlinux"
PKG_DEPENDS_TARGET="libffi libdrm"
if [ "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET wayland"
fi
PKG_SECTION="graphics"
PKG_SHORTDESC="opengl-meson-gbm: Wayland/GBM OpenGL ES pre-compiled libraries for Mali GPUs found in Amlogic Meson SoCs"
PKG_LONGDESC="opengl-meson-gbm: Wayland/GBM OpenGL ES pre-compiled libraries for Mali GPUs found in Amlogic Meson SoCs. The libraries could be found in a Linux buildroot released by Amlogic at http://openlinux.amlogic.com:8000/download/ARM/filesystem/. See the opengl package."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  if [ "$TARGET_ARCH" = "arm" ]; then
    LIB_ARCH="eabihf"
    PLATFORM="wayland/drm"
  else
    LIB_ARCH="arm64"
    PLATFORM="dummy"
  fi
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR buildroot/package/meson-mali/include/EGL $SYSROOT_PREFIX/usr/include/
    cp -PR buildroot/package/meson-mali/include/GLES $SYSROOT_PREFIX/usr/include/
    cp -PR buildroot/package/meson-mali/include/GLES2 $SYSROOT_PREFIX/usr/include/
    cp -PR buildroot/package/meson-mali/include/KHR $SYSROOT_PREFIX/usr/include/
    cp -PR buildroot/package/meson-mali/include/EGL_platform/platform_dummy/eglplatform.h $SYSROOT_PREFIX/usr/include/EGL/
    cp -PR buildroot/package/meson-mali/include/EGL_platform/platform_wayland/gbm/gbm.h $SYSROOT_PREFIX/usr/include/

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR buildroot/package/meson-mali/lib/$LIB_ARCH/r7p0/m450/$PLATFORM/libMali.so $SYSROOT_PREFIX/usr/lib

    ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libEGL.so.1.4
    ln -sf libEGL.so.1.4 $SYSROOT_PREFIX/usr/lib/libEGL.so.1
    ln -sf libEGL.so.1 $SYSROOT_PREFIX/usr/lib/libEGL.so

    ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so.1.1
    ln -sf libGLESv1_CM.so.1.1 $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so.1
    ln -sf libGLESv1_CM.so.1 $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so

    ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libGLESv2.so.2.0
    ln -sf libGLESv2.so.2.0 $SYSROOT_PREFIX/usr/lib/libGLESv2.so.2
    ln -sf libGLESv2.so.2 $SYSROOT_PREFIX/usr/lib/libGLESv2.so

    ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libgbm.so
    ln -sf libgbm.so $SYSROOT_PREFIX/usr/lib/libgbm.so.1

    if [ $PLATFORM = "wayland" ] ; then
      ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libwayland-egl.so
      ln -sf libwayland-egl.so $SYSROOT_PREFIX/usr/lib/libwayland-egl.so.1
      ln -sf libwayland-egl.so.1 $SYSROOT_PREFIX/usr/lib/libwayland-egl.so.1.0.0
    fi

  mkdir -p $INSTALL/usr/lib
    cp -PR buildroot/package/meson-mali/lib/$LIB_ARCH/r7p0/m450/$PLATFORM/libMali.so $INSTALL/usr/lib

    ln -sf libMali.so $INSTALL/usr/lib/libEGL.so.1.4
    ln -sf libEGL.so.1.4 $INSTALL/usr/lib/libEGL.so.1
    ln -sf libEGL.so.1 $INSTALL/usr/lib/libEGL.so

    ln -sf libMali.so $INSTALL/usr/lib/libGLESv1_CM.so.1.1
    ln -sf libGLESv1_CM.so.1.1 $INSTALL/usr/lib/libGLESv1_CM.so.1
    ln -sf libGLESv1_CM.so.1 $INSTALL/usr/lib/libGLESv1_CM.so

    ln -sf libMali.so $INSTALL/usr/lib/libGLESv2.so.2.0
    ln -sf libGLESv2.so.2.0 $INSTALL/usr/lib/libGLESv2.so.2
    ln -sf libGLESv2.so.2 $INSTALL/usr/lib/libGLESv2.so

    ln -sf libMali.so $INSTALL/usr/lib/libgbm.so
    ln -sf libgbm.so $INSTALL/usr/lib/libgbm.so.1

    if [ $PLATFORM = "wayland" ] ; then
      ln -sf libMali.so $INSTALL/usr/lib/libwayland-egl.so
      ln -sf libwayland-egl.so $INSTALL/usr/lib/libwayland-egl.so.1
      ln -sf libwayland-egl.so.1 $INSTALL/usr/lib/libwayland-egl.so.1.0.0
    fi
}
