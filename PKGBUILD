# Maintainer: Frantic1048 <archer@frantic1048.com>

pkgname=kreogist-mu
pkgver='0.9.3'
pkgrel=1
epoch=1
pkgdesc="Fantastic cross-platform music manager.based on Qt5"
changelog="kreogist-mu.changelog"
arch=('x86_64')
url="https://kreogist.github.io/Mu/"
license=('GPL')
depends=(
  'qt5-base'
  'pulseaudio'
  'ffmpeg'
  'phonon-qt5'
  'gst-libav'
  'gstreamer0.10-ffmpeg'
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

changelog=$pkgname.changelog

source=(
  "https://github.com/Kreogist/mu-archlinux/releases/download/$pkgver.$pkgrel/$pkgname-resource.tar.gz"
  "git+https://github.com/Kreogist/Mu.git#tag=$pkgver"
)

sha224sums=('SKIP' 'SKIP')

build() {
  mkdir -p $srcdir/Mu-build
  cd $srcdir/Mu-build
  qmake "CONFIG+=release" $srcdir/Mu/mu.pro
  make
}

package() {
  # excecutable
  mkdir -p $pkgdir/usr/bin/kreogist-mu
  install -m775 $srcdir/Mu-build/bin/mu $pkgdir/usr/bin/kreogist-mu

  # i18n files
  # https://github.com/Kreogist/Mu/issues/17#issuecomment-164236195
  mkdir -p $pkgdir/usr/share/Kreogist/mu/Language/
  install -m664 $srcdir/Mu-build/bin/*.qm $pkgdir/usr/share/Kreogist/mu/Language/

  # static resource
  mkdir -p $pkgdir/usr/share/icons/hicolor/512x512/apps/
  install -m664 $srcdir/$pkgname-resource/$pkgname.png $pkgdir/usr/share/icons/hicolor/512x512/apps/
  mkdir -p $pkgdir/usr/share/applications/
  install -m664 $srcdir/$pkgname-resource/$pkgname.desktop $pkgdir/usr/share/applications/
}
