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
    menuText: qsTr("New Intrants")
    menuLink: "newIntrants.manage"
  }

  Common.MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("Incubated Intrants")
    menuLink: "incubation.browse"
  }

  Common.MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("References")
    menuLink: "references.browse"
  }

  Common.MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("Projects")
    menuLink: "projects.browse"
  }

  Common.MenuItem {
    Layout.alignment: Qt.AlignCenter
    Layout.preferredWidth: mediator.width
    Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
    menuText: qsTr("Next Actions")
    menuLink: "nextActions.browse"
  }

  Common.MenuItem {
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
