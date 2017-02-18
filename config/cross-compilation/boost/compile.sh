#! /bin/bash

if [ $# -lt 1 ] ; then
  echo "Usage: $0 arch"
  echo "arch can be one of linux, aarch64-android, arm-android, mips64el-android, mipsel-android, x86-android, x86_64-android"
  exit
fi

source ../commonFcns.sh
source ../commonVars.sh

ARCH=$1

CONFIG_DIR=$PWD

TARGET_LIB_DIR=$LIBRARIES_DIR/boost

mkdir $TARGET_LIB_DIR

ROOT_DIR=$DOWNLOADS_DIR/boost
SRC_DIR=$ROOT_DIR

if [ -d $ROOT_DIR ] ; then
  echo "Folder $ROOT_DIR already exists."
  #exit
fi

cd $DOWNLOADS_DIR
if [ ! -f boost_1_63_0.tar.gz ] ; then
  wget http://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.gz
fi
tar xvfz boost_1_63_0.tar.gz
rm -Rf boost
mv boost_1_63_0 boost

# First, compile for the current platform (Ubuntu 16.04 x86_64)
cd $ROOT_DIR
./bootstrap.sh
cp $CONFIG_DIR/$ARCH-config.jam project-config.jam
#./bootstrap.sh --with-icu=$LIBRARIES/icu/linux-x86_64 --prefix=$TARGET_LIB_DIR/linux-x86_64 --with-toolset=gcc --with-libraries=filesystem,regex
./b2 --toolset=gcc link=static runtime-link=static install
