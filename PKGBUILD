# Maintainer: Jove Yu <yushijun110 [at] gmail.com>
pkgname=wps-office-365
pkgver=12.8.2.15283
pkgrel=1
pkgdesc="WPS Office, is an office productivity suite."
arch=('x86_64')
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
  "https://ks3.wpsplus.wpscdn.cn/img/wps-office_${pkgver}.AK.preload.sw_amd64.deb"
  '0001-fix-wps-python-parse.patch')
sha512sums=(
  'e8d424629cbbf77cd7165ff955e2a95ebbb2607811f3ddf50fa708239c03237337936b714b3322731223d050a3b4f22794ac270d197fb57fd97c3d5397da84a4'
  'bf9a86888130f38abee292391e834f31d8527769a5726c897c7443b1fe3861f01c31574950d72153ec0cd0aecd9e3626e670071b4b47b2669da823742e685862')

package(){
	tar -xJ -f data.tar.xz -C ${pkgdir}

  # remove file
  rm -r ${pkgdir}/etc/xdg/autostart
  rm -r ${pkgdir}/etc/logrotate.d
  rm -r ${pkgdir}/etc/cron.d

  # use system lib
  rm ${pkgdir}/opt/kingsoft/wps-office/office6/libstdc++.so*
  rm ${pkgdir}/opt/kingsoft/wps-office/office6/libjpeg.so*

  # fix error: /usr/lib/libfontconfig.so.1: undefined symbol: FT_Done_MM_Var
  sed -i '2a export LD_PRELOAD=/usr/lib/libfreetype.so' ${pkgdir}/usr/bin/{wps,wpp,et,wpspdf,wpsprint}
  # fix python
  patch -p1 -d ${pkgdir} < 0001-fix-wps-python-parse.patch
}
