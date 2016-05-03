import QtQuick 2.5

Rectangle
{
    id: menuItem

    color: "black"
    border.color: "white"
    border.width: 1

    property alias menuText: textItem.text
    property alias menuX: textItem.x
    property alias menuY: textItem.y
    property alias menuFont: textItem.font

    Text
    {
        id: textItem
        color: "white"
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            menuItem.parent.switchTo("newIntrants");
        }
    }
}
