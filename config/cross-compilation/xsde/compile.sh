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

  export XSDE_PARSER_VALIDATION="n"

  if [ $MY_ARCH_DIR == "linux" ] ; then
    # First, compile for the current platform (Ubuntu 16.04 x86_64)
    CPPFLAGS="-std=gnu++03 -I$LIBRARIES/boost/linux-x86_64/include -I$LIBRARIES/xerces-c/linux-x86_64/include -I$LIBRARIES/Libraries/icu/linux-x86_64/include"
    CXXFLAGS="-std=gnu++03 -I$LIBRARIES/boost/linux-x86_64/include -I$LIBRARIES/xerces-c/linux-x86_64/include -I$LIBRARIES/icu/linux-x86_64/include"
    LDFLAGS="-L$LIBRARIES/boost/linux-x86_64/lib -lboost_filesystem -lboost_system -lboost_regex -L$LIBRARIES/xerces-c/linux-x86_64/lib -lxerces-c -L$LIBRARIES/icu/linux-x86_64/lib -licudata -licui18n -licuio -licuuc"

    cd $ROOT_DIR
    make CXXFLAGS="$CXXFLAGS" CPPFLAGS="$CPPFLAGS" LDFLAGS="$LDFLAGS" XSDE_PARSER_VALIDATION="$XSDE_PARSER_VALIDATION" dist_prefix=$TARGET_LIB_DIR dist -j 4

    cd $TARGET_LIB_DIR
    make XSDE_PARSER_VALIDATION="$XSDE_PARSER_VALIDATION" -j 4
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

    sed -i '7s/^/xsde_parser_validation:=n\n/' $ROOT_DIR/xsde/libxsde/xsde/makefile

    cd $ROOT_DIR/xsde/libxsde
    make CXXFLAGS="$CXXFLAGS" CPPFLAGS="$CPPFLAGS" LDFLAGS="$LDFLAGS" CC="$CC" CXX="$CXX" AR="$AR" RANLIB="$RANLIB"

    cp -R $ROOT_DIR/xsde/libxsde $TARGET_LIB_DIR
  fi
}

compileXSDE $ARCH_DIR $API_LVL

