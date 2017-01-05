# if we don't use at least 21, then we don't have the correct definition of lconv in locale.h (i.e. it doesn't contain the decimal_point member)
ANDROID_PLATFORM="android-21"

# the option --with-sysroot= doesn't work!!!
./configure --prefix=$LIBRARIES/xerces-c/arm-linux-androideabi --host=arm-linux-androideabi --target=arm-linux-androideabi CXX="$NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-g++" CC="$NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-gcc" CPPFLAGS="--sysroot $NDK_ROOT/platforms/$ANDROID_PLATFORM/arch-arm -I$NDK_ROOT/sources/cxx-stl/stlport/stlport" CFLAGS="--sysroot $NDK_ROOT/platforms/$ANDROID_PLATFORM/arch-arm -I$NDK_ROOT/sources/cxx-stl/stlport/stlport" LDFLAGS="--sysroot $NDK_ROOT/platforms/$ANDROID_PLATFORM/arch-arm -L$NDK_ROOT/sources/cxx-stl/stlport/libs/armeabi/ -lstlport_shared" --enable-static --enable-transcoder-icu --with-icu=$LIBRARIES/icu58/arm-linux-androideabi --enable-msgloader-inmemory

# TODO: double-check that the src dir already exists after the configure...
cd src
ln -s $NDK_ROOT/platforms/$ANDROID_PLATFORM/arch-arm/usr/lib/crtbegin_so.o
ln -s $NDK_ROOT/platforms/$ANDROID_PLATFORM/arch-arm/usr/lib/crtend_so.o
cd ..

make
make install
