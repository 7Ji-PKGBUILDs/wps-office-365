# Maintainer: Jove Yu <yushijun110 [at] gmail.com>
# Maintainer: Guoxin "7Ji" Pu <pugokushin@gmail.com>
pkgbase=wps-office-365
pkgname=('wps-office-365' 'wps-office-365-xiezuo' 'wps-office-365-fonts')
pkgver=12.8.2.16969
pkgrel=8
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
source=('systemd-run-wrapper.sh')
source_x86_64=("https://ks3.wpsplus.wpscdn.cn/img/WPS365_office${pkgver}_integration_xiezuo4.23.0_amd64.deb")
source_aarch64=("https://ks3.wpsplus.wpscdn.cn/img/WPS365_office${pkgver}_integration_xiezuo4.23.0_arm64.deb")
sha256sums=('b0927a95aa70b389e8c92fc37570b226032e5f3e7f7792bb6fde0b630375e24a')
sha256sums_x86_64=('cee58dfd867edfbb0577533354eee0c195dbe862fb55832284adb9c71c6fa6cf')
sha256sums_aarch64=('5a63eaddd4737d650d47025c90a88444c87b11e6dafee0c10c7271d0dd68cc44')

prepare() {
  xz -df data.tar.xz
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
  rm usr/bin/{wps_uninstall.sh,wps_xterm} \
    usr/share/applications/wps-office-uninstall.desktop

  # use system lib
  rm opt/kingsoft/wps-office/office6/lib{freetype,jpeg,stdc++}.so*
  [[ "$CARCH" = "aarch64" ]] && rm opt/kingsoft/wps-office/office6/addons/cef/libm.so*

  # fix libtiff.so.5 deps
  patchelf --replace-needed libtiff.so.5 libtiff.so.6 \
    opt/kingsoft/wps-office/office6/lib{qpdfpaint,pdfmain}.so

  # fix python2 call
  sed -i "s/python -c 'import sys, urllib; print urllib\.unquote(sys\.argv\[1\])'/\
python -c 'import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))'/" usr/bin/wps

  # fix background processes
  sed -i '/gOptExt/s/#//g' usr/bin/{wps,et,wpp}

  # wrap around binaries
  mkdir usr/lib/wps-office-365
  mv usr/bin/* usr/lib/wps-office-365/
  for name in $(ls usr/lib/wps-office-365/); do
    ln -s /usr/lib/wps-office-365/systemd-run-wrapper.sh usr/bin/"${name##*/}"
  done
  install -DTm755 "${srcdir}/systemd-run-wrapper.sh" usr/lib/wps-office-365/systemd-run-wrapper.sh
}

package_wps-office-365-xiezuo(){
  _install --wildcards ./opt/xiezuo './usr/*xiezuo*'
}

package_wps-office-365-fonts(){
  conflicts=('wps-office-fonts')
  provides=('wps-office-fonts')
  _install ./etc/fonts ./usr/share/fonts
}
