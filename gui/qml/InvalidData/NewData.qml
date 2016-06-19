import QtQuick 2.0

import "/js/Global.js" as Global
import ".."

import InvalidData 1.0

FileSaveDialog
{
    id: fileSaveDialog
    title: qsTr("New data file")
    nameFilters: qsTr("XML Data (*.xml)")

    signal handle(string name)

    Component.onCompleted:
    {
        windowFooter.activateBackArrow(Global.history.length >= 2)
        windowHeader.text = qsTr("New Data")
        if(fileSaveDialog.open())
        {
            console.log("File save dialog created new filename")

            fileSaveDialog.createNewDataFile()
            console.log("File created: " + fileSaveDialog.filenameUrl)

            appConfiguration.dataFileUrl = fileSaveDialog.filenameUrl
            windowFooter.goHome() // for some (obscure) reason, I can't use the handle("mainMenu") signal here
            // --> does nothing...
        }
        else
        {
            console.log("Canceled")
            windowFooter.goBack()
        }
    }
}
