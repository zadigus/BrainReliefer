import QtQuick 2.5
import QtQuick.Window 2.2

Window
{
    id: mainWindow

    width: 400
    height: 800

    property real headerParts:    2
    property real footerParts:    1
    property real mediatorParts: 15

//    property int footerHeight: 50

//    visibility: "FullScreen"
    visible: true

    Header
    {
        id: windowHeader

        width: mainWindow.width
        height: mainWindow.height * headerParts / partsSum()
    }

    Mediator
    {
        id: mediator

        width: mainWindow.width
        height: mainWindow.height * mediatorParts / partsSum() // mainWindow.height - mainWindow.footerHeight //

        anchors.top: windowHeader.bottom
    }

    Footer
    {
        id: windowFooter

        width: mainWindow.width
        height: mainWindow.height * footerParts / partsSum() // mainWindow.footerHeight

        anchors.top: mediator.bottom
    }

    function partsSum()
    {
        return headerParts + footerParts + mediatorParts
    }
}
