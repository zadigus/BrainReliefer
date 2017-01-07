#! /bin/bash

function getBin()
{ # get e.g. bin ranlib in folder $NDK_ROOT/toolchains/$ARCH/prebuilt/linux-x86_64/bin
  SEARCH_DIR=$1
  SEARCH_BIN=$2

  if [ $SEARCH_BIN != "gcc" ] ; then
    for path_to_bin in `ls $SEARCH_DIR/*-$SEARCH_BIN`; do
      if [ ${path_to_bin%gcc*} == $path_to_bin ] ; then 
        echo $path_to_bin
        break
      fi 
    done
  else
    echo $(ls $SEARCH_DIR/*-$SEARCH_BIN)
  fi
}

function getPlatformDir()
{ # we want to get a directory name in $NDK_ROOT/platforms/$ANDROID_PLATFORM/ 
  # based on the name of a directory in $NDK_ROOT/toolchains/
  ARCH=$1
 
  declare -A platforms
  platforms["aarch64"]="arm64"
  platforms["arm"]="arm"
  platforms["mips64el"]="mips64"
  platforms["mipsel"]="mips"
  platforms["x86"]="x86"
  platforms["x86_64"]="x86_64"

  echo "arch-"${platforms[$(echo $ARCH | cut -d "-" -f 1)]}
}

function getSTLPortLibDir()
{ # we want to get a directory name in $NDK_ROOT/sources/cxx-stl/stlport/libs/
  # based on the name of a directory in $NDK_ROOT/toolchains/
  ARCH=$1

  declare -A libDir
  libDir["aarch64"]="arm64-v8a"
  libDir["arm"]="armeabi-v7a"
  libDir["mips64el"]="mips64"
  libDir["mipsel"]="mips"
  libDir["x86"]="x86"
  libDir["x86_64"]="x86_64"

  echo ${libDir[$(echo $ARCH | cut -d "-" -f 1)]}
}

DOWNLOADS_DIR=$HOME/Downloads
LIBRARIES_DIR=$HOME/Libraries
NDK_ROOT=$LIBRARIES_DIR/android-sdk/ndk-bundle
TARGET_LIB_DIR=$LIBRARIES_DIR/icu

# If the tools are needed, then compile with API level 19, which provides the header exec_elf.h containing the definition of ELF64_ST_INFO
# The compiled icu may then not be compatible with xerces-c which must be compiled with API level at least 21 containing the needed lconv definition in the header locale.h
ANDROID_PLATFORM="android-21"

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
make
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

    $SRC_DIR/configure --enable-static --prefix=$TARGET_LIB_DIR/$ARCH_DIR --host=$ARCH_DIR CXX=$CXX CC=$CC CPPFLAGS="$CPPFLAGS" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" RANLIB=$RANLIB AR=$AR --enable-extras=no --enable-tools=no --enable-tests=no --enable-samples=no --with-cross-build=$BUILD_LINUX

    make
    make install

  fi

done
