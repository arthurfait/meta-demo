FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# FIXME: need use patcch for scf2 to alow debug print from xen


SRC_URI_append = " \
    file://be.cfg \
"

SRC_URI_append_salvator-x = " \
    file://r8a7795-salvator-x-xen.dts;subdir=git/arch/${ARCH}/boot/dts/renesas \
"
KERNEL_DEVICETREE_append_salvator-x = "renesas/r8a7795-salvator-x-xen.dtb"
