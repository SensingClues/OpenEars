echo Install the audio stuff

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=~/Envs 
mkdir -p $WORKON_HOME 
source /usr/local/bin/virtualenvwrapper.sh 
workon serval

pip3 install scipy
pip3 install pyaudio 

#make sure llvm-config-7 is used for resampy llvmlite-0.29.0.tar.gz installation
export LLVM_CONFIG="/usr/bin/llvm-config-7"
pip3 install resampy

pip3 install samplerate
pip3 install pyalsaaudio

echo " "
echo "*****************************************************************"
echo "*** - Check for Errors!                                       ***"
echo "*****************************************************************"
echo " "
echo "*****************************************************************"
echo "*** - Change installpi/configuration.env to correct settings  ***"
echo "*** - Change ~/.asoundrc (umik: use file from installpi)      ***"
echo "***                                                           ***"
echo "*** - When changing models, change the params.py in audio dir ***"
echo "*****************************************************************"


