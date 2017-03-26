import QtQuick 2.5

import "../MainMenu"

Rectangle
{
    id: menuItem

    color: "black"

    property alias menuText: textItem.text
    property string menuLink

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
        onClicked:
        {
            menuItem.parent.handle(menuLink)
        }
    }
}
