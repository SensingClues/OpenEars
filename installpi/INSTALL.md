[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# Installation from scratch
Not for the weak at heart, it will take a couple of hours and some more, and it
is a somewhat quick-aging method for your SD card as a result of all the write operations during compilation. But.. you will end up with a clean install. 

The Pi must be model 3B(+), the SD card must be at least 16GB

## Step 1: install stretch
Grab a "stretch version with desktop" from raspberrypi.org and install on SD as
is prescribed by your host system (Windows, Mac, Linux)

For headless operation, perform the following configuration on the SD card:
Activate SSH (in boot partition of SD card: `touch SSH` for Linux), Wifi (configure the /etc/wpa_supplicant/wpa_supplicant.conf)

Start the pi and ssh into it.

From this point on, all the installation steps are offcourse done on the pi, not on your host system (!) 

Set the password with `sudo raspi-config` for the pi user to "openears" (or whatever you think is appropriate, jot it down!). Best to install VNC also.

Make the VNC autostart (if you like that) with the method described here: https://learn.adafruit.com/adafruit-raspberry-pi-lesson-7-remote-control-with-vnc/running-vncserver-at-startup 

## Step 2: Get the code on the pi
Clone this gitrepo into the pi user home directory, so run on the pi:\
`git clone https://github.com/sensingclues/openears.git openears`

## Step 3: Install part 1
The installation is divided into three shell scripts. After every script a reboot is advised. 
Although it should not be necessary, I have encountered some behaviour that pointed
to a memory leak during install.

Before starting the first script, we have to activate some virtual memory (otherwise compilation will be a nono):
* Set CONF_SWAPSIZE=2048 in /etc/dphys-swapfile (use: sudo nano dphys-swapfile)
* run: `sudo /etc/init.d/dphys-swapfile stop`
* run: `sudo /etc/init.d/dphys-swapfile start`

Goto the install directory of openears:
`cd ~/openears/installpi`

Now run the first script. It will take 15-30 mins. This will basically install all the apt-get dependencies,
and the current model. The last one is around 270MB:\
`./install-part1.sh`

The model is fetched from a google drive, and as
google is notorious for breaking backwards compatibility there, always check for errors! After installing,
go to ~/openears/devicehive-dev, and check if the models subdirectory exists, and contains some files.

After installation, reboot the pi: `sudo reboot`

## Step 4: Install part 2
After reboot, ssh into the pi, and goto ~/openears/installpi

We will now run the second shellscript:\
`./install-part2.sh`

This will create the virtual environments. It has to compile some packages,
so the runtime is rather long (more then an hour, and dependent on the quality of your SD card)

After installation, reboot the pi: `sudo reboot`

## Step 5: Install part 3
After reboot, ssh into the pi, and goto ~/openears/installpi

We will now run the third shellscript:\
`./install-part3.sh`

This will install the remaining packages, and it will take quiet some time.

## Step 6: Test the installation
go to ~/openears/serval and
execute the command:

`source todevicehive.sh`

After a while you will be in the ~/openears/devicehive-dev directory, with the virtual environment
(serval) indicator before your path in the terminal.

Then execute:\
`python parse_file.py 11k16bitpcm.wav`

After a while messages will appear, for instance Warnings from Tensorflow that more then 10% of
system memory is used. A while later you will see some classifications.

If this works: congrats, Tensorflow and dependencies are installed!

## Step 7: Clean up
The last step is to undo the swap space we installed in step 3.

* Set CONF_SWAPSIZE=100 in /etc/dphys-swapfile (use: sudo nano dphys-swapfile)
* run: `sudo /etc/init.d/dphys-swapfile stop` (may take some time as the swapspace is purged)
* run: `sudo /etc/init.d/dphys-swapfile start`

# Further configuration
Read the README.md in the root directory of this repository

Have fun and happy recording!

\- HR




