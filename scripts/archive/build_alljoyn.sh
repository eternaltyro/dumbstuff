#!/bin/bash

# Make sure only root can run our script
#if [[ $EUID -ne 0 ]]; then
#       echo "This script must be run as root" 1>&2
#       exit 1
#fi


#== Common dependencies
#== Install dependencies for 32bit
sudo apt-get -y install gcc-multilib g++-multilib libc6-i386 libc6-dev-i386 libssl-dev:i386 g++ pkg-config scons curl git-core
curl https://dl-ssl.google.com/dl/googlesource/git-repo/repo > repo
sudo cp repo /usr/local/bin
sudo chmod a+x /usr/local/bin/repo
wget http://ftp.mozilla.org/pub/mozilla.org/xulrunner/releases/3.6.28/sdk/xulrunner-3.6.28.en-US.linux-i686.sdk.tar.bz2
tar -jxvf xulrunner-3.6.28.en-US.linux-i686.sdk.tar.bz2

#== Download and set up junit
wget http://search.maven.org/remotecontent?filepath=junit/junit/4.9/junit-4.9.jar
sudo cp junit-4.9.jar /usr/share/java/
chmod +x jdk-6u32-linux-x64.bin

#== Installing JDK JDK 6u32 must be manually downloaded
./jdk-6u32-linux-x64.bin #Press enter here
sudo mv jdk1.6.0_32 /usr/lib/jvm/

#== Set SUN Java as the default java and javac
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_32/bin/javac 2
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_32/bin/java 2
sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk1.6.0_32/bin/javaws 2

sudo update-alternatives --config javac
sudo update-alternatives --config java
sudo update-alternatives --config javaws

#== Set ENVVARS and soft links
export JAVA_HOME="/usr/lib/jvm/jdk1.6.0_32" # or java-1.5.0-sun
export CLASSPATH="/usr/share/java/junit-4.9.jar"
export GECKO_BASE=~/xulrunner-sdk
export OE_BASE="/opt/tools-master/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian"
sudo ln -s /usr/lib/jvm/java-6-sun /usr/lib/jvm/jdk1.6.0_32


#== Obtain AllJoyn source
mkdir $HOME/alljoyn # for example
pushd $HOME/alljoyn
repo init -u git://github.com/alljoyn/manifest.git
repo sync
repo start master --all
popd

#== Build Alljoyn source
export JAVA_HOME="/usr/lib/jvm/java-6-sun" # or java-1.5.0-sun
export CLASSPATH="/usr/share/java/junit4.9.jar"
export GECKO_BASE=~/xulrunner-sdk
pushd $HOME/alljoyn
scons OS=linux CPU=x86 VARIANT=release


#== TODO
#Clear junk
