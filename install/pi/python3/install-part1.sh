# Last tests were done on Pi3b+ and P4-4GB.
# OS image was Buster.  See: https://www.raspberrypi.org/downloads/raspbian/.
# Any version will do, but for the outside sensor the Raspbian Buster Lite version is enough.  No much use for a GUI in a tree.

# This fileid must be taken from the shareble link from the google drive
export fileid=11Yw_Qdk8AzRFlcmnUlVd0ExjK9TLTbzJ

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install -y nano
sudo apt-get install -y libblas-dev liblapack-dev python3-dev libatlas-base-dev gfortran python3-setuptools git
sudo apt-get install -y python3-pip
sudo apt-get install -y libportaudio2 portaudio19-dev
sudo apt-get install -y mosquitto
sudo apt-get install -y mosquitto-clients
sudo apt-get install -y libhdf5-serial-dev
sudo apt-get install -y libhdf5-dev
sudo apt-get install -y python3-h5py
sudo apt-get install -y python3-cffi
sudo apt-get install -y g++
sudo apt-get install -y alsa-base alsa-utils
sudo apt-get install -y libasound2-dev

#make sure python3 is used as python
update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1


#get llvm-7 running on stretch from unstable
sudo tee /etc/apt/sources.list.d/serval-extra.list > /dev/null  <<EOF 
#HACKHACKHACK
#This is for llvm-7. as that is not in the backports for now
#needed for installing 
#deb http://deb.debian.org/debian stretch-backports main
deb [trusted=yes] http://http.us.debian.org/debian sid main non-free contrib

EOF

sudo apt-get update
sudo apt-get install -y llvm-7/unstable
#make sure no other upgrades come from unstable
sudo tee /etc/apt/sources.list.d/serval-extra.list > /dev/null  <<EOF 
#HACKHACKHACK
#This is for llvm-7. as that is not in the backports for now
#needed for installing 
#deb http://deb.debian.org/debian stretch-backports main
#deb [trusted=yes] http://http.us.debian.org/debian sid main non-free contrib


EOF

#prevent pulseaudio of starting: pulseaudio locks all the alsa drivers so no settings from asound can be used
if [ -f /etc/pulse/client.conf ]; then
	mkdir /home/pi/.config/pulse
	cp /etc/pulse/client.conf /home/pi/.config/pulse
	sed  -i '/; autospawn = yes/autospawn = no/' /home/pi/.config/pulse/client.conf
fi

# google drive for model. Will probably change in future
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

echo " "
echo "*****************************************"
echo "**** Check for Errors!               ****"
echo "**** Please reboot and start part 2! ****"
echo "*****************************************"



