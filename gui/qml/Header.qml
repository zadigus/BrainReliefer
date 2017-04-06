import QtQuick 2.7

import "/js/Global.js" as Global

Rectangle {

    property alias text: headerTxt.text

    Text
    {
        id: headerTxt
        font { family: settings.value("Header", "fontFamily"); pixelSize: parent.width * mainWindow.scaledValue(settings.value("Header", "fontRatio")) }
        anchors.centerIn: parent
    }

}
