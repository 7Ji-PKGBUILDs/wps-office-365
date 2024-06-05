# Maintainer: Jove Yu <yushijun110 [at] gmail.com>
pkgname=wps-office-365
pkgver=12.8.2.16969
pkgrel=1
pkgdesc="WPS Office, is an office productivity suite."
arch=('x86_64' 'aarch64')
url="https://365.wps.cn/"
license=('LicenseRef-WPS-EULA')
conflicts=('wps-office')
provides=('wps-office')
makedepends=(
  'tar' 'patchelf')
depends=(
  'fontconfig' 'libxrender' 'xdg-utils' 'glu' 
  'libpulse' 'libxss' 'sqlite' 'libtool' 
  'libxslt' 'libjpeg-turbo' 'libpng12' 'freetype2')
optdepends=(
  'cups: for printing support')
source=(
  '0001-fix-wps-python-parse.patch')
source_x86_64=(
  #"https://ks3.wpsplus.wpscdn.cn/img/wps-office_${pkgver}.AK.preload.sw_amd64.deb")
  "https://ks3.wpsplus.wpscdn.cn/img/WPS365_office${pkgver}_integration_xiezuo4.23.0_amd64.deb")
source_aarch64=(
  #"https://ks3.wpsplus.wpscdn.cn/img/wps-office_${pkgver}.AK.preload.sw_arm64.deb")
  "https://ks3.wpsplus.wpscdn.cn/img/WPS365_office${pkgver}_integration_xiezuo4.23.0_arm64.deb")

sha256sums=('8325d6176ef26f14b5d560a3ec5d103cbbc0c9488efaa0570d4f0ddcd1fa1cd9')
sha256sums_x86_64=('cee58dfd867edfbb0577533354eee0c195dbe862fb55832284adb9c71c6fa6cf')
sha256sums_aarch64=('5a63eaddd4737d650d47025c90a88444c87b11e6dafee0c10c7271d0dd68cc44')

package(){
  tar --no-same-owner -xJ -f data.tar.xz -C ${pkgdir}

  # remove file
  rm -r ${pkgdir}/etc/xdg/autostart
  rm -r ${pkgdir}/etc/{logrotate.d,cron.d}
  rm    ${pkgdir}/usr/bin/{wps_uninstall.sh,wps_xterm}
  rm    ${pkgdir}/usr/share/applications/wps-office-uninstall.desktop

  # use system lib
  rm ${pkgdir}/opt/kingsoft/wps-office/office6/libstdc++.so*
  rm ${pkgdir}/opt/kingsoft/wps-office/office6/libjpeg.so*
  rm ${pkgdir}/opt/kingsoft/wps-office/office6/libfreetype.so*
  [[ "$CARCH" = "aarch64" ]] && rm ${pkgdir}/opt/kingsoft/wps-office/office6/addons/cef/libm.so*

  # fix libtiff.so.5 deps
  patchelf --replace-needed libtiff.so.5 libtiff.so.6 ${pkgdir}/opt/kingsoft/wps-office/office6/libqpdfpaint.so
  patchelf --replace-needed libtiff.so.5 libtiff.so.6 ${pkgdir}/opt/kingsoft/wps-office/office6/libpdfmain.so

  # fix python
  patch -p1 -d ${pkgdir} < 0001-fix-wps-python-parse.patch

  # fix fcitx
  # sed -i '2i export QT_IM_MODULE=fcitx' ${pkgdir}/usr/bin/{wps,wpp,et,wpspdf}
}

