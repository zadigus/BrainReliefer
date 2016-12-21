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

        "incubation.browse"     : "/IncubatedIntrants/BrowseIncubation.qml",

        "references.browse"     : "/References/BrowseReferences.qml",

        "projects.browse"       : "/Projects/BrowseProjects.qml",
        "nextActions.browse"    : "/NextActions/BrowseNextActions.qml",

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
        }
    }

    function setLoaderSource(source)
    {
        Global.history.push(source)
        mainLoader.source = pages[source]
    }

}
