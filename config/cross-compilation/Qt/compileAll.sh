#! /bin/bash

source ../commonFcns.sh
source ../commonVars.sh

API_LVL="23"

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

      ./compileQt.sh $ARCH_DIR $COMPILATION_MODE $API_LVL

    done

  fi

done
