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
  'gstreamer0.10-ffmpeg')
optdepends=(
  'gst-plugins-good: good plugin libraries'
  'gst-plugins-bad: bad plugin libraries'
  'gst-plugins-ugly: ugly plugin libraries'
)
makedepend=(

)

changelog=$pkgname.changelog
source=(
  "https://github.com/Kreogist/mu-archlinux/releases/download/$pkgver.$pkgrel/$pkgname.tar.gz"
  "git+https://github.com/Kreogist/Mu.git#tag=$pkgver"
)
sha224sums=('SKIP')

package() {
  cd "$pkgname"
  install -d  "$pkgdir/usr/bin/"
  install -m=775 "bin/$pkgname" "$pkgdir/usr/bin"

  # i18n files
  # https://github.com/Kreogist/Mu/issues/17#issuecomment-164236195
  install -d "$pkgdir/usr/share/Kreogist/mu/Language"
  install -m=664 i18n/*.qm "$pkgdir/usr/share/Kreogist/mu/Language"

  install -d "$pkgdir/usr/share/icons/hicolor/512x512/apps/"
  install -m=664 "other/$pkgname.png" "$pkgdir/usr/share/icons/hicolor/512x512/apps/"

  install -d "$pkgdir/usr/share/applications/"
  install -m=664 "other/$pkgname.desktop" "$pkgdir/usr/share/applications/"
}
