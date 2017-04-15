import QtQuick 2.7

import "../MainMenu"

Rectangle
{
    id: menuItem

    color: "black"

    property alias menuText: textItem.text

    signal clicked

    Text
    {
        id: textItem
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: menuItem.width * settings.value("Menu", "fontRatio")
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
