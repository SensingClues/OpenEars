export WORKON_HOME=~/Envs 
mkdir -p $WORKON_HOME 
source /usr/local/bin/virtualenvwrapper.sh 
workon serval

python3 -m pip install scipy
pyhton3 -m pip install pyaudio 

python3 -m pip  install resampy
# version 0.2.x of resampy uses llvmlite newest version.
# that is why we use llvm-7 from unstable

python3 -m pip install samplerate
pyhton3 -m pip install pyalsaaudio

echo " "
echo "*****************************************************************"
echo "*** - Check for Errors!                                       ***"
echo "*****************************************************************"
echo " "
echo "*****************************************************************"
echo "*** - Change installpi/configuration.env to correct settings  ***"
echo "*** - Reset swapspace to 0                                    ***"
echo "*** - Change ~/.asoundrc (umik: use file from installpi)      ***"
echo "***                                                           ***"
echo "*** - When changing models, change the params.py in audio dir ***"
echo "*****************************************************************"


