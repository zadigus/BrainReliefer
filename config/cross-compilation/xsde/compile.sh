#! /bin/bash

if [ $# -lt 2 ] ; then
  echo "Usage: $0 arch api_level"
  echo "arch can be one of linux, aarch64-linux-android, arm-linux-androideabi, mips64el-linux-android, mipsel-linux-android, x86, x86_64"
  exit
fi

source ../commonFcns.sh
source ../commonVars.sh

SRC_PATH=$PWD

ARCH_DIR=$1
API_LVL=$2

function compileXSDE()
{
  MY_ARCH_DIR=$1
  MY_API_LVL=$2

  ROOT_DIR=$DOWNLOADS_DIR/xsde
  TARGET_LIB_DIR=$LIBRARIES/xsde/$MY_ARCH_DIR

  cd $DOWNLOADS_DIR
  rm -Rf xsde
  wget http://www.codesynthesis.com/download/xsde/3.2/xsde-3.2.0-1+dep.tar.bz2
  tar xvf xsde-3.2.0-1+dep.tar.bz2
  mv xsde-3.2.0-1+dep xsde

  cp $SRC_PATH/configuration-lib-dynamic.make $ROOT_DIR/xsde/build/ld/

  if [ $MY_ARCH_DIR == "linux" ] ; then
    # First, compile for the current platform (Ubuntu 16.04 x86_64)
    CPPFLAGS="-std=gnu++03 -I$LIBRARIES/boost/linux-x86_64/include -I$LIBRARIES/xerces-c/linux-x86_64/include -I$LIBRARIES/Libraries/icu/linux-x86_64/include"
    CXXFLAGS="-std=gnu++03 -I$LIBRARIES/boost/linux-x86_64/include -I$LIBRARIES/xerces-c/linux-x86_64/include -I$LIBRARIES/icu/linux-x86_64/include"
    LDFLAGS="-L$LIBRARIES/boost/linux-x86_64/lib -lboost_filesystem -lboost_system -lboost_regex -L$LIBRARIES/xerces-c/linux-x86_64/lib -lxerces-c -L$LIBRARIES/icu/linux-x86_64/lib -licudata -licui18n -licuio -licuuc"

    cd $ROOT_DIR
    make CXXFLAGS="$CXXFLAGS" CPPFLAGS="$CPPFLAGS" LDFLAGS="$LDFLAGS" dist_prefix=$TARGET_LIB_DIR dist -j 4

    cd $TARGET_LIB_DIR
    make -j 4
  else
    ANDROID_PLATFORM="android-"$MY_API_LVL

    mkdir $LIBRARIES/xsde/$ANDROID_PLATFORM
    TARGET_LIB_DIR=$LIBRARIES/xsde/$ANDROID_PLATFORM/$MY_ARCH_DIR
    mkdir $TARGET_LIB_DIR

    CXX=$(getBin $NDK_ROOT/toolchains/$MY_ARCH_DIR-$ANDROID_TOOLCHAIN_VERSION/prebuilt/linux-x86_64/bin g++)
    CC=$(getBin $NDK_ROOT/toolchains/$MY_ARCH_DIR-$ANDROID_TOOLCHAIN_VERSION/prebuilt/linux-x86_64/bin gcc)
    RANLIB=$(getBin $NDK_ROOT/toolchains/$MY_ARCH_DIR-$ANDROID_TOOLCHAIN_VERSION/prebuilt/linux-x86_64/bin ranlib)
    AR=$(getBin $NDK_ROOT/toolchains/$MY_ARCH_DIR-$ANDROID_TOOLCHAIN_VERSION/prebuilt/linux-x86_64/bin ar)

    SYSROOT="$NDK_ROOT/platforms/$ANDROID_PLATFORM/"$(getPlatformDir $MY_ARCH_DIR)

    LDFLAGS="--sysroot $SYSROOT -L$LIBRARIES/boost/$ANDROID_PLATFORM/$MY_ARCH_DIR/lib -lboost_filesystem -lboost_system -lboost_regex -L$LIBRARIES/xerces-c/$ANDROID_PLATFORM/$MY_ARCH_DIR/lib -lxerces-c -L$LIBRARIES/icu/$ANDROID_PLATFORM/$MY_ARCH_DIR/lib -licudata -licui18n -licuio -licuuc"
    CXXFLAGS="--sysroot $SYSROOT -I$NDK_ROOT/sources/cxx-stl/stlport/stlport/ -I$LIBRARIES/boost/$ANDROID_PLATFORM/$MY_ARCH_DIR/include -I$LIBRARIES/xerces-c/$ANDROID_PLATFORM/$MY_ARCH_DIR/include -I$LIBRARIES/icu/$ANDROID_PLATFORM/$MY_ARCH_DIR/include" # -std=gnu++03"
    CPPFLAGS="--sysroot $SYSROOT -I$NDK_ROOT/sources/cxx-stl/stlport/stlport/ -I$LIBRARIES/boost/$ANDROID_PLATFORM/$MY_ARCH_DIR/include -I$LIBRARIES/xerces-c/$ANDROID_PLATFORM/$MY_ARCH_DIR/include -I$LIBRARIES/icu/$ANDROID_PLATFORM/$MY_ARCH_DIR/include" # -std=gnu++03"

    cd $ROOT_DIR/xsde/libxsde
    make CXXFLAGS="$CXXFLAGS" CPPFLAGS="$CPPFLAGS" LDFLAGS="$LDFLAGS" CC="$CC" CXX="$CXX" AR="$AR" RANLIB="$RANLIB" verbose=1

    cp -R $ROOT_DIR/xsde/libxsde $TARGET_LIB_DIR
  fi
}

compileXSDE $ARCH_DIR $API_LVL

#make CXXFLAGS="--sysroot /home/mihl/Libraries/android-sdk/ndk-bundle/platforms/android-23/arch-x86 -I/home/mihl/Libraries/android-sdk/ndk-bundle/sources/cxx-stl/stlport/stlport/ -I/home/mihl/Libraries/boost/android-23/x86/include -I/home/mihl/Libraries/xerces-c/android-23/x86/include -I/home/mihl/Libraries/icu/android-23/x86/include -std=gnu++03" CPPFLAGS="--sysroot /home/mihl/Libraries/android-sdk/ndk-bundle/platforms/android-23/arch-x86 -I/home/mihl/Libraries/android-sdk/ndk-bundle/sources/cxx-stl/stlport/stlport/ -I/home/mihl/Libraries/boost/android-23/x86/include -I/home/mihl/Libraries/xerces-c/android-23/x86/include -I/home/mihl/Libraries/icu/android-23/x86/include -std=gnu++03" LDFLAGS="--sysroot /home/mihl/Libraries/android-sdk/ndk-bundle/platforms/android-23/arch-x86 -L/home/mihl/Libraries/boost/android-23/x86/lib -lboost_filesystem -lboost_system -lboost_regex -L/home/mihl/Libraries/xerces-c/android-23/x86/lib -lxerces-c -L/home/mihl/Libraries/icu/android-23/x86/lib -licudata -licui18n -licuio -licuuc" CXX="/home/mihl/Libraries/android-sdk/ndk-bundle/toolchains/x86-4.9/prebuilt/linux-x86_64/bin/i686-linux-android-g++" AR="/home/mihl/Libraries/android-sdk/ndk-bundle/toolchains/x86-4.9/prebuilt/linux-x86_64/bin/i686-linux-android-ar" RANLIB="/home/mihl/Libraries/android-sdk/ndk-bundle/toolchains/x86-4.9/prebuilt/linux-x86_64/bin/i686-linux-android-ranlib" verbose=1 CC="/home/mihl/Libraries/android-sdk/ndk-bundle/toolchains/x86-4.9/prebuilt/linux-x86_64/bin/i686-linux-android-gcc"

#make CXXFLAGS="-std=gnu++03 -I/home/mihl/Libraries/boost/linux-x86_64/include -I/home/mihl/Libraries/xerces-c/linux-x86_64/include -I//home/mihl/Libraries/icu/linux-x86_64/include" CPPFLAGS="-std=gnu++03 -I/home/mihl/Libraries/boost/linux-x86_64/include -I/home/mihl/Libraries/xerces-c/linux-x86_64/include -I/home/mihl/Libraries/Libraries/icu/linux-x86_64/include" LDFLAGS="-L/home/mihl/Libraries/boost/linux-x86_64/lib -lboost_filesystem -lboost_system -lboost_regex -L/home/mihl/Libraries/xerces-c/linux-x86_64/lib -lxerces-c -L/home/mihl/Libraries/icu/linux-x86_64/lib -licudata -licui18n -licuio -licuuc"
