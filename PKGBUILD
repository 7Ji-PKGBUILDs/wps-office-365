# Maintainer: Jove Yu <yushijun110 [at] gmail.com>
# Maintainer: Guoxin "7Ji" Pu <pugokushin@gmail.com>
pkgbase=wps-office-365
pkgname=('wps-office-365' 'wps-office-365-xiezuo' 'wps-office-365-fonts')
pkgver=12.8.2.16969
pkgrel=4
pkgdesc="WPS Office, is an office productivity suite."
arch=('x86_64' 'aarch64')
url="https://365.wps.cn/"
license=('LicenseRef-WPS-EULA')
makedepends=(
  'tar' 'patchelf')
depends=(
  'fontconfig' 'libxrender' 'xdg-utils' 'glu' 
  'libpulse' 'libxss' 'sqlite' 'libtool' 
  'libxslt' 'libjpeg-turbo' 'libpng12' 'freetype2')
optdepends=(
  'cups: for printing support')
options=(!strip !zipman !debug)
source=(
  '0001-fix-wps-python-parse.patch')
_ver_xiezuo='4.23.0'
_deb_prefix="WPS365_office${pkgver}_integration_xiezuo${_ver_xiezuo}"
_deb_x86_64="${_deb_prefix}_amd64.deb"
_deb_aarch64="${_deb_prefix}_arm64.deb"
_deb_parent='https://ks3.wpsplus.wpscdn.cn/img/'
source_x86_64=("${_deb_parent}${_deb_x86_64}")
source_aarch64=("${_deb_parent}${_deb_aarch64}")
noextract=("${_deb_x86_64}" "${_deb_aarch64}")
sha256sums=('8325d6176ef26f14b5d560a3ec5d103cbbc0c9488efaa0570d4f0ddcd1fa1cd9')
sha256sums_x86_64=('cee58dfd867edfbb0577533354eee0c195dbe862fb55832284adb9c71c6fa6cf')
sha256sums_aarch64=('5a63eaddd4737d650d47025c90a88444c87b11e6dafee0c10c7271d0dd68cc44')

prepare() {
  case "${CARCH}" in
    x86_64)
      local _deb="${_deb_x86_64}"
      ;;
    aarch64)
      local _deb="${_deb_aarch64}"
      ;;
  esac
  bsdtar -xOf "${_deb}" data.tar.xz |
    xz -d > data.tar
}

_install(){
  tar --no-same-owner -C "${pkgdir}" -xf data.tar "$@"
}

package_wps-office-365(){
  conflicts=('wps-office')
  provides=('wps-office')

  _install ./opt/kingsoft
  _install ./usr --exclude '*xiezuo*' --exclude './usr/share/fonts'

  # fix python
  patch -p1 -d "${pkgdir}" < 0001-fix-wps-python-parse.patch

  # to save typing pkgdir 
  cd "${pkgdir}"

  # remove file
  rm -f usr/bin/{wps_uninstall.sh,wps_xterm} \
    usr/share/applications/wps-office-uninstall.desktop

  # use system lib
  rm -f opt/kingsoft/wps-office/office6/lib{freetype,jpeg,stdc++}.so*
  [[ "$CARCH" = "aarch64" ]] && rm -f opt/kingsoft/wps-office/office6/addons/cef/libm.so*

  # fix libtiff.so.5 deps
  patchelf --replace-needed libtiff.so.5 libtiff.so.6 \
    opt/kingsoft/wps-office/office6/lib{qpdfpaint,pdfmain}.so

  # fix fcitx
  # sed -i '2i export QT_IM_MODULE=fcitx' ${pkgdir}/usr/bin/{wps,wpp,et,wpspdf}
}

package_wps-office-365-xiezuo(){
  _install ./opt/xiezuo --wildcards './usr/*xiezuo*'
}

package_wps-office-365-fonts(){
  _install ./etc/fonts ./usr/share/fonts
}
