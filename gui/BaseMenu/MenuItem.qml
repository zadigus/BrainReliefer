import QtQuick 2.5

import "../MainMenu"

Rectangle
{
    id: menuItem

    color: "black"
    border.color: "white"
    border.width: 1

    property Item previous: previousItem(menuItem)
    anchors.top: (previous != null)? previous.bottom: undefined

    property alias menuText: textItem.text
    property alias menuFont: textItem.font
    property string menuLink

    Text
    {
        id: textItem
        anchors.centerIn: parent
        color: "white"
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            baseMenu.handle(menuLink)
        }
    }
}
