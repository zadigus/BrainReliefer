#! /bin/bash

if [ $# -lt 3 ] ; then
  echo "Usage: $0 arch compilation_mode api_level [lib_mode=static] [configure_only_flag=0]"
  echo "arch can be one of aarch64-linux-android, arm-linux-androideabi, mips64el-linux-android, mipsel-linux-android, x86, x86_64"
  echo "compilation_mode can be one of debug and release"
  echo "lib_mode can be one of static and shared"
  exit
fi

LIB_MODE="static"
if [ $# -gt 3 ] ; then
  LIB_MODE=$4
fi

CONFIGURE_ONLY=false
if [ $# -eq 5 ] ; then
  echo "Configure only"
  CONFIGURE_ONLY=true
fi

source ../commonFcns.sh
source ../commonVars.sh

ARCH_DIR=$1
COMPILATION_MODE=$2
API_LVL=$3

function compileQt()
{
  MY_ARCH_DIR=$1
  MY_COMPILATION_MODE=$2
  MY_ANDROID_PLATFORM="android-"$3
  MY_LIB_MODE=$4
  MY_CONFIGURE_ONLY=$5
  MY_SYSROOT="$NDK_ROOT/platforms/$MY_ANDROID_PLATFORM/"$(getPlatformDir "$MY_ARCH_DIR-$ANDROID_TOOLCHAIN_VERSION")

  TARGET_LIB_DIR=$LIBRARIES_DIR/Qt/$QT_VERSION

  mkdir $DOWNLOADS_DIR/qt
  ROOT_DIR=$DOWNLOADS_DIR/qt/$QT_VERSION
  mkdir $ROOT_DIR

  # Cross-compile
  mkdir $ROOT_DIR/$ARCH_DIR
  mkdir $ROOT_DIR/$ARCH_DIR/$MY_ANDROID_PLATFORM
  mkdir $ROOT_DIR/$ARCH_DIR/$MY_ANDROID_PLATFORM/$MY_LIB_MODE
  SRC_DIR=$ROOT_DIR/$MY_ARCH_DIR/$MY_ANDROID_PLATFORM/$MY_LIB_MODE/$MY_COMPILATION_MODE

  if [ $MY_CONFIGURE_ONLY == false ] ; then 
    # get the code
    git clone https://code.qt.io/qt/qt5.git $SRC_DIR
    cd $SRC_DIR
    git checkout $QT_VERSION
    git submodule update --init
  else
    cd $SRC_DIR
  fi

  # Remove the zero as null pointer constant error because it prevents the code from compiling with c++11 compiler
  sed -i.bak '/Wzero-as-null-pointer-constant/d' qtbase/mkspecs/features/qt_module_headers.prf

  # arm doesn't compile with qtconnectivity
  # mipsel doesn't compile with qttools and qtscript

  if [ $MY_ARCH_DIR == "mips64el-linux-android" ] ; then

    # well, on my Ubuntu 16.04 LTS, it doesn't compile either in this case
    $SRC_DIR/configure -prefix $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR -extprefix $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR -$MY_LIB_MODE -$MY_COMPILATION_MODE -developer-build -make libs -skip qttranslations -skip qtwebkit -skip qtserialport -skip qtwebkit-examples -skip qtconnectivity -skip qttools -skip qtscript -no-warnings-are-errors -opensource -confirm-license -xplatform android-g++ -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -android-sdk /home/mihl/Libraries/android-sdk -android-ndk-host linux-x86_64 -android-toolchain-version $ANDROID_TOOLCHAIN_VERSION -android-ndk-platform $MY_ANDROID_PLATFORM -android-arch $(getSTLPortLibDir "$MY_ARCH_DIR-$ANDROID_TOOLCHAIN_VERSION") -c++std c++11 -no-opengl -force-debug-info -sysroot $MY_SYSROOT

  elif [ $MY_ARCH_DIR == "mipsel-linux-android" ] ; then

    $SRC_DIR/configure -prefix $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR -extprefix $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR -$MY_LIB_MODE -$MY_COMPILATION_MODE -developer-build -make libs -skip qttranslations -skip qtwebkit -skip qtserialport -skip qtwebkit-examples -skip qtconnectivity -skip qttools -skip qtscript -no-warnings-are-errors -opensource -confirm-license -xplatform android-g++ -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -android-sdk /home/mihl/Libraries/android-sdk -android-ndk-host linux-x86_64 -android-toolchain-version $ANDROID_TOOLCHAIN_VERSION -android-ndk-platform $MY_ANDROID_PLATFORM -android-arch $(getSTLPortLibDir "$MY_ARCH_DIR-$ANDROID_TOOLCHAIN_VERSION") -c++std c++11 -no-opengl -force-debug-info -sysroot $MY_SYSROOT

  elif [ $MY_ARCH_DIR == "arm-linux-androideabi" ] ; then

    # cannot compile qtscript because needs asm/procinfo.h which is only present in old API_LEVELS (i.e. <= 19)

    $SRC_DIR/configure -prefix $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR -extprefix $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR -$MY_LIB_MODE -$MY_COMPILATION_MODE -developer-build -skip qttranslations -skip qtwebengine -skip qtwebkit -skip qtserialport -skip qtwebkit-examples -skip qtconnectivity -no-warnings-are-errors -opensource -confirm-license -xplatform android-g++ -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -android-sdk /home/mihl/Libraries/android-sdk -android-ndk-host linux-x86_64 -android-toolchain-version $ANDROID_TOOLCHAIN_VERSION -android-ndk-platform $MY_ANDROID_PLATFORM -android-arch $(getSTLPortLibDir "$MY_ARCH_DIR-$ANDROID_TOOLCHAIN_VERSION") -c++std c++11 -nomake examples -nomake tests -skip qtscript -force-debug-info -sysroot $MY_SYSROOT

  else

  # static: -make libs

    if [ $MY_LIB_MODE == "static" ] ; then

      $SRC_DIR/configure -prefix $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR -extprefix $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR -$MY_LIB_MODE -$MY_COMPILATION_MODE -developer-build -skip qttranslations -skip qtwebengine -skip qtwebkit -skip qtserialport -skip qtwebkit-examples -skip qtconnectivity -no-warnings-are-errors -opensource -confirm-license -xplatform android-g++ -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -android-sdk /home/mihl/Libraries/android-sdk -android-ndk-host linux-x86_64 -android-toolchain-version $ANDROID_TOOLCHAIN_VERSION -android-ndk-platform $MY_ANDROID_PLATFORM -android-arch $(getSTLPortLibDir "$MY_ARCH_DIR-$ANDROID_TOOLCHAIN_VERSION") -c++std c++11 -make libs -force-debug-info -sysroot $MY_SYSROOT -skip qtpurchasing -qml-debug
    
    else

      $SRC_DIR/configure -prefix $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR -extprefix $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR -$MY_LIB_MODE -$MY_COMPILATION_MODE -developer-build -skip qttranslations -skip qtwebengine -skip qtwebkit -skip qtserialport -skip qtwebkit-examples -skip qtconnectivity -no-warnings-are-errors -opensource -confirm-license -xplatform android-g++ -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -android-sdk /home/mihl/Libraries/android-sdk -android-ndk-host linux-x86_64 -android-toolchain-version $ANDROID_TOOLCHAIN_VERSION -android-ndk-platform $MY_ANDROID_PLATFORM -android-arch $(getSTLPortLibDir "$MY_ARCH_DIR-$ANDROID_TOOLCHAIN_VERSION") -c++std c++11 -force-debug-info -sysroot $MY_SYSROOT -make tools -skip qtpurchasing -qml-debug

    fi


  fi

  make -j 4
  make install

  if [ $MY_LIB_MODE == "static" ] ; then
    # if you don't do that, then Qt doesn't find the -lqtforandroid
    ln -s $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR/plugins/platforms/android/libqtforandroid.a $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR/plugins/platforms/libqtforandroid.a
    ln -s $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR/plugins/platforms/android/libqtforandroid.prl $TARGET_LIB_DIR/$MY_ANDROID_PLATFORM/$MY_COMPILATION_MODE/$MY_ARCH_DIR/plugins/platforms/libqtforandroid.prl
  fi
}

compileQt $ARCH_DIR $COMPILATION_MODE $API_LVL $LIB_MODE $CONFIGURE_ONLY
