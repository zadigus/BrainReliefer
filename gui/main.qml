import QtQuick 2.5
import QtQuick.Window 2.2

Window
{
    id: mainWindow

    width: 400
    height: 800

//    visibility: "FullScreen"
    visible: true

    Item
    {
        id: mediator
        anchors.fill: parent

        property var verticalOffset: 20

        property var pages:
        {
            "mainMenu"          : "MainMenu.qml",
                    "newIntrants"       : "NewIntrants.qml",
                    "incubatedIntrants" : "IncubatedIntrants.qml",
                    "references"        : "References.qml",
                    "projects"          : "Projects.qml",
                    "nextActions"       : "NextActions.qml",
                    "agenda"            : "Agenda.qml"
        }

        Loader
        {
            id: mainLoader

            function getWidth()
            {
                return mainWindow.width
            }

            function getOffsetWidth()
            {
                return getWidth() - mediator.verticalOffset
            }

            function getHeight()
            {
                return mainWindow.height
            }
        }

        Component.onCompleted: mainLoader.source = pages["mainMenu"]

        // see https://wiki.qt.io/QML_Application_Structuring_Approaches
        Connections
        {
            target: mainLoader.item
            onHandle:
            {
                mainLoader.source = mediator.pages[name];
            }
        }

    }
}
