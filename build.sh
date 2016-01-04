pwd
mkdir src
mkdir build
mkdir pkg
export PKGNAME=kreogist-mu
export OLDPKGVER=$(<PKGBUILD grep pkgver= | cut -d"=" -f 2 | sed "s/[\"']//g")
export OLDPKGREL=$(<PKGBUILD grep pkgrel= | cut -d"=" -f 2 | sed "s/[\"']//g")
export PKGARCH=$(<PKGBUILD grep arch= | cut -d"=" -f 2 | sed "s/[\"'()]//g")
export ROOT=$(pwd)

cd $ROOT/src
export MUVER=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/Kreogist/Mu/git/refs/tags | sed -e "1 i (" -e "$ a ).pop().ref" | xargs -0 node -p | sed -e "s/refs\/tags\///")

# compute new pkgver, pkgrel
if [[ $PKGVER = $MUVER ]]
then
  # version no update
  # increase pkgrel
  export PKGVER=$OLDPKGVER
  export PKGREL=$((OLDPKGREL + 1))
else
  # new version
  export PKGVER=$MUVER
  export PKGREL=1
fi

cd $ROOT/build
# qmake "CONFIG+=release" $ROOT/src/Mu/mu.pro
# make
# echo finished build Mu-v$MUVER

cd $ROOT/pkg
mkdir kreogist-mu
cd kreogist-mu
mkdir other
cp $ROOT/$PKGNAME.desktop other/
cp $ROOT/$PKGNAME.png other/
cd ..
tar -zcvf $PKGNAME.tar.gz $PKGNAME
export PKGSHASUM=$(sha224sum $PKGNAME.tar.gz | cut -d" " -f 1)

cd $ROOT
sed -i \
  -e "s/^pkgver=.*$/pkgver='${PKGVER}'/" \
  -e "s/^pkgrel=.*$/pkgrel=${PKGREL}/" \
  -e "s/^sha224sums=.*$/sha224sums=('${PKGSHASUM}')/" \
PKGBUILD

sed -i \
  -e  "s/Version-.*.svg/Version-${PKGVER}:${PKGREL}-FF5174.svg/" \
README.md

echo "updated PKGBUILD $OLDPKGVER:$OLDPKGREL -> $PKGVER:$PKGREL"
