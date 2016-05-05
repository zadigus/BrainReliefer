import QtQuick 2.5

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
            menuItem.parent.switchTo("newIntrants");
        }
    }
}
