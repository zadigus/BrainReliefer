import QtQuick 2.0
import QtQuick.Dialogs 1.0

import "/js/Global.js" as Global
import ".."

FileDialog {
    id: fileDialog
    title: qsTr("Please choose a file")
    folder: shortcuts.home

    signal handle(string name)

    onAccepted: {
        console.log("Chosen file: " + fileDialog.fileUrl)
        appConfiguration.dataFileUrl = fileDialog.fileUrl
        handle("mainMenu")
    }
    onRejected: {
        console.log("Canceled")
        windowFooter.goBack()
    }
    Component.onCompleted:
    {
        windowHeader.text = qsTr("Load Data")
        visible = true
    }
}
