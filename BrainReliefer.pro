TEMPLATE = app

QT += qml quick xmlpatterns

CONFIG += c++11

XSD_BASE_DIR = "G:/CodeSynthesis XSD 4.0/"

DATA_FOLDER = Data

SOURCES += main.cpp \
    $${DATA_FOLDER}/Data.cpp \
    $${DATA_FOLDER}/IntrantList.cpp \
    $${DATA_FOLDER}/DataValidator.cpp

HEADERS += $${DATA_FOLDER}/Data.hpp \
    $${DATA_FOLDER}/IntrantList.hpp \
    $${DATA_FOLDER}/DataValidator.hpp

RESOURCES += qml.qrc

INCLUDEPATH += $${XSD_BASE_DIR}/include

win32-msvc2013 {
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

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

