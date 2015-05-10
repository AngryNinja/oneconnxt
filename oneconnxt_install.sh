#!/bin/bash


brew uninstall pkg-config yasm x264 x265 fdk-aac rtmpdump
brew install pkg-config yasm x264 x265 fdk-aac rtmpdump

export PKG_CONFIG_PATH=/home/bo/.linuxbrew/lib/pkg-config
rm -rf /home/bo/temp
mkdir /home/bo/temp
cd temp

#git clone git://git.ffmpeg.org/rtmpdump
#cd rtmpdump
#sudo make CRYPTO=""  install
#cd ..
#wget http://downloads.sourceforge.net/opencore-amr/fdk-aac-0.1.2.tar.gz
#tar xzvf fdk-aac-0.1.2.tar.gz
#cd fdk-aac-0.1.2
#./configure 
#make
#sudo make install 
#cd ..

#wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
#tar xvf yasm-1.2.0.tar.gz
#cd yasm-1.2.0
#./configure 
#make
#sudo make install

#cd ..

#git clone git://git.videolan.org/x264.git
#cd x264
#./configure  --enable-static --enable-shared --disable-lavf
#make
#sudo make install 
#cd ..

#git clone git://github.com/videolan/x265
#cd x265/build
#cmake ../source
#make 
#sudo make install
#cd ../..

git clone git://github.com/libav/libav
cd libav
./configure --enable-gpl --enable-nonfree  --enable-libx264 --enable-libx265 --enable-libfdk_aac
make -j 8
sudo make install
cd ..

wget https://www.dropbox.com/s/5rza40qw8tzd0to/Blackmagic_DeckLink_SDK_10.4.zip?dl=1 -O /home/bo/temp/blackmagicSDK.zip
unzip blackmagicSDK.zip
mv Blackmagic\ DeckLink\ SDK\ 10.4 blackmagicSDK
git clone git://github.com/lu-zero/bmdtools
cd bmdtools
sudo make SDK_PATH=/home/bo/temp/blackmagicSDK/SDK/Linux/include
