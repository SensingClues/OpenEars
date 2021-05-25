[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# OpenEars
sensor to classify sounds. It is based on a Raspberri PI mode 3B(+), a USB microphone
and a >2Amp Power supply. Communication is done with MQTT.

# History
SERVAL image (Sound Event Recognition for Vigilance and Localisation) development:
- Devicehive (Open Source IoT Data Platform): 2017 
- Sensing Clues: Juli 2018
- Sensemakers and Sensing Clues: april 2019
- Migrated to Python 3: april 2019

Current image versie: 1.2\
Initial documentation at:  [here](https://www.iotforall.com/tensorflow-sound-classification-machine-learning-applications/)

# Installation
Clone the repository and go to the directory install/pi, choose your python version, and follow the instructions in the INSTALL.md for this version. When done, return here.

After installation, the user - password should be pi - openears. Change as you see fit.\
You can SSH and VNC into the PI, and you should be able to use keyboard, mouse and monitor. If necessary, configure the wifi.
#### Configure MQTT
Go to ~/openears/serval. If there is no serval.env file in this directory, do:\
`cp serval.env.example serval.env`

Open serval.env in an editor, and change the settings to your preferred MQTT broker.

Example of a message: {"sid":"xxxxxx", "timestamp":"1532238433096", "class":" Car passing by", "match":" 0.11"}


#### Configure microphone
If you use the umik, do:\
`cp ~/openears/install/pi/umik.asoundrc ~/.asoundrc`

If you use the trust, do:\
`cp ~/openears/install/pi/trust.asoundrc ~/.asoundrc`

If you use the aiy, do:\
`cp ~/openears/install/pi/aiy.asoundrc ~/.asoundrc`

Check with 'arecord -l' the card number and device number of your microphone and write them down. Then edit the settings (nano /home/pi/.asoundrc) for your microphone and check if you have the right card number and device number. There must be a device with the specifications:

    pcm.rate16000Hz {
	type plug
	slave {
		pcm "hw:2,0" # EXAMPLE. Format: "hw:card,device" 
		rate 16000
		channels 1
		format S16_LE
	}

The mike can be installed on any USB port on the PI. You shoud be able to adjust it with the alsamixer.

ISSUE: after every reboot you'll need to do this step, since .asoundrc is removed from the Pi (see issue list)

#### Configure autostart

This has been disabled somewhere in the developmentchain, needs some work to be enabled again.

#### Change the model
The model is installed in ~/openears/devicehive-dev/models. You can install a new version by copying the files into this directory.

After copying you must adapt the definition in ~/openears/devicehive-dev/audio/params.py.
Adjust YOUTUBE_CHECKPOINT_FILE,	CLASS_LABELS_INDICES and maybe PREDICTIONS_COUNT_LIMIT. If in doubt about the PREDICTIONS_COUNT_LIMIT, contact the supplier of the model.

## Upgrading
If you want to upgrade your installation, goto ~/openears and execute: `git pull`

_Note: we do our best to keep backwards compatible, but please contact us before doing this_

## Running
#### To process prerecorded wav file
goto ~/openears/serval and run:\
`source todevicehive.sh`

You should end up in ~/openears/devicehive-dev in the (serval) virtual environment, and then:

```bash
python parse_file.py path_to_your_file.wav
```
_Note: file must have 16000 rate_

#### To capture and process audio from mic
goto ~/openears/serval and run:\
`source todevicehive.sh`

You should end up in ~/openears/devicehive-dev in the (serval) virtual environment, and then:

```bash
python capture.py
```
It will capture and process samples in a loop.\
To get info about parameters run
```bash
python capture.py --help
```

_Note: there is some strange bug that sometimes the first recording will produce a lot
of Buffer overflows. In the following recordings everything looks normal. Must be looked into_

#### To capture and send to MQTT
goto ~/openears/serval and run:\
`source serval.sh`

After a while, you will see information about MQTT messages on the screen. You can see the messages
themselves in your favourite MQTT client.

If you want every wav file logged, uncomment the line with the CAPTUREPARAMS in serval.env. Please do not do it
in a situation where the serval is running for a long time, because your SD Card will fill up until it dies.


## Useful other info
To train classification model next resources have been used:
* [Google AudioSet](https://research.google.com/audioset/)
* [YouTube-8M model](https://github.com/google/youtube-8m)
* [Tensorflow vggish model](https://github.com/tensorflow/models/tree/master/research/audioset)

You can try to train model with more steps/samples to get more accuracy.
