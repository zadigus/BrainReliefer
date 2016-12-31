# desktop linux static
./configure --prefix="/home/mihl/Libraries/Qt/5.7/gcc_64-debug-static" -largefile -developer-build -optimized-tools -opensource -confirm-license -static -qml-debug -android-sdk /home/mihl/Libraries/android-sdk -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -qt-xcb -no-compile-examples -nomake examples -nomake tests -android-arch armeabi-v7a -opengl -fontconfig

# This may work:
./configure --prefix="/home/mihl/Libraries/Qt/5.7/android_x86_64-debug-static" -static -debug -xplatform android-g++ -android-arch x86_64 -android-sdk /home/mihl/Libraries/android-sdk -android-ndk /home/mihl/Libraries/android-sdk/ndk-bundle -android-ndk-platform android-24 -skip qttranslations -skip qtserialport -skip qtvirtualkeyboard -qml-debug -largefile -developer-build -optimized-tools -opensource -confirm-license -opengl -pkg-config -no-compile-examples -make libs -no-dbus
