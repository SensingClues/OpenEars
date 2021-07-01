# install serval on server for testing purposes
# only download the model

# This fileid must be taken from the shareble link from the google drive
export fileid=11Yw_Qdk8AzRFlcmnUlVd0ExjK9TLTbzJ

echo Get vggish convolution model from Google drive.
cd ../../../devicehive-dev
rm -rf models/vggish
export filename=models.zip
wget --save-cookies cookies.txt 'https://docs.google.com/uc?export=download&id='$fileid -O- \
		| sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1/p' > confirm.txt
wget --load-cookies cookies.txt -O $filename \
		 'https://docs.google.com/uc?export=download&id='$fileid'&confirm='$(<confirm.txt)
rm -f confirm.txt cookies.txt
mkdir models/vggish
unzip models.zip -d models/vggish
echo Throw away old reenforcement model
rm -f models.zip models/vggish/model.ckpt* models/vggish/class_labels_indices_amsterdam2.csv

echo " "
echo "*****************************************"
echo "**** Models downloaded! ****"
echo "*****************************************"
