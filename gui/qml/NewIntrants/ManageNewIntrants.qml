import QtQuick 2.5
import QtQuick.Controls 2.0

import MyDataManagement 1.0

import "/js/Global.js" as Global
import "../Common" as Common

Item {

  signal handle(string name)

  ListView
  {
    id: newIntrantsList

    signal intrantOpened
    signal intrantClosed

    width: mediator.width
    height: mediator.height

    orientation: ListView.Vertical

    model: newIntrantsModel
    delegate: NewIntrantDelegate { }
  }

  Connections {
    target: newIntrantsList
    onIntrantOpened: addNewIntrantBtn.visible = false
    onIntrantClosed: addNewIntrantBtn.visible = true
  }

  Common.AddButton {
    id: addNewIntrantBtn
    width: mainWindow.scaledValue(settings.value("NewIntrants", "addBtnSize"))
    anchors { bottom: newIntrantsList.bottom; right: newIntrantsList.right }
    onClicked: handle("newIntrants.add")
  }

  Component.onCompleted:
  {
    windowFooter.activateHome(true)
    windowFooter.activateBackArrow(Global.history.length >= 2)
    windowHeader.text = qsTr("New Intrants List")
  }

}
