import QtQuick 2.5

import "/js/Global.js" as Global

Item
{
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
    }

    Component.onCompleted:
    {
        Global.history.push("mainMenu")
        mainLoader.source = pages["mainMenu"]
    }

    Connections
    {
        target: windowFooter
        onGoHome:
        {
            Global.history.push("mainMenu")
            mainLoader.source = pages["mainMenu"]
        }
        onGoBack:
        {
            Global.history.pop()
            var prev = Global.history.pop()

            if(prev)
            {
                Global.history.push(prev)
                mainLoader.source = pages[prev]
            }
        }
    }

    Connections
    {
        target: mainLoader.item
        onHandle:
        {
            Global.history.push(name)
            mainLoader.source = mediator.pages[name];
            target.width  = mainWindow.width
            target.height = mainWindow.height
        }
    }

}
