#! /bin/bash

API_LVL="23"

./compile.sh linux $API_LVL

for ARCH in `ls $NDK_ROOT/toolchains/`; do
  ARCH_DIR=${ARCH%-*}

  if [ $ARCH_DIR != "llvm" ] ; then

    echo "###########################################################"
    echo "ARCH = $ARCH_DIR"
    echo "###########################################################"

   ./compile.sh $ARCH_DIR $API_LVL

  fi

done
