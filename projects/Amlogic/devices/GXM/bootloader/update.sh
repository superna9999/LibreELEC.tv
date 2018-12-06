#!/bin bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

[ -z "$UPDATE_DIR" ] && UPDATE_DIR="/storage/.update"
[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""
[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
[ -z "$BOOT_PART" ] && BOOT_PART=$(df "$BOOT_ROOT" | tail -1 | awk {' print $1 '})

# identify the boot device
  if [ -z "$BOOT_DISK" ]; then
    case $BOOT_PART in
      /dev/sd[a-z][0-9]*)
        BOOT_DISK=$(echo $BOOT_PART | sed -e "s,[0-9]*,,g")
        ;;
      /dev/mmcblk*)
        BOOT_DISK=$(echo $BOOT_PART | sed -e "s,p[0-9]*,,g")
        ;;
    esac
  fi

# mount $BOOT_ROOT rw
  mount -o remount,rw $BOOT_ROOT

# update boot files except uEnv.ini
  for file in $(find /flash -name '*' ! -name '*uEnv.ini') ; do
    echo "Updating $(basename $file)"
    cp $SYSTEM_ROOT/usr/share/bootloader/$file $BOOT_ROOT
  done

# mount $BOOT_ROOT ro
  sync
  mount -o remount,ro $BOOT_ROOT
