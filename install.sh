sudo add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu trusty universe"
sudo add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu trusty main"
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo add-apt-repository -y ppa:gstreamer-developers/ppa
sudo apt-get -qq update
yes '' | sudo apt-get -qq install\
  qdbus\
  qmlscene\
  qt5-default\
  qt5-qmake\
  qtbase5-dev-tools\
  qtchooser\
  qtdeclarative5-dev\
  xbitmaps\
  xterm\
  libqt5svg5-dev\
  qttools5-dev\
  qttools5-dev-tools\
  qtscript5-dev\
  qtdeclarative5-folderlistmodel-plugin\
  qtdeclarative5-controls-plugin\
  gstreamer1.0*\
  libavformat-dev\
  libavcodec-dev\
  libavutil-dev\
  libcloog-ppl0\
  tree\
  g++-5
