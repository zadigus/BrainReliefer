# We need the exec_elf.h which contains the definition of ELF64_ST_INFO
ANDROID_PLATFORM="android-19"

# Need to first build a platform-compliant version of icu
tar xvfz icu4c-58_2-src.tgz
cd icu

BUILD_LINUX=$PWD/linux
BUILD_ARM=$PWD/arm-linux-androideabi

mkdir $BUILD_LINUX
mkdir $BUILD_ARM

# First, compile for the current platform (Ubuntu 16.04 x86_64)
cd $BUILD_LINUX
../source/configure --prefix=$LIBRARIES/icu/linux-x86_64 --enable-static
make
make install

# Then, cross-compile
cd $BUILD_ARM
../source/configure --enable-static --prefix=$LIBRARIES/icu/arm-linux-androideabi --host=arm-linux-androideabi CXX="$NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-g++" CC="$NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc" CPPFLAGS="--sysroot $NDK_ROOT/platforms/$ANDROID_PLATFORM/arch-arm -I$NDK_ROOT/sources/cxx-stl/stlport/stlport/" CFLAGS="--sysroot $NDK_ROOT/platforms/$ANDROID_PLATFORM/arch-arm -I$NDK_ROOT/sources/cxx-stl/stlport/stlport/" LDFLAGS="--sysroot $NDK_ROOT/platforms/$ANDROID_PLATFORM/arch-arm -L$NDK_ROOT/sources/cxx-stl/stlport/libs/armeabi/ -lstlport_shared" RANLIB=$NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/arm-linux-androideabi/bin/ranlib AR=$NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/arm-linux-androideabi/bin/ar --enable-extras=no --enable-tools=yes --enable-tests=no --enable-samples=no --with-cross-build=$BUILD_LINUX


