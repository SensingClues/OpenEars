[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# OpenEars
sensor to classify sounds. It is based on a Raspberri PI mode 3B(+), a USB microphone
and a >2Amp Power supply. Communication is done with MQTT.

# History
SERVAL image (Sound Event Recognition for Vigilance and Localisation) development:
- Devicehive (Open Source IoT Data Platform): 2017 
- Sensing Clues: Juli 2018
- Sensemakers and Sensing Clues: april 2019

Current image versie: 1.1\
Initial documentation at:  [here](https://www.iotforall.com/tensorflow-sound-classification-machine-learning-applications/)

# Installation
Fetch a preloaded PI image from: (to be determined) and install as you would a standard stretch image\
**or**\
Go to the directory installpi and follow the instructions. When done, return here.

After installation, the user - password should be pi - openears. Change as you see fit.\
You can SSH and VNC into the PI

#### Configure MQTT
Go to ~/openears/serval. If there is no serval.env file in this directory, do:\
`cp serval.env.example serval.env`

Open serval.env in an editor, and change the settings to your preferred MQTT broker.

Example of a message: {"sid":"xxxxxx", "timestamp":"1532238433096", "class":" Car passing by", "match":" 0.11"}


#### Configure microphone
If you use the umik, do:\
`cp ~/installpi/umik.asoundrc ~/.asoundrc`

If you use the trust, do:\
`cp ~/installpi/trust.asoundrc ~/.asoundrc`

If you use a different mike, adapt the .asoundrc. There must be a device with the specifictions:

    pcm.rate16000Hz {
	type plug
	slave {
		pcm trust
		rate 16000
		channels 1
		format S16_LE
	}

The mike can be installed on any USB port on the PI. You shoud be able to adjust it with the alsamixer.


#### Configure autostart

This has been disabled somewhere in the developmentchain, needs some work to be enabled again.

#### Change the model
The model is installed in ~/openears/devicehive-dev/models. You can install a new version by copying the files into this directory.

After copying you must adapt the definition in ~/openears/devicehive-dev/audio/params.py.
Adjust YOUTUBE_CHECKPOINT_FILE,	CLASS_LABELS_INDICES and maybe PREDICTIONS_COUNT_LIMIT. If in doubt about the PREDICTIONS_COUNT_LIMIT, contact the supplier of the model.


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
