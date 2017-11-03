# !/usr/bin/sh
# this script sets installs all dependencies to develop and run 
# apps for the fischertechnik TXT controller community firmware.
#
# 11/2017 Peter Habermehl
# based upon tx-pi-setup.sh by Till Harbaum

GITBASE="https://raw.githubusercontent.com/ftCommunity/ftcommunity-TXT/master/"
GITROOT=$GITBASE"board/fischertechnik/TXT/rootfs"
SVNBASE="https://github.com/ftCommunity/ftcommunity-TXT.git/trunk/"
SVNROOT=$SVNBASE"board/fischertechnik/TXT/rootfs"
LOCALGIT="https://github.com/harbaum/tx-pi/raw/master/setup"
#

echo "cfw_dev-setup.sh"
echo "================"
echo ""
echo "to set up a ft TXT cfw compatible development environment on your RPi."
echo ""

# update the sw repos
sudo apt-get update

# make sure python3 and py3qt4 are available
echo "Check for python3 and pyqt4 and install , if necessary"
echo ""
sudo apt-get -y install --no-install-recommends python3-pyqt4 python3 python3-pip python3-numpy python3-dev cmake python3-serial python3-pexpect

# misc tools
echo ""
echo "--------------------"
echo "Some more SW tools"
sudo apt-get -y install i2c-tools python3-smbus lighttpd git subversion ntpdate usbmount subversion

# some additionl python stuff
sudo pip3 install semantic_version
sudo pip3 install websockets
sudo pip3 install pyserial

# usbmount config
cd /etc/usbmount
sudo wget -N https://raw.githubusercontent.com/ftCommunity/ftcommunity-TXT/3de48278d1260c48a0a20b07a35d14572c6248d3/board/fischertechnik/TXT/rootfs/etc/usbmount/usbmount.conf

# install bluetooth tools required for e.g. bnep
sudo apt-get -y install --no-install-recommends bluez-tools

# fetch bluez hcitool with extended lescan patch
sudo wget -N $LOCALGIT/hcitool-xlescan.tgz
sudo tar xvfz hcitool-xlescan.tgz -C /usr/bin
sudo rm -f hcitool-xlescan.tgz

# fetch precompiled opencv and its dependencies
# we might build our own package to get rid of these dependencies,
# especially gtk
sudo apt-get -y install libjasper1 libgtk2.0-0 libavcodec56 libavformat56 libswscale3
sudo wget -N https://github.com/jabelone/OpenCV-for-Pi/raw/master/latest-OpenCV.deb
sudo dpkg -i latest-OpenCV.deb
sudo rm -f latest-OpenCV.deb

sudo apt-get -y install --no-install-recommends libzbar0 python3-pil 
sudo apt-get -y install --no-install-recommends libzbar-dev
sudo pip3 install zbarlight

# cfw TouchUI
cd ~
echo "--------------------"
echo "Download and install TouchUI"
echo ""
wget https://github.com/Decad/github-downloader/raw/master/github-downloader.sh
chmod a+x github-downloader.sh
./github-downloader.sh https://github.com/ftCommunity/ftcommunity-TXT/tree/master/board/fischertechnik/TXT/rootfs/opt/ftc
rm -fr ftc/apps ftc/plugins ftc/launcher*.*

# set firmware version
cd /etc
sudo wget -N $GITROOT/etc/fw-ver.txt

# set various udev rules to give ftc user access to
# hardware
cd /etc/udev/rules.d
sudo wget -N $GITROOT/etc/udev/rules.d/40-fischertechnik_interfaces.rules
sudo wget -N $GITROOT/etc/udev/rules.d/40-lego_interfaces.rules
sudo wget -N $GITROOT/etc/udev/rules.d/60-i2c-tools.rules

# HW access
echo "---------------------"
echo "Download ftrobopy and libroboint"
echo ""
cd ftc
wget -N https://raw.githubusercontent.com/ftrobopy/ftrobopy/master/ftrobopy.py

# install libroboint
sudo wget -N $LOCALGIT/libroboint-inst.sh
sudo chmod a+x libroboint-inst.sh
sudo ./libroboint-inst.sh
sudo rm -f libroboint-inst.sh

# finalize
cd ~
mkdir cfw-dev
mv ftc cfw-dev/
rm -f github-downloader.sh
cd cfw-dev

sudo echo >ftc-cfwdev.pth /home/pi/cfw-dev/ftc/
sudo mv ftc-cfwdev.pth /usr/lib/python3/dist-packages/

mkdir apps
cd apps
wget http://cfw.ftcommunity.de/ftcommunity-TXT/media/examples/python/tutorial-1/test.py
chmod +x test.py

sudo touch /etc/ft-cfw-dev.txt