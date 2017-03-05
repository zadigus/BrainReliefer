TEMPLATE = app

QT += qml quick xmlpatterns widgets

CONFIG += c++11

DATA_FOLDER   = logic/Data
MODELS_FOLDER = logic/Models
LOGGER_FOLDER = logic/Logger
COMMONDATA_FOLDER = common/Data
CORE_FOLDER   = core


SOURCES += main.cpp \
    $${LOGGER_FOLDER}/Logger.cpp \
    $${DATA_FOLDER}/IntrantList.cpp \
    $${DATA_FOLDER}/IntrantList-pimpl.cpp \
    $${DATA_FOLDER}/IntrantList-pskel.cpp \
    $${DATA_FOLDER}/IntrantList-simpl.cpp \
    $${DATA_FOLDER}/IntrantList-sskel.cpp \
    $${DATA_FOLDER}/Data.cpp \
    $${DATA_FOLDER}/Data-pimpl.cpp \
    $${DATA_FOLDER}/Data-pskel.cpp \
    $${DATA_FOLDER}/Data-simpl.cpp \
    $${DATA_FOLDER}/Data-sskel.cpp \
    $${DATA_FOLDER}/DataValidator.cpp \
    $${MODELS_FOLDER}/IntrantsList.cpp \
    $${MODELS_FOLDER}/ActionsList.cpp \
    $${MODELS_FOLDER}/ModelsHelper.cpp \
    $${DATA_FOLDER}/DataManager.cpp \
    $${DATA_FOLDER}/DataExceptions.cpp \
    $${DATA_FOLDER}/SharedIntrant.cpp \
    $${DATA_FOLDER}/SharedAction.cpp \
    $${COMMONDATA_FOLDER}/Action.cpp \
    EngineConfigurator.cpp \
    AppConfiguration.cpp \
    gui/InvalidData/FileSaveDialog.cpp \
    $${MODELS_FOLDER}/ProjectAction.cpp

HEADERS += $${CORE_FOLDER}/Global.hpp \
    $${LOGGER_FOLDER}/Logger.hpp \
    $${DATA_FOLDER}/IntrantList.hpp \
    $${DATA_FOLDER}/IntrantList-pimpl.hpp \
    $${DATA_FOLDER}/IntrantList-pskel.hpp \
    $${DATA_FOLDER}/IntrantList-simpl.hpp \
    $${DATA_FOLDER}/IntrantList-sskel.hpp \
    $${DATA_FOLDER}/Data.hpp \
    $${DATA_FOLDER}/Data-pimpl.hpp \
    $${DATA_FOLDER}/Data-pskel.hpp \
    $${DATA_FOLDER}/Data-simpl.hpp \
    $${DATA_FOLDER}/Data-sskel.hpp \
    $${DATA_FOLDER}/DataValidator.hpp \
    $${MODELS_FOLDER}/IntrantsList.hpp \
    $${MODELS_FOLDER}/ActionsList.hpp \
    $${MODELS_FOLDER}/ModelsHelper.hpp \
    $${DATA_FOLDER}/DataManagerHelper.hpp \
    $${DATA_FOLDER}/DataManager.hpp \
    $${DATA_FOLDER}/DataExceptions.hpp \
    $${DATA_FOLDER}/DataConstants.hpp \
    $${DATA_FOLDER}/SharedIntrant.hpp \
    $${DATA_FOLDER}/SharedAction.hpp \
    $${COMMONDATA_FOLDER}/Action.hpp \
    logic/Singleton.hpp \
    EngineConfigurator.hpp \
    AppConfiguration.hpp \
    gui/InvalidData/FileSaveDialog.hpp \
    $${MODELS_FOLDER}/ProjectAction.hpp

RESOURCES += gui/qml/qml.qrc \
      $${DATA_FOLDER}/data.qrc

INCLUDEPATH += gui \
    logic \
    common

win32-msvc2013 {

  XSD_INCLUDE_DIR = "G:/CodeSynthesis XSD 4.0/include"

  INCLUDEPATH += XSD_INCLUDE_DIR

  ## Windows common build here
  !contains(QMAKE_TARGET.arch, x86_64){
    ## Windows x86 (32bit) specific build here
    message("adding msvc2013 32bits Xerces lib")
    LIBS        += $${XSD_BASE_DIR}\lib\vc-12.0\xerces-c_3.lib
  } else {
    ## Windows x64 (64bit) specific build here
    message("adding msvc2013 64bits Xerces lib")
    LIBS        += $${XSD_BASE_DIR}\lib64\vc-12.0\xerces-c_3.lib
  }
}

linux:!android {
  LIB_DIR = "/home/mihl/Libraries"

#  XSD_INCLUDE_DIR = $${LIB_DIR}/xsd/libxsd
  XSDE_DIR = $${LIB_DIR}/xsde/linux/libxsde/
  XERCES_DIR = $${LIB_DIR}/xerces-c/linux-x86_64
  ICU_DIR = $${LIB_DIR}/icu/linux-x86_64

  INCLUDEPATH += $${XSDE_DIR} \
    $${XERCES_DIR}/include \
    $${ICU_DIR}/include

  LIBS += -L$${XERCES_DIR}/lib -lxerces-c \
    -L$${ICU_DIR}/lib -licudata -licui18n -licuio -licuuc \
    -L$${XSDE_DIR}/xsde -lxsde
}

android {
  LIB_DIR = "/home/mihl/Libraries"

#  XSD_INCLUDE_DIR = $${LIB_DIR}/xsd/libxsd

  equals(ANDROID_TARGET_ARCH, arm64-v8a) {
    ARCH_DIR = aarch64-linux-android
  }

  equals(ANDROID_TARGET_ARCH, x86) {
    ARCH_DIR = x86
  }

  XSDE_DIR = $${LIB_DIR}/xsde/android-23/$${ARCH_DIR}/libxsde
  XERCES_DIR = $${LIB_DIR}/xerces-c/android-23/$${ARCH_DIR}
  ICU_DIR = $${LIB_DIR}/icu/android-23/$${ARCH_DIR}

  #QMAKE_CXXFLAGS += -D_GLIBCXX_USE_C99 # for x86_64

  INCLUDEPATH += $${XSDE_DIR} \
    $${XERCES_DIR}/include \
    $${ICU_DIR}/include

  LIBS += -L$${XERCES_DIR}/lib -lxerces-c \
    -L$${ICU_DIR}/lib -licuuc -licudata -licui18n -licuio \
    -L$${XSDE_DIR}/xsde -lxsde \
    -L$$(NDK_ROOT)/sources/cxx-stl/stlport/libs/$${ANDROID_TARGET_ARCH} -lstlport_static

  DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

  ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat
