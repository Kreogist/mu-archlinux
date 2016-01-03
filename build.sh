pwd
mkdir src
mkdir build
mkdir pkg
export OLDPKGVER=$(<PKGBUILD grep pkgver= | cut -d"=" -f 2 | sed "s/[\"']//g")
export OLDPKGREL=$(<PKGBUILD grep pkgrel= | cut -d"=" -f 2 | sed "s/[\"']//g")
export PKGARCH=$(<PKGBUILD grep arch= | cut -d"=" -f 2 | sed "s/[\"'()]//g")
export ROOT=$(pwd)

cd $ROOT/src
git clone --depth=10 https://github.com/Kreogist/Mu.git
cd Mu
export MUVER=`git tag | tail -n 1`
git checkout $MUVER

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
qmake "CONFIG+=release" $ROOT/src/Mu/mu.pro
tree ./ -I src/
make
tree ./ -I src/
echo finished build Mu-v$MUVER

cd $ROOT/pkg
mkdir kreogist-mu-$PKGVER-$PKGREL-$PKGARCH
cd kreogist-mu-$PKGVER-$PKGREL-$PKGARCH
mkdir bin
mkdir i18n
mkdir other
cp $ROOT/build/bin/mu bin/$PKGNAME
cp $ROOT/build/bin/*.qm i18n/
cp $ROOT/PKGNAME.desktop other/
cp $ROOT/PKGNAME.png other/
cd ..
tar -zcvf kreogist-mu-$PKGVER-$PKGREL-$PKGARCH.tar.gz kreogist-mu-$PKGVER-$PKGREL-$PKGARCH
export PKGMD5=$(md5sum kreogist-mu-$PKGVER-$PKGREL-$PKGARCH.tar.gz | cut -d" " -f 1)
tree ./

cd $ROOT
<PKGBUILD \
  sed "s/^pkgver=.*$/pkgver='${PKGVER}'/" |
  sed "s/^pkgrel=.*$/pkgrel=${PKGREL}/" |
  sed "s/^md5sums=.*$/md5sums=('${PKGMD5}')/" \
>PKGBUILD

echo updated PKGBUILD
echo "$OLDPKGVER-$OLDPKGREL -> $PKGVER-$PKGREL"