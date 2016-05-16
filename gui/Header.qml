import QtQuick 2.5

import "/js/Global.js" as Global

Rectangle {

    property alias text: headerTxt.text

    Text
    {
        id: headerTxt
        font { family: "Arial"; pixelSize: Global.optimalFontSize }
        anchors.centerIn: parent
    }

    Component.onCompleted: headerTxt.font.pixelSize = Global.optimalFontSize

}
