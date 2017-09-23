################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="meson_gx_mali_450"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/superna9999/meson_gx_mali_450"
# r7p0
PKG_VERSION="fb20cef"
PKG_URL="https://github.com/jakogut/meson_gx_mali_450/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="meson_gx_mali_450-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="meson_gx_mali_450: Linux drivers for Mali GPUs found in Amlogic Meson SoCs"
PKG_LONGDESC="meson_gx_mali_450: Linux drivers for Mali GPUs found in Amlogic Meson SoCs"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make ARCH=$TARGET_KERNEL_ARCH CROSS_COMPILE=$TARGET_PREFIX KDIR=$(kernel_path) USING_UMP=0 BUILD=release MALI_DMA_BUF_MAP_ON_ATTACH=1 USING_PROFILING=0 MALI_PLATFORM=meson USING_DVFS=0 -C driver/src/devicedrv/mali
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
  cp driver/src/devicedrv/mali/mali.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME/
}
