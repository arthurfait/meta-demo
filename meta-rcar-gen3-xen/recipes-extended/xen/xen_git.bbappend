FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS += "u-boot-mkimage-native"

XEN_REL="4.12"

XEN_BRANCH = "stable-${XEN_REL}"

SRCREV = "${AUTOREV}"

DEPENDS_remove = "dev86-native"  

EXTRA_OEMAKE += " CONFIG_QEMU_XEN=n"

DEFAULT_PREFERENCE = "1"

do_deploy_append () {
    if [ -f ${D}/boot/xen ]; then
        uboot-mkimage -A arm64 -C none -T kernel -a 0x78080000 -e 0x78080000 -n "XEN" -d ${D}/boot/xen ${DEPLOYDIR}/xen-${MACHINE}.uImage
    fi
}

FILES_${PN}-xencommons_remove += " \
    ${systemd_unitdir}/system/xenstored.socket \
    ${systemd_unitdir}/system/xenstored_ro.socket \
    "

FILES_${PN}-xencommons += " \
    ${systemd_unitdir}/system/xendriverdomain.service \
    "

SYSTEMD_SERVICE_${PN}-xencommons_remove += " \
    xenstored.socket \
    xenstored_ro.socket \
    "

FILES_${PN}-libxendevicemodel = "${libdir}/libxendevicemodel.so.*"
FILES_${PN}-libxendevicemodel-dev = "${libdir}/libxendevicemodel.so"

FILES_${PN}-libxentoolcore = "${libdir}/libxentoolcore.so.*"
FILES_${PN}-libxentoolcore-dev = "${libdir}/libxentoolcore.so"

FILES_${PN}-pkgconfig = "\
    ${datadir}/pkgconfig \
    "

FILES_${PN}-xendiag += " \
    ${sbindir}/xen-diag \
    "

FILES_${PN}-xenmon += "\
    ${sbindir}/xenmon \
"

FILES_${PN}-xenfsimage += "\
        ${libdir}/libxenfsimage.so.* \
        ${libdir}/xenfsimage/* \
"

FILES_${PN}-xenfsimage-dev += "\
        ${libdir}/libxenfsimage.so \
"

FILES_${PN}-depriv-fd-checker += "\
         ${libdir}/xen/bin/depriv-fd-checker \
"

#${PN}-libxendevicemodel 
#    ${PN}-libxendevicemodel-dev 

PACKAGES_append = "\
    ${PN}-libxentoolcore \
    ${PN}-libxentoolcore-dev \
    ${PN}-pkgconfig \
    ${PN}-xendiag \
    ${PN}-xenmon \
    ${PN}-xenfsimage \
    ${PN}-xenfsimage-dev \
    ${PN}-depriv-fd-checker \
    "

RDEPENDS_${PN}-base_remove = "\
    ${PN}-blktap \
    ${PN}-libblktapctl \
    ${PN}-libvhd \
    "


RDEPENDS_${PN}-base_append = "\
     ${PN}-xenfsimage \
  "   
