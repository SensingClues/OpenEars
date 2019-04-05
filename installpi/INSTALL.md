[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# Installation from scratch
Not for the weak at heart, it will take a couple of hours and some more, and it
is a somewhat quick-aging method for your SD card as a result of all the write operations during compilation. But.. you will end up with a clean install. 

The Pi must be model 3B(+), the SD card must be at least 16GB

## Step 1: install stretch
Grab a stretch version with desktop from raspberrypi.org and install on SD as
is convenient for your host system

For headless operation, perform the following configuration on SD card:
Activate SSH (in boot: `touch SSH`), Wifi (configure the /etc/wpa_supplicant/wpa_supplicant.conf)

Start the pi and ssh into it.

Set the password with raspi-config for the pi user to "openears" (or whatever you think is appropriate, jot it down!)

## Step 2: Get the code on the pi
Clone this gitrepo into the pi user home directory, so run on the pi:

    git clone https://github.com/henkrijneveld/openears.git openears

## Step 3: Install part 1
The installation is divided into three shell scripts. After every script a reboot is advised. 
Although it should not be necessary, I have encountered some behaviour that pointed
to a memory leak during install.

All the installationsteps are offcourse done on the pi, not on your host system (!) 

Before starting the first script, we have to activate some virtual memory (otherwise compilation will be a nono):
* Set CONF_SWAPSIZE=2048 in /etc/dphys-swapfile (use: sudo nano dphys-swapfile)
* run: `sudo /etc/init.d/dphys-swapfile stop`
* run: `sudo /etc/init.d/dphys-swapfile start`

Goto the install directory of openears:
`cd ~/openears/installpi`

Now run the first script. It will take 15-30 mins. This will basically install all the apt-get dependencies,
and the current model. The last one is around 270MB.

The model is fetched from a google drive, and as
google is notorious for breaking backwards compatibility there, always check for errors! After installing,
go to ~/openears/devicehive-dev, and check if the models subdirectory exists, and contains some files.

After installation, reboot the pi: `sudo reboot`

## Step 4: Install part 2
After reboot, ssh into the pi, and goto ~/openears/installpi

We will now run the second shellscript. This will create the virtual environments. It has to compile some packages,
so the runtime is rather long (more then an hour, and dependent on the quelity of your SD card)



# Devicehive Audio Analysis
Audio classification feature demo\
Detailed description can be found [here](https://www.iotforall.com/tensorflow-sound-classification-machine-learning-applications/)

## Installation
* Get a copy of this repo
* Install system packages
```bash
sudo apt-get install libportaudio2 portaudio19-dev
```
* Install python requirements
```bash
pip install -r requirements.txt
```

* Download and extract saved models to source directory
```bash
wget https://s3.amazonaws.com/audioanalysis/models.tar.gz
tar -xzf models.tar.gz
```

## Running
#### To process prerecorded wav file
run
```bash
python parse_file.py path_to_your_file.wav
```
_Note: file should have 16000 rate_

#### To capture and process audio from mic
run
```bash
python capture.py
```
It will capture and process samples in a loop.\
To get info about parameters run
```bash
python capture.py --help
```

#### To start web server
run
```bash
python daemon.py
```
By default you can reach it on http://127.0.0.1:8000 \
It will:
* Capture data form your mic
* Process data
* Send predictions to web interface
* Send predictions to devicehive

Also you can configure your devicehive connection though this web interface.

## Useful info
To train classification model next resources have been used:
* [Google AudioSet](https://research.google.com/audioset/)
* [YouTube-8M model](https://github.com/google/youtube-8m)
* [Tensorflow vggish model](https://github.com/tensorflow/models/tree/master/research/audioset)

You can try to train model with more steps/samples to get more accuracy.
