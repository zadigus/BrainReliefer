import QtQuick 2.7

import "/js/Global.js" as Global

Rectangle {

    property alias text: headerTxt.text

    Text
    {
        id: headerTxt
        font { family: "Arial"; pixelSize: parent.width * 0.1 }
        anchors.centerIn: parent
    }

}
