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

//    visibility: "FullScreen"
    visible: true
    modality: Qt.ApplicationModal

    function ratio()
    {
      var myHeight  = Math.max(width, height)
      var myWidth   = Math.min(width, height)
      var refHeight = settings.value("Scaling", "refHeight")
      var refWidth  = settings.value("Scaling", "refWidth")
      return Math.min(myHeight/refHeight, myWidth/refWidth)
    }

    function scaledValue(value)
    {
      return ratio() * value
    }

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
        height: mainWindow.height * mediatorParts / partsSum()

        anchors.top: windowHeader.bottom
    }

    Footer
    {
        id: windowFooter

        width: mainWindow.width
        height: mainWindow.height * footerParts / partsSum()

        anchors.top: mediator.bottom
    }

    function partsSum()
    {
        return headerParts + footerParts + mediatorParts
    }
}
