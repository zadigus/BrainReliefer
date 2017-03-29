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
    menuText: qsTr("New Intrants")
    menuLink: "newIntrants.manage"
  }

  MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("Incubated Intrants")
    menuLink: "incubation.browse"
  }

  MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("References")
    menuLink: "references.browse"
  }

  MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("Projects")
    menuLink: "projects.browse"
  }

  MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("Next Actions")
    menuLink: "nextActions.browse"
  }

  MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("Agenda")
    menuLink: "agenda"
  }

  Component.onCompleted:
  {
      windowFooter.activateBackArrow(Global.history.length >= 2)
      windowFooter.activateHome(false)
      windowHeader.text = qsTr("Home")

      dataManager.load(appConfiguration.dataDir)
  }
}
