# Maintainer: Jove Yu <yushijun110 [at] gmail.com>
# Maintainer: Guoxin "7Ji" Pu <pugokushin@gmail.com>
pkgbase=wps-office-365
pkgname=('wps-office-365' 'wps-office-365-xiezuo' 'wps-office-365-fonts')
pkgver=12.8.2.16969
pkgrel=6
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
_deb_stem="WPS365_office${pkgver}_integration_xiezuo4.23.0_"
_deb_prefix="https://ks3.wpsplus.wpscdn.cn/img/WPS365_office${pkgver}_integration_xiezuo4.23.0_"
source_x86_64=("${_deb_prefix}amd64.deb")
source_aarch64=("${_deb_prefix}arm64.deb")
noextract=("${_deb_stem}"{amd,arm}64.deb)
sha256sums_x86_64=('cee58dfd867edfbb0577533354eee0c195dbe862fb55832284adb9c71c6fa6cf')
sha256sums_aarch64=('5a63eaddd4737d650d47025c90a88444c87b11e6dafee0c10c7271d0dd68cc44')

prepare() {
  echo 'Caching data.tar...'
  bsdtar -xOf *.deb data.tar.xz |
    xz -d > data.tar
}

_install(){
  tar --no-same-owner -C "${pkgdir}" -xf data.tar "$@"
}

package_wps-office-365(){
  conflicts=('wps-office')
  provides=('wps-office')

  _install --exclude './usr/*xiezuo*' --exclude './usr/share/fonts' \
    ./opt/kingsoft ./usr ./etc/xdg/menus

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

  # fix python2 call
  sed -i "s/python -c 'import sys, urllib; print urllib\.unquote(sys\.argv\[1\])'/\
python -c 'import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))'/" usr/bin/wps
}

package_wps-office-365-xiezuo(){
  _install --wildcards ./opt/xiezuo './usr/*xiezuo*'
}

package_wps-office-365-fonts(){
  conflicts=('wps-office-fonts')
  provides=('wps-office-fonts')
  _install ./etc/fonts ./usr/share/fonts
}
