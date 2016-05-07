import QtQuick 2.5
import QtQuick.Window 2.2

Window
{
    id: mainWindow

    width: 400
    height: 800

//    visibility: "FullScreen"
    visible: true

    Mediator
    {
        id: mediator
    }
}
