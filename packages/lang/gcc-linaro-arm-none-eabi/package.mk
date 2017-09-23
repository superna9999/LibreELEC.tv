################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
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

PKG_NAME="gcc-linaro-arm-none-eabi"
PKG_VERSION="4.8-2013.11"
PKG_SHA256="2c3e7993e20772ce2d3003165f4a6fa7c8182bff3a42011515b67df5ce0f0dfd"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-${PKG_VERSION}_linux.tar.xz"
PKG_SOURCE_DIR="gcc-linaro-arm-none-eabi-${PKG_VERSION}_linux"
PKG_DEPENDS_HOST="toolchain"
PKG_SECTION="lang"
PKG_SHORTDESC=""
PKG_LONGDESC=""

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_host() {
  :
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-linaro-arm-none-eabi/
    cp -a * $TOOLCHAIN/lib/gcc-linaro-arm-none-eabi
}
