export WORKON_HOME=~/Envs 
mkdir -p $WORKON_HOME 
source /usr/local/bin/virtualenvwrapper.sh 
workon serval

pip2 install scipy
pip2 install pyaudio 

pip2 install resampy==0.1.5
# version 0.2.x of resampy uses llvmlite newest version.
# llvmlite requires llvm 7 or higher
# apt-get llvm installs 3.8.1
# requires a lot of compilation, only for new version
# so: use the old version
# pip2 install resampy

pip2 install samplerate
pip2 install pyalsaaudio

echo " "
echo "*****************************************************************"
echo "*** - Check for Errors!                                       ***"
echo "***                                                           ***"
echo "*** - Reset swapspace to 0!                                   ***"
echo "*** - Copy the model to model subdir under devicehive-dev     ***"
echo "*** - Pas devicehive-dev/audio/params.py aan voor het systeem ***"
echo "*** - sudo vi /lib/systemd/system/serval.service # use the    ***"
echo "***   contents from the repo as an example                    ***"
echo "*** - sudo systemctl enable serval.service                    ***"
echo "*** - Pas de ~/.asoundrc aan voor de gebruikte microfoon      ***"
echo "*****************************************************************"


