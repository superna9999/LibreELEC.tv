# Amlogic GXM

This is a generic SoC image for Amlogic GXM devices

**build targets**

The following GXM devices exist in the Linux kernel:

* `PROJECT=Amlogic DEVICE=GXM ARCH=arm UBOOT_SYSTEM=khadas-vim2 make image`
* `PROJECT=Amlogic DEVICE=GXM ARCH=arm UBOOT_SYSTEM=nexbox-a1 make image`
* `PROJECT=Amlogic DEVICE=GXM ARCH=arm UBOOT_SYSTEM=q200 make image`
* `PROJECT=Amlogic DEVICE=GXM ARCH=arm UBOOT_SYSTEM=q201 make image`
* `PROJECT=Amlogic DEVICE=GXM ARCH=arm UBOOT_SYSTEM=rbox-pro make image`
* `PROJECT=Amlogic DEVICE=GXM ARCH=arm UBOOT_SYSTEM=vega-s96 make image`

**known issues**

* Kodi will not run as Linux Mali userspace libraries do not exist!
* Bluetooth does not work on the VIM2
