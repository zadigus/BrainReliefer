import QtQuick 2.0
import QtQuick.Dialogs 1.0

import "/js/Global.js" as Global
//import "../MainMenu"
import ".."

Rectangle
{
    id: loadDataMenu

    signal handle(string name)
//    signal loadData(string dataFileName)

    width: mediator.width
    height: mediator.height

    border {color: "red"; width: 2}

    Component.onCompleted:
    {
        windowFooter.activateBackArrow(Global.history.length >= 2)

        windowHeader.text = qsTr("Load Data")
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
//            loadData(fileDialog.fileUrls)
            dataManager.load(fileDialog.fileUrls)
            handle("mainMenu")
        }
        onRejected: {
            console.log("Canceled")
        }
        Component.onCompleted: visible = true
    }
}
