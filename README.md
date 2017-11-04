# cfw_dev-setup_4rpi

Sets up an App development environment for the fischertechnik TXT community firmware on raspbian

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

# This is work in progress, basically just started.
# currently, openCV does not work as expected since there are no python3.5 bindings
# other issues may arise any time and at any reason

## use at own risk...
...and have fun :-)
