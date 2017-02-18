#! /bin/bash

source ../commonFcns.sh
source ../commonVars.sh

ICU_DIR=$LIBRARIES/icu

TARGET_LIB_DIR=$LIBRARIES_DIR/xerces-c

ROOT_DIR=$DOWNLOADS_DIR/xerces-c-3.1.4
SRC_DIR=$ROOT_DIR/src

if [ -d $ROOT_DIR ] ; then
  echo "Folder $ROOT_DIR already exists." # the folder is created after lib archive untar
  #exit
fi

cd $DOWNLOADS_DIR
wget http://www.pirbot.com/mirrors/apache//xerces/c/3/sources/xerces-c-3.1.4.tar.gz
tar xvfz xerces-c-3.1.4.tar.gz

# Compile for Ubuntu 16.04 LTS
BUILD_DIR=$ROOT_DIR/linux-x86_64
mkdir $BUILD_DIR
cd $BUILD_DIR
$ROOT_DIR/configure --prefix=$TARGET_LIB_DIR/linux-x86_64 --enable-static=yes --enable-shared=no --enable-transcoder-icu --with-icu=$ICU_DIR/linux-x86_64 --enable-msgloader-inmemory --disable-threads
make -j 4
#make install

# Cross-compile
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

    LDFLAGS="--sysroot $SYSROOT -L$NDK_ROOT/sources/cxx-stl/stlport/libs/"$(getSTLPortLibDir $ARCH)" -lstlport_shared"
    CFLAGS="--sysroot $SYSROOT -I$NDK_ROOT/sources/cxx-stl/stlport/stlport/"
    CPPFLAGS="--sysroot $SYSROOT -I$NDK_ROOT/sources/cxx-stl/stlport/stlport/"

    echo "###########################################################"
    echo "ARCH = $ARCH_DIR"
    echo "###########################################################"

    $ROOT_DIR/configure --prefix=$TARGET_LIB_DIR/$ANDROID_PLATFORM/$ARCH_DIR --host=$ARCH_DIR --target=$ARCH_DIR CXX=$CXX CC=$CC CPPFLAGS="$CPPFLAGS" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" RANLIB=$RANLIB AR=$AR --enable-static=yes --enable-shared=no --enable-transcoder-icu --with-icu=$ICU_DIR/$ANDROID_PLATFORM/$ARCH_DIR --enable-msgloader-inmemory --disable-threads

    # find crtbegin_so.o and crtend_so.o; it can be that we need to have a look in the lib64 folder 
    PLATFORM_DIR=$(getPlatformDir $ARCH)

    if [ ${PLATFORM_DIR%64} != $PLATFORM_DIR ] ; then
      LIB=$NDK_ROOT/platforms/$ANDROID_PLATFORM/$(getPlatformDir $ARCH)/usr/lib64
      if [ ! -f $LIB/crtbegin_so.o ] ; then
        LIB=$NDK_ROOT/platforms/$ANDROID_PLATFORM/$(getPlatformDir $ARCH)/usr/lib
      fi
    else
      LIB=$NDK_ROOT/platforms/$ANDROID_PLATFORM/$(getPlatformDir $ARCH)/usr/lib
    fi

    cd src
    rm crtbegin_so.o crtend_so.o
    ln -s $LIB/crtbegin_so.o
    ln -s $LIB/crtend_so.o
    cd ..

    make -j 4 verbose=1
#    make install

  fi

done
