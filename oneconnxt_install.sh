#!/bin/bash
os=$(uname -a | awk '{print $1}')
if [ $os == 'Linux' ]; then
    brew uninstall pkg-config yasm x264 x265 fdk-aac rtmpdump
    brew install pkg-config yasm x264 x265 fdk-aac rtmpdump
    export PKG_CONFIG_PATH=/home/bo/.linuxbrew/lib/pkg-config
elif [ $os == "Darwin" ]; then
    brew install pkg-config yasm x264 x265 fdk-aac rtmpdump
fi

rm -rf $HOME/Sources/temp
mkdir $HOME/Sources/temp
sudo chown $USER $HOME/Sources/temp
cd $HOME/Sources/temp

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
sudo chown $USER $HOME/Sources/temp/libav
cd $HOME/Sources/temp/libav
./configure --enable-gpl --enable-nonfree  --enable-libx264 --enable-libx265 --enable-libfdk_aac
make -j 8
if [ $os == 'Linux' ]; then
    sudo make install
elif [ $os == "Darwin" ]; then
    make install
fi

cd ..

wget https://www.dropbox.com/s/5rza40qw8tzd0to/Blackmagic_DeckLink_SDK_10.4.zip?dl=1 -O /home/bo/temp/blackmagicSDK.zip
unzip blackmagicSDK.zip
mv Blackmagic\ DeckLink\ SDK\ 10.4 blackmagicSDK

git clone git://github.com/lu-zero/bmdtools
sudo chown $USER $home/Sources/temp/bmdtools
cd $HOME/Sources/temp/bmdtools
if [ $os == 'Linux' ]; then
    sudo make SDK_PATH=/home/bo/temp/blackmagicSDK/SDK/Linux/include
elif [ $os == "Darwin" ]; then
    make SDK_PATH=/home/bo/temp/blackmagicSDK/SDK/Mac/include
fi


