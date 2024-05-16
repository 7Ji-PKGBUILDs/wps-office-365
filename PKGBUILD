# Maintainer: Jove Yu <yushijun110 [at] gmail.com>
pkgname=wps-office-365
pkgver=12.8.2.15283
pkgrel=3
pkgdesc="WPS Office, is an office productivity suite."
arch=('x86_64' 'aarch64')
url="https://365.wps.cn/"
license=('LicenseRef-WPS-EULA')
conflicts=('wps-office')
provides=('wps-office')
depends=(
  'fontconfig' 'xorg-mkfontdir' 'libxrender' 'desktop-file-utils' 
  'shared-mime-info' 'xdg-utils' 'glu' 'openssl-1.1' 'sdl2' 
  'libpulse' 'hicolor-icon-theme' 'libxss' 'sqlite' 'libtool' 
  'libxslt' 'qt5-base' 'libjpeg-turbo' 'libpng12')
optdepends=(
  'libtiff5: Provide libtiff.so.5 for wpspdf working'
  'cups: for printing support'
  'libjpeg-turbo: JPEG image codec support'
  'pango: for complex (right-to-left) text support'
  'curl: An URL retrieval utility and library'
  'ttf-wps-fonts: Symbol fonts required by wps-office')
source=(
  '0001-fix-wps-python-parse.patch')
source_x86_64=(
  "https://ks3.wpsplus.wpscdn.cn/img/wps-office_${pkgver}.AK.preload.sw_amd64.deb")
source_aarch64=(
  "https://ks3.wpsplus.wpscdn.cn/img/wps-office_${pkgver}.AK.preload.sw_arm64.deb")
sha256sums=('8325d6176ef26f14b5d560a3ec5d103cbbc0c9488efaa0570d4f0ddcd1fa1cd9')
sha256sums_x86_64=('adf958d5cc0f99890991cb77e703de4b8c5f44944a9647ab813591618b8ffd01')
sha256sums_aarch64=('046c502366b888b9216e48346f02b16007a95b02cfcd448c51f160c19d9a4686')

package(){
  tar --no-same-owner -xJ -f data.tar.xz -C ${pkgdir}

  # remove file
  rm -r ${pkgdir}/etc/xdg/autostart
  rm -r ${pkgdir}/etc/logrotate.d
  rm -r ${pkgdir}/etc/cron.d

  # use system lib
  rm ${pkgdir}/opt/kingsoft/wps-office/office6/libstdc++.so*
  rm ${pkgdir}/opt/kingsoft/wps-office/office6/libjpeg.so*
  rm ${pkgdir}/opt/kingsoft/wps-office/office6/libfreetype.so*
  [[ "$CARCH" = "aarch64" ]] && rm ${pkgdir}/opt/kingsoft/wps-office/office6/addons/cef/libm.so*

  # fix python
  patch -p1 -d ${pkgdir} < 0001-fix-wps-python-parse.patch
}

