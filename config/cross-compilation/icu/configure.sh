#! /bin/bash

source ../commonFcns.sh
source ../commonVars.sh

TARGET_LIB_DIR=$LIBRARIES_DIR/icu

ROOT_DIR=$DOWNLOADS_DIR/icu
SRC_DIR=$ROOT_DIR/source

if [ -d $ROOT_DIR ] ; then
  echo "Folder $ROOT_DIR already exists."
  exit
fi

cd $DOWNLOADS_DIR
wget http://download.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz
tar xvfz icu4c-58_2-src.tgz

# First, compile for the current platform (Ubuntu 16.04 x86_64)
BUILD_LINUX=$ROOT_DIR/linux
mkdir $BUILD_LINUX
cd $BUILD_LINUX
$SRC_DIR/configure --prefix=$TARGET_LIB_DIR/linux-x86_64 --enable-static
make -j 4
make install

# Then, cross-compile
for ARCH in `ls $NDK_ROOT/toolchains/`; do
  ARCH_DIR=${ARCH%-*}

  if [ $ARCH_DIR != "llvm" ] ; then

    BUILD_DIR=$ROOT_DIR/$ARCH_DIR
    mkdir $BUILD_DIR
    cd $BUILD_DIR

    CXX=$(getBin $NDK_ROOT/toolchains/$ARCH/prebuilt/linux-x86_64/bin g++)
    CC=$(getBin $NDK_ROOT/toolchains/$ARCH/prebuilt/linux-x86_64/bin gcc)
    RANLIB=$(getBin $NDK_ROOT/toolchains/$ARCH/prebuilt/linux-x86_64/bin ranlib)
    AR=$(getBin $NDK_ROOT/toolchains/$ARCH/prebuilt/linux-x86_64/bin ar)

    SYSROOT="$NDK_ROOT/platforms/$ANDROID_PLATFORM/"$(getPlatformDir $ARCH)

    LDFLAGS="--sysroot $SYSROOT"
    CFLAGS="--sysroot $SYSROOT -I$NDK_ROOT/sources/cxx-stl/stlport/stlport/"
    CPPFLAGS="--sysroot $SYSROOT -I$NDK_ROOT/sources/cxx-stl/stlport/stlport/"

    echo "###########################################################"
    echo "ARCH = $ARCH_DIR"
    echo "###########################################################"

    if [ $ARCH_DIR == "x86" ] ; then
      HOST="i686-linux-android"
    elif [ $ARCH_DIR == "x86_64" ] ; then 
      HOST="x86_64-linux-android"
    else
      HOST=$ARCH_DIR
    fi

    echo $SRC_DIR/configure --enable-static --prefix=$TARGET_LIB_DIR/$ARCH_DIR --host=$HOST CXX=$CXX CC=$CC CPPFLAGS="$CPPFLAGS" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" RANLIB=$RANLIB AR=$AR --enable-extras=no --enable-tools=no --enable-tests=no --enable-samples=no --with-cross-build=$BUILD_LINUX

    make -j 4
    make install

  fi

done
