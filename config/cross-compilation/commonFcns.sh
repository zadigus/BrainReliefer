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
