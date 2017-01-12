#! /bin/bash

DOWNLOADS_DIR=$HOME/Downloads
LIBRARIES_DIR=$HOME/Libraries
NDK_ROOT=$LIBRARIES_DIR/android-sdk/ndk-bundle
# If the icu tools are needed, then compile with API level 19, which provides the header exec_elf.h containing the definition of ELF64_ST_INFO
# The compiled icu may then not be compatible with xerces-c which must be compiled with API level at least 21 containing the needed lconv definition in the header locale.h
# Careful: Qt5 needs API level 19 because it needs the asm/procinfo.h header
ANDROID_PLATFORM="android-21"

ANDROID_TOOLCHAIN_VERSION=4.9

QT_VERSION=5.7
