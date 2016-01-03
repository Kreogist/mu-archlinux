export PKGNAME=kreogist-mu
export PKGVER=$(<PKGBUILD grep pkgver= | cut -d"=" -f 2 | sed "s/[\"']//g")
export PKGREL=$(<PKGBUILD grep pkgrel= | cut -d"=" -f 2 | sed "s/[\"']//g")

git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_NAME
git diff HEAD
git add .
git commit -m "Travis: updated to ${PKGVER}-${PKGREL}"
git tag "$PKGVER.$PKGREL"
git push --quiet https://$GH_TOKEN@github.com/frantic1048/Mu.git --follow-tags
