sudo pip2 install virtualenv
sudo pip2 install virtualenvwrapper

export WORKON_HOME=~/Envs 
mkdir -p $WORKON_HOME 
source /usr/local/bin/virtualenvwrapper.sh 
mkvirtualenv -p /usr/bin/python2 --system-site-packages serval
workon serval

pip2 install wheel
# on the pi, the tensorflows > 1.10 have a confirmed compilation bug
pip2 install tensorflow==1.9.0
pip2 install Cython
#pip2 install pandas==0.22.0
pip2 install pandas
pip2 install h5py==2.6.0

echo " "
echo "*****************************************"
echo "**** Check for Errors!               ****"
echo "**** Please reboot and start part 3! ****"
echo "*****************************************"

