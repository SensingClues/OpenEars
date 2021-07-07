sudo apt install python3-venv
sudo pip3 install virtualenvwrapper
sudo pip3 install Cython
sudo apt install python3-pandas
sudo pip3 install h5py
sudo pip3 install wheel

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=~/Envs
mkdir -p $WORKON_HOME

python3 -m venv --system-site-packages --without-pip ~/Envs/serval
source /usr/local/bin/virtualenvwrapper.sh
workon serval

rm -f tensorflow-1.15.0-cp37-cp37m-linux_armv7l.whl 
# wget https://github.com/PINTO0309/Tensorflow-bin/raw/master/tensorflow-1.15.0-cp37-cp37m-linux_armv7l.whl 
# Tensorflow 1 has been moved to archive location - download code provided by TF
curl -sc /tmp/cookie "https://drive.google.com/uc?export=download&id=1GzjSi71jDUOVOoThEAtThEah5SqCoV59" > /dev/null
CODE="$(awk '/_warning_/ {print $NF}' /tmp/cookie)"
curl -Lb /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CODE}&id=1GzjSi71jDUOVOoThEAtThEah5SqCoV59" -o tensorflow-1.15.0-cp37-cp37m-linux_armv7l.whl

pip3 install tensorflow-1.15.0-cp37-cp37m-linux_armv7l.whl

echo " "
echo "*****************************************"
echo "**** Check for Errors!               ****"
echo "**** Please reboot and start part 3! ****"
echo "*****************************************"

