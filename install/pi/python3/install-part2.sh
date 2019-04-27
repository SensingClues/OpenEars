#export LC_ALL="en_US.UTF-8"
#export LC_CTYPE="en_US.UTF-8"
#sudo dpkg-reconfigure locales

sudo apt install python3-venv
#sudo apt install python3-virtualenv python3-pbr python3-stevedore virtualenvwrapper
#sudo pip3 install virtualenv
sudo pip3 install virtualenvwrapper


export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=~/Envs
mkdir -p $WORKON_HOME
python3 -m venv --system-site-packages --without-pip ~/Envs/serval

source /usr/local/bin/virtualenvwrapper.sh
#mkvirtualenv -p /usr/bin/python3 --system-site-packages serval
workon serval

python3 -m pip install wheel
python3 -m pip install tensorflow==1.9.0
#python3 -m pip install tensorflow  # installs the latest in piwheels, currently tensorflow-1.13.1-cp35-none-linux_armv7l.whl
#python3 -m pip install https://www.piwheels.org/simple/tensorflow/tensorflow-1.13.1-cp37-none-linux_armv7l.whl#sha256=6c00dd13db0791e83cb08d532f007cc7fd44c8d7b52662a4a0065ac4fe7ca18a  #not accepted: it is somehow not available
python3 -m pip install Cython
python3 -m pip install pandas
python3 -m pip install h5py

echo " "
echo "*****************************************"
echo "**** Check for Errors!               ****"
echo "**** Please reboot and start part 3! ****"
echo "*****************************************"

