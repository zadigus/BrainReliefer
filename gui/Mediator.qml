import QtQuick 2.5

import "/js/Global.js" as Global

Item
{
    property var pages:
    {
        "mainMenu"              : "/MainMenu/MainMenu.qml",

        "invalidData"           : "/InvalidData/MainMenu.qml",
        "invalidData.new"       : "/InvalidData/NewData.qml",
        "invalidData.load"      : "/InvalidData/LoadData.qml",

        "newIntrants"           : "/NewIntrants/NewIntrants.qml",
        "newIntrants.add"       : "/NewIntrants/AddIntrant.qml",
        "newIntrants.manage"    : "/NewIntrants/ManageNewIntrants.qml",

        "incubatedIntrants"     : "/IncubatedIntrants/IncubatedIntrants.qml",

        "references"            : "/References/References.qml",

        "projects"              : "/Projects/Projects.qml",
        "nextActions"           : "/NextActions/NextActions.qml",

        "agenda"                : "/Agenda/Agenda.qml"
    }

    Loader
    {
        id: mainLoader
    }

    Component.onCompleted:
    {
        setLoaderSource("mainMenu")
    }

    Connections
    {
        target: windowFooter
        onGoHome:
        {
            setLoaderSource("mainMenu")
        }
        onGoBack:
        {
            Global.history.pop()
            var prev = Global.history.pop()

            if(prev)
            {
                setLoaderSource(prev)
            }
        }
    }

    Connections
    {
        target: dataManager
        onInvalidDataFile:
        {
            console.log("invalid data file!")
            setLoaderSource("invalidData")
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

    function setLoaderSource(source)
    {
        Global.history.push(source)
        mainLoader.source = pages[source]
    }

}
