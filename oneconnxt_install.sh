#!/bin/bash
os=$(uname -a | awk '{print $1}')
if [ $os == 'Linux' ]; then
    brew install pkg-config yasm x264 x265 fdk-aac rtmpdump
    export PKG_CONFIG_PATH=$HOME/.linuxbrew/lib/pkg-config
elif [ $os == "Darwin" ]; then
    brew install pkg-config yasm x264 x265 fdk-aac rtmpdump
fi

rm -rf $HOME/Sources/temp
mkdir $HOME/Sources/temp
sudo chown $USER $HOME/Sources/temp
cd $HOME/Sources/temp

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

wget https://www.dropbox.com/s/5rza40qw8tzd0to/Blackmagic_DeckLink_SDK_10.4.zip?dl=1 -O $HOME/Sources/temp/blackmagicSDK.zip
unzip blackmagicSDK.zip
mv Blackmagic\ DeckLink\ SDK\ 10.4 blackmagicSDK

git clone git://github.com/lu-zero/bmdtools
sudo chown $USER $home/Sources/temp/bmdtools
cd $HOME/Sources/temp/bmdtools
if [ $os == 'Linux' ]; then
    sudo make SDK_PATH=$HOME/Sources/temp/blackmagicSDK/SDK/Linux/include
elif [ $os == "Darwin" ]; then
    make SDK_PATH=$HOME/Sources/temp/blackmagicSDK/SDK/Mac/include
fi


