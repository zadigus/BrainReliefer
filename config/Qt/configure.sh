# android arm; put ndk-platform = android-19 because we need asm/procinfo.h
ANDROID_PLATFORM="android-19"

# get the code
git clone git://code.qt.io/qt/qt5.git qt5
cd qt5
perl init-repository

# desktop linux static
./configure -prefix="/home/mihl/Libraries/Qt/5.7/static/debug/gcc_64" -largefile -developer-build -optimized-tools -opensource -confirm-license -static -qml-debug -android-sdk /home/mihl/Libraries/android-sdk -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -qt-xcb -no-compile-examples -nomake examples -nomake tests -opengl

#TODO: make build folders...

./configure -prefix "/home/mihl/Libraries/Qt/5.8/static/debug/android_armv7" -static -debug -developer-build -nomake tests -nomake examples -skip qttranslations -skip qtwebkit -skip qtserialport -skip qtwebkit-examples -no-warnings-are-errors -opensource -confirm-license -xplatform android-g++ -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -android-sdk /home/mihl/Libraries/android-sdk -android-ndk-host linux-x86_64 -android-toolchain-version 4.9 -android-ndk-platform $ANDROID_PLATFORM -android-arch armeabi-v7a

# android arm64
./configure -prefix "/home/mihl/Libraries/Qt/5.8/static/debug/android_arm64-v8a" -static -debug -developer-build -nomake tests -nomake examples -skip qttranslations -skip qtwebkit -skip qtserialport -skip qtwebkit-examples -no-warnings-are-errors -opensource -confirm-license -xplatform android-g++ -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -android-sdk /home/mihl/Libraries/android-sdk -android-ndk-host linux-x86_64 -android-toolchain-version 4.9 -android-ndk-platform $ANDROID_PLATFORM -android-arch arm64-v8a

# android x86_64
./configure -prefix "/home/mihl/Libraries/Qt/5.8/static/debug/android_x86_64" -static -debug -developer-build -nomake tests -nomake examples -skip qttranslations -skip qtwebkit -skip qtserialport -skip qtwebkit-examples -no-warnings-are-errors -opensource -confirm-license -xplatform android-g++ -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -android-sdk /home/mihl/Libraries/android-sdk -android-ndk-host linux-x86_64 -android-toolchain-version 4.9 -android-ndk-platform $ANDROID_PLATFORM -android-arch x86_64
