TEMPLATE = app

QT += qml quick xmlpatterns

CONFIG += c++11

XSD_BASE_DIR = "G:/CodeSynthesis XSD 4.0/"

DATA_FOLDER   = logic\Data
MODELS_FOLDER = logic\Models

SOURCES += main.cpp \
    $${DATA_FOLDER}/Data.cpp \
    $${DATA_FOLDER}/IntrantList.cpp \
    $${DATA_FOLDER}/DataValidator.cpp \
    $${MODELS_FOLDER}/NewIntrants.cpp \
    $${MODELS_FOLDER}/ModelsHelper.cpp \
    $${DATA_FOLDER}/DataManager.cpp \
    logic/Data/DataExceptions.cpp

HEADERS += $${DATA_FOLDER}/Data.hpp \
    $${DATA_FOLDER}/IntrantList.hpp \
    $${DATA_FOLDER}/DataValidator.hpp \
    $${MODELS_FOLDER}/NewIntrants.hpp \
    $${MODELS_FOLDER}/ModelsHelper.hpp \
    logic/Singleton.hpp \
    $${DATA_FOLDER}/DataManagerHelper.hpp \
    $${DATA_FOLDER}/DataManager.hpp \
    logic/Data/DataExceptions.hpp

RESOURCES += gui/qml.qrc \
			logic/data/data.qrc

INCLUDEPATH += $${XSD_BASE_DIR}/include \
		gui \
		logic

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

