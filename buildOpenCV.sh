#!/bin/bash

function buildOpenCV() {
  version=3.4.0
  
  # UPDATE APT
  sudo apt-get update
  
  # INSTALL DEPS
  sudo apt-get install -y build-essential cmake pkg-config unzip
  sudo apt-get install -y libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
  sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
  sudo apt-get install -y libxvidcore-dev libx264-dev
  sudo apt-get install -y libgtk2.0-dev
  sudo apt-get install -y libatlas-base-dev gfortran
  
  # FETCH SOURCE
  wget -O opencv.zip https://github.com/opencv/opencv/archive/${version}.zip
  wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${version}.zip
  unzip opencv_contrib.zip
  unzip opencv.zip
  
  # CREATE BUILD FOLDER
  cd opencv-${version}
  mkdir build && cd build
  
  # PREPARE CONFIG
  cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=$(pwd)/opencv/usr/local \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${version}/modules \
        -D BUILD_EXAMPLES=ON \
        -D ENABLE_PRECOMPILED_HEADERS=OFF ..
  
  # BUILD LIBRARY USING 4 CORES
  make -j4
  
  ## INSTALL
  sudo make install
  #sudo ldconfig
}

function createPackage() {
  dpkg-deb --build opencv
}

command=$1

case $command in
  package)
    createPackage
    ;;
  build)
    buildOpenCV
    ;;
esac
