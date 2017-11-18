#!/bin/sh
#
# build openCV 3.3 on raspbian stretch
# based on https://www.pyimagesearch.com/2017/09/04/raspbian-stretch-install-opencv-3-python-on-your-raspberry-pi/

sudo apt-get -y -f update && sudo apt-get -f -y upgrade

sudo apt-get -y -f install build-essential cmake pkg-config libatlas-base-dev gfortran python2.7-dev python3-dev

sudo apt-get -y -f install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev libxvidcore-dev libx264-dev

sudo apt-get -y -f install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libgtk2.0-dev libgtk-3-dev

cd ~
wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.3.0.zip
unzip opencv.zip
wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.3.0.zip
unzip opencv_contrib.zip


rm -f /usr/local/lib/python3.5/dist-packages/cv2.so

wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo python3 get-pip.py
rm -f get-pip.py

pip install numpy

cd ~/opencv-3.3.0/
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.3.0/modules \
    -D BUILD_EXAMPLES=ON ..

# resize swapfile to enable multicore build
sudo mv /etc/dphys-swapfile /etc/dphys-swapfile.bak
sudo echo >/etc/dphys-swapfile CONF_SWAPSIZE=1024
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

# finally, build
make -j4

# re-set swapfile config
sudo mv /etc/dphys-swapfile.bak /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

# and install...
sudo make install

# the cv2.so gets a cryptical name for unknown reason, so rename it to cv2.so
sudo mv $(ls /usr/local/lib/python3.5/dist-packages/cv*.so
) /usr/local/lib/python3.5/dist-packages/cv2.so

sudo ldconfig


# cleanup
cd ~
rm -f opencv.zip opencv_contrib.zip
rm -fr opencv-3.3.0 opencv_contrib-3.3.0
