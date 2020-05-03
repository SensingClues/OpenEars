# Last tests were done on Pi3b+ and P4-4GB.
# OS image was Buster.  See: https://www.raspberrypi.org/downloads/raspbian/.
# Any version will do, but for the outside sensor the Raspbian Buster Lite version is enough.  No much use for a GUI in a tree.

# This fileid must be taken from the shareble link from the google drive
export fileid=11Yw_Qdk8AzRFlcmnUlVd0ExjK9TLTbzJ

echo Redo apt update and upgrade, just in case
sudo apt-get update
sudo apt-get upgrade

echo Install a bunch of packages
sudo apt-get install -y libblas-dev liblapack-dev python3-dev libatlas-base-dev gfortran python3-setuptools nano
sudo apt-get install -y python3-pip libportaudio2 portaudio19-dev mosquitto mosquitto-clients libhdf5-serial-dev
sudo apt-get install -y libhdf5-dev python3-h5py python3-cffi g++ alsa-base alsa-utils libasound2-dev llvm-7

echo Unqualified python command now uses python3
update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1

echo Prevent pulseaudio from starting: pulseaudio locks all the alsa drivers so no settings from asound can be used.
if [ -f /etc/pulse/client.conf ]; then
	mkdir /home/pi/.config/pulse
	cp /etc/pulse/client.conf /home/pi/.config/pulse
	sed  -i '/; autospawn = yes/autospawn = no/' /home/pi/.config/pulse/client.conf
fi

echo Get vggish convolution model from Google drive.
cd ../../../devicehive-dev
rm -rf models
export filename=models.zip
wget --save-cookies cookies.txt 'https://docs.google.com/uc?export=download&id='$fileid -O- \
		| sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1/p' > confirm.txt
wget --load-cookies cookies.txt -O $filename \
		 'https://docs.google.com/uc?export=download&id='$fileid'&confirm='$(<confirm.txt)
rm -f confirm.txt cookies.txt
mkdir models
unzip models.zip -d models
echo Throw away old reenforcement model
rm -f models.zip models/model.ckpt* models/class_labels_indices_amsterdam2.csv

echo " "
echo "*****************************************"
echo "**** Check for Errors!               ****"
echo "**** Please reboot and start part 2! ****"
echo "*****************************************"



