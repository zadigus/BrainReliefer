TEMPLATE = app

QT += qml quick
CONFIG += c++11

XSD_BASE_DIR = "G:/CodeSynthesis XSD 4.0/"

DATA_FOLDER = Data

SOURCES += main.cpp \
    $${DATA_FOLDER}/Data.cpp

HEADERS += $${DATA_FOLDER}/Data.hpp

RESOURCES += qml.qrc

INCLUDEPATH += $${XSD_BASE_DIR}/include

LIBS        += $${XSD_BASE_DIR}\lib\vc-12.0\xerces-c_3.lib

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
