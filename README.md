# opencv-arm
Open CV Build for Raspberry Pi Arm6 and Arm7, this script installs all dependencies, fetches source and builds OpenCV for Raspberry Pis.

## Building
To build check out this repo onto your raspberry pi and run:
```
./buildOpenCV.sh build
```

Note: This setup does not currently cross compile, if you need Arm6 binaries for the Raspberry Pi Zero you must compile on the Pi Zero.

## Packaging
To build a re-distributable debian package
```
./buildOpenCV.sh package
```

The built package `opencv.deb` contains compiled binaries and should be installable on machines which did not build the package.


## Installing
Build the debian package and then run:
```
sudo dpkg -i opencv.deb
```
