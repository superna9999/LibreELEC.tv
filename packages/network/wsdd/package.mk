# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wsdd"
PKG_VERSION="21f614acbfad17ca4c8653c5bbccc27fdcdb50e1"
PKG_SHA256="b862fa463311b715786adbe8b1cc326a047aa68fdd7adef71a6114c22f4f3cf4"
PKG_LICENSE="BSD 3-Clause"
PKG_SITE="https://github.com/KoynovStas/wsdd"
PKG_URL="https://github.com/KoynovStas/wsdd/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="wsdd-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="wsdd is a Linux daemon for the ONVIF WS-Discovery Server Service"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make all
#	 ARCH=$TARGET_KERNEL_ARCH \
#       CROSS_COMPILE=$TARGET_KERNEL_PREFIX \
#       -C "$(kernel_path)"
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
#    cp -P src/wsdd $INSTALL/usr/bin
}

post_install() {
  enable_service wsdd.service
}
