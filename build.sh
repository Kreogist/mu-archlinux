pwd
mkdir pkg
export PKGNAME=kreogist-mu
export OLDPKGVER=$(<PKGBUILD grep pkgver= | cut -d"=" -f 2 | sed "s/[\"']//g")
export OLDPKGREL=$(<PKGBUILD grep pkgrel= | cut -d"=" -f 2 | sed "s/[\"']//g")
export PKGARCH=$(<PKGBUILD grep arch= | cut -d"=" -f 2 | sed "s/[\"'()]//g")
export ROOT=$(pwd)

# get latest Mu's version on github
export MUVER=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/Kreogist/Mu/git/refs/tags | sed -e "1 i (" -e "$ a ).pop().ref" | xargs -0 node -p | sed -e "s/refs\/tags\///")

# compute new pkgver, pkgrel
if [[ $OLDPKGVER = $MUVER ]]
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

cd $ROOT/pkg

mkdir $PKGNAME-resource
cd $PKGNAME-resource
cp $ROOT/$PKGNAME.desktop ./
cp $ROOT/$PKGNAME.png ./
cd ..
tar -zcvf $PKGNAME-resource.tar.gz $PKGNAME-resource
export PKGSHASUM=$(sha224sum $PKGNAME-resource.tar.gz | cut -d" " -f 1)

cd $ROOT

# update pkgver, pkgrel, shasums in PKGBUILD
sed -i \
  -e "s/^pkgver=.*$/pkgver='${PKGVER}'/" \
  -e "s/^pkgrel=.*$/pkgrel=${PKGREL}/" \
  -e "s/^sha224sums=.*$/sha224sums=('${PKGSHASUM}' 'SKIP')/" \
PKGBUILD

# update pkgver, pkgrel in README
sed -i \
  -e  "s/Version-.*.svg/Version-${PKGVER}:${PKGREL}-FF5174.svg/" \
README.md

echo "updated PKGBUILD $OLDPKGVER:$OLDPKGREL -> $PKGVER:$PKGREL"
