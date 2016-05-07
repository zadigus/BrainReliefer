import QtQuick 2.5

Item
{
    anchors.fill: parent

    // TODO: the mediator should have functionality to
    // * go back
    // * go forward
    // * go home

    property var verticalOffset: 20

    property var pages:
    {
        "mainMenu"          : "MainMenu/MainMenu.qml",
        "newIntrants"       : "NewIntrants/NewIntrants.qml",
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

    Connections
    {
        target: mainLoader.item
        onHandle:
        {
            mainLoader.source = mediator.pages[name];
            target.width  = mainWindow.width
            target.height = mainWindow.height
        }
    }

}
