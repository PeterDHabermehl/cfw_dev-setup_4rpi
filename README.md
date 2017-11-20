# cfw_dev-setup_4rpi

Sets up an App development environment for the fischertechnik TXT community firmware on raspbian stretch.


![cfw app startIDE running on RPi, ready to control a ft model](https://github.com/PeterDHabermehl/cfw_dev-setup_4rpi/raw/master/img/startIDEonRPi.png)
Picture above: cfw app startIDE running on RPi, ready to control a ft model.

The most common way to create apps for the [Fischertechnik Robotics TXT Controller community firmware](http://cfw.ftcommunity.de/) is to use the Python3 language and the TXT-specific Py3Qt4 based TouchUI Python module.

The aim of this shell setup script is to install all dependencies needed for app development on a raspbian stretch system. It is therefore based on a regular raspibian stretch installation with graphical user interface.

After running this script, you might:
- use your RPi to create new apps for the cfw
- run existing cfw apps on your RPi desktop

The installed software is:

- python3 and python3qt4 including its dependencies (should already be available on a regular stretch install)
- TouchUI and TouchAuxiliary python modules as a base framework for the apps
- ftrobopy module to address the TXT I/O hardware
- libroboint python module to address the whole RoboInterface family of fischertechnik robotics controllers

# howto...
## Step 1:
Get a SD card of at least 16GB. Install [raspbian stretch](https://www.raspberrypi.org/downloads/raspbian/) with desktop environment on it and set up your RPi with this card as you would usually do. You might also try to run this install script on your existing stretch install, but, alas, do so on your own risk...

## Step 2:
Open up a terminal window, cd to your home directory (assuming you use the standard user name "pi"), get the install script, make it executeable and ... let it run!
This would be:

- cd ~
- wget https://github.com/PeterDHabermehl/cfw_dev-setup_4rpi/raw/master/cfw_dev-setup.sh
- chmod a+x ./cfw_dev-setup.sh
- ./cfw_dev-setup.sh

Drink a coffee...

## Step 3:
If you intend to use openCV, you have to build it yourself. For your convenience, I put the build instructions I found at
https://www.pyimagesearch.com/2017/09/04/raspbian-stretch-install-opencv-3-python-on-your-raspberry-pi/
into another nifty little sh script. So basically

- wget https://github.com/PeterDHabermehl/cfw_dev-setup_4rpi/raw/master/build_openCV3.sh
- chmod a+x ./build_openCV3.sh
- ./build_openCV3.sh

would download all dependencies and build and install openCV3 to your RPi. After launching the script...

Drink much more coffee...

Build might take some (between 1.5 and 5 hours!)

## You're done
Find test.py in the folder ~/cfw-dev/apps/

Start it from the shell, it is supposed to open an empty window in cfw style.
- cd ~/cfw-dev/apps/
- chmod +x test.py
- ./test.py

![test.py](https://github.com/PeterDHabermehl/cfw_dev-setup_4rpi/raw/master/img/test.py.png)

You now can start writing your own apps according to the [cfw documentation](http://cfw.ftcommunity.de/), Section Programming/Python, or you can download and unpack existing cfw apps and launch them from the shell...


# This is work in progress, basically just started.
# currently, openCV only works if you build it yourself as described above. Have in mind that the script above installs openCV3.3 whereas the cfw on TXT comes with openCV3.2.0. Take care that code intended for the actual TXT is backwards compatible to 3.2.0.
# other issues may arise any time and at any reason

## use at own risk...
...and have fun :-)
