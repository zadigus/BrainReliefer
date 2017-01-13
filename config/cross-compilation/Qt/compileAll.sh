#! /bin/bash

source ../commonFcns.sh
source ../commonVars.sh
#source ./compileQt.sh

#TARGET_LIB_DIR=$LIBRARIES_DIR/Qt/$QT_VERSION

ANDROID_PLATFORM="android-21"

mkdir $DOWNLOADS_DIR/qt
ROOT_DIR=$DOWNLOADS_DIR/qt/$QT_VERSION
mkdir $ROOT_DIR

# Cross-compile
for ARCH in `ls $NDK_ROOT/toolchains/`; do
  ARCH_DIR=${ARCH%-*}

  if [ $ARCH_DIR != "llvm" ] ; then

    echo "###########################################################"
    echo "ARCH = $ARCH_DIR"
    echo "###########################################################"

    mkdir $ROOT_DIR/$ARCH_DIR

    for COMPILATION_MODE in "debug" "release"; do

      echo "###########################################################"
      echo "COMPILATION MODE = $COMPILATION_MODE"
      echo "###########################################################"

      #SRC_DIR=$ROOT_DIR/$ARCH_DIR/$COMPILATION_MODE

      # get the code
      #git clone https://code.qt.io/qt/qt5.git $SRC_DIR
      #cd $SRC_DIR
      #git checkout $QT_VERSION
      #git submodule update --init

      # Remove the zero as null pointer constant error because it prevents the code from compiling with c++11 compiler
      #sed -i.bak '/Wzero-as-null-pointer-constant/d' qtbase/mkspecs/features/qt_module_headers.prf

      # arm doesn't compile with qtconnectivity
      # mipsel doesn't compile with qttools and qtscript
      # mipsel64 doesn't compile with opengl

      #$SRC_DIR/configure -prefix $TARGET_LIB_DIR/static/$COMPILATION_MODE/$ARCH_DIR -static -$COMPILATION_MODE -developer-build -make libs -skip qttranslations -skip qtwebkit -skip qtserialport -skip qtwebkit-examples -skip qtconnectivity -skip qttools -skip qtscript -no-warnings-are-errors -opensource -confirm-license -xplatform android-g++ -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -android-sdk /home/mihl/Libraries/android-sdk -android-ndk-host linux-x86_64 -android-toolchain-version $ANDROID_TOOLCHAIN_VERSION -android-ndk-platform $ANDROID_PLATFORM -android-arch $(getSTLPortLibDir $ARCH) -c++std c++11 -no-opengl

      #make -j 4
      #make install

      ./compileQt.sh $ARCH_DIR $COMPILATION_MODE $ANDROID_PLATFORM

    done

  fi

done
