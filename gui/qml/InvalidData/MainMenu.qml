import QtQuick 2.7
import QtQuick.Layouts 1.1

import "/js/Global.js" as Global
import "../Common" as Common

ColumnLayout {
  spacing: settings.value("Menu", "spacing")

  signal handle(string name)

  Common.MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("New Data")
    menuLink: "invalidData.new"
  }

  Common.MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("Load Data")
    menuLink: "invalidData.load"
  }

  Component.onCompleted:
  {
    windowHeader.text = qsTr("Wrong data")
  }
}
