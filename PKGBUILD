# Maintainer: Frantic1048 <archer@frantic1048.com>

pkgname=kreogist-mu
pkgver='0.9.9.3'
pkgrel=1
epoch=1
pkgdesc="Fantastic cross-platform music manager.based on Qt5"
arch=('x86_64')
url="https://kreogist.github.io/Mu/"
license=('GPL')
changelog="$pkgname.changelog"
depends=(
  'pulseaudio'
  'ffmpeg'
  'phonon-qt5'
  'gst-libav'
  'gstreamer0.10-ffmpeg'
  'desktop-file-utils'
  'hicolor-icon-theme'
)

optdepends=(
  'gst-plugins-good: good plugin libraries'
  'gst-plugins-bad: bad plugin libraries'
  'gst-plugins-ugly: ugly plugin libraries'
)

makedepends=(
  'git'
  'gcc'
  'qt5-tools'
)

source=(
  "https://github.com/Kreogist/mu-archlinux/releases/download/$pkgver.$pkgrel/$pkgname-resource.tar.gz"
  "https://codeload.github.com/Kreogist/Mu/tar.gz/$pkgver"
)

sha224sums=('481526da5c0e5d53f7a95f2d7630a3b4c698fd44853f86dc2347bfc0' '8767ac3acf1cd85fcab2bdac78208b1ad20bf1173b6705bca0d58391')

build() {
  mkdir -p $srcdir/Mu-build
  cd $srcdir/Mu-build
  qmake "CONFIG+=release" $srcdir/Mu-$pkgver/mu.pro
  make
}

package() {
  # excecutable
  mv $srcdir/Mu-build/bin/mu $srcdir/Mu-build/bin/kreogist-mu
  install -d $pkgdir/usr/bin/
  install -m775 $srcdir/Mu-build/bin/kreogist-mu $pkgdir/usr/bin/

  # i18n files
  # https://github.com/Kreogist/Mu/issues/17#issuecomment-164236195
  install -d $pkgdir/usr/share/Kreogist/mu/Language/
  for f in $srcdir/Mu-build/bin/*.qm
  do
    baseName=$(basename $f)
    languageName="${baseName%.qm}"
    install -d $pkgdir/usr/share/Kreogist/mu/Language/$languageName/
    install -m664 $f $pkgdir/usr/share/Kreogist/mu/Language/$languageName/
  done

  # static resource
  install -d $pkgdir/usr/share/icons/hicolor/512x512/apps/
  install -m664 $srcdir/$pkgname-resource/$pkgname.png $pkgdir/usr/share/icons/hicolor/512x512/apps/
  install -d $pkgdir/usr/share/applications/
  install -m664 $srcdir/$pkgname-resource/$pkgname.desktop $pkgdir/usr/share/applications/
}
