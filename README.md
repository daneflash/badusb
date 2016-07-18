# BadUSB - Intercept TCP Connections via USB Armory

## Additional information
!!! THIS CONTENT IS UNDER CONSTRUCTION AND NOT READY TO USE !!!

## Installation
Start "createBadUSB.sh" to create a BadUSB-Image on SD-Card for USB Armory

On this image open file /home/usbarmory/StartArmoryAndHost.sh and edit the required root-password for the victims linux

## Run
After successful installation, just plug in USB Armory on a running Linux-System.

### Certificate
There a two options for install the required certificate in browser:

#### Manual installation
When USB-Armory is running, just open browser and go to http://mitm.it -> Others and accept the certificate

#### Automatic installation
On image open file /home/usbarmory/Sniff.sh and edit the script (further information is in this script)

## License
This program is provided under an MIT open source license, read the [LICENSE.txt](http://github.com/daneflash/badusb/blob/master/LICENSE.txt) file for details.
