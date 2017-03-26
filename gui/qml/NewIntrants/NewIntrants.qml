import QtQuick 2.5
import QtQuick.Layouts 1.1

import "/js/Global.js" as Global
import "../BaseMenu"

ColumnLayout {
  spacing: settings.value("Menu", "spacing")

  signal handle(string name)

  MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("Add")
    menuLink: "newIntrants.add"
  }

  MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("Manage")
    menuLink: "newIntrants.manage"
  }

  Component.onCompleted:
  {
    windowFooter.activateBackArrow(Global.history.length >= 2)
    windowHeader.text = qsTr("New Intrants")
  }
}
