PKGNAME=kreogist-mu
PKGVER=$(<PKGBUILD grep pkgver= | cut -d"=" -f 2 | sed "s/[\"']//g")
PKGREL=$(<PKGBUILD grep pkgrel= | cut -d"=" -f 2 | sed "s/[\"']//g")

git config --global user.email ${GIT_EMAIL}
git config --global user.name ${GIT_NAME}
git config --global push.default simple
git config --global push.followTags true
git add .
git commit -m "Torabisu: updated ${PKGNAME} PKGBUILD to ${PKGVER}:${PKGREL}"
git tag "$PKGVER.$PKGREL"
git branch
git tag
git push --quiet https://$GH_TOKEN@github.com/Kreogist/mu-archlinux.git
