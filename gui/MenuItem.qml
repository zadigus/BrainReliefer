import QtQuick 2.5

//import "MainMenu"

Rectangle
{
    id: menuItem

    property var myMenu

    color: "black"
    border.color: "white"
    border.width: 1

    property Item previous: previousItem(menuItem)
    anchors.top: (previous != null)? previous.bottom: undefined

    property alias menuText: textItem.text
    property alias menuFont: textItem.font

//    Component.onCompleted:
//    {
//        console.log("completed menuItem")
//    }

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
            myMenu.handle("newIntrants")
//            menuItem.parent.switchTo("newIntrants")
        }
    }
}
