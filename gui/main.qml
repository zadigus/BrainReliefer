import QtQuick 2.5
import QtQuick.Window 2.2

Window
{
    id: mainWindow

    width: 400
    height: 800

    property int footerHeight: 50

//    visibility: "FullScreen"
    visible: true

    Mediator
    {
        id: mediator

        width: mainWindow.width
        height: mainWindow.height - mainWindow.footerHeight
    }

    Footer
    {
        id: windowFooter

        width: parent.width
        height: mainWindow.footerHeight

        anchors.top: mediator.bottom
    }
}
