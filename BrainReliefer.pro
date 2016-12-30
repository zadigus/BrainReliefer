TEMPLATE = app

QT += qml quick xmlpatterns widgets

CONFIG += c++11

DATA_FOLDER   = logic/Data
MODELS_FOLDER = logic/Models
LOGGER_FOLDER = logic/Logger
COMMONDATA_FOLDER = common/Data
CORE_FOLDER   = core


SOURCES += main.cpp \
    $${DATA_FOLDER}/Application.cpp \
    $${LOGGER_FOLDER}/Logger.cpp \
    $${DATA_FOLDER}/Data.cpp \
    $${DATA_FOLDER}/IntrantList.cpp \
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
    $${DATA_FOLDER}/Application.hpp \
    $${LOGGER_FOLDER}/Logger.hpp \
    $${LOGGER_FOLDER}/Log.hpp \
    $${LOGGER_FOLDER}/LoggerExceptions.hpp \
    $${DATA_FOLDER}/Data.hpp \
    $${DATA_FOLDER}/IntrantList.hpp \
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

  XSD_BASE_DIR = "G:/CodeSynthesis XSD 4.0/"

  INCLUDEPATH += $${XSD_BASE_DIR}/include

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

linux {
  LIB_DIR = "/home/mihl/Libraries"

  XSD_INCLUDE_DIR = $${LIB_DIR}/xsd/libxsd
  XERCES_DIR = $${LIB_DIR}/xerces-c

  INCLUDEPATH += $${XSD_INCLUDE_DIR} \
    $${XERCES_DIR}/include

  LIBS += $${XERCES_DIR}/lib/libxerces-c.a
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

