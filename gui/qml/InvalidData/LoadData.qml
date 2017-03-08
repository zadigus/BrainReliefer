import QtQuick 2.5
import QtQuick.Dialogs 1.0

import "/js/Global.js" as Global
import ".."

FileDialog {
    id: fileDialog
    title: qsTr("Please choose folder containing your app data")
    selectFolder: true
    selectMultiple: false
    folder: shortcuts.home

    signal handle(string name)

    onAccepted: {
        console.log("Chosen folder: " + fileDialog.fileUrl)
        appConfiguration.dataDir = fileDialog.fileUrl
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
