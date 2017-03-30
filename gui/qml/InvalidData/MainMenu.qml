import QtQuick 2.7
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
    menuText: qsTr("New Data")
    menuLink: "invalidData.new"
  }

  MenuItem {
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
