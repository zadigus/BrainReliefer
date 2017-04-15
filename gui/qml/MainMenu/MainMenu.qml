import QtQuick 2.7
import QtQuick.Layouts 1.1

import "/js/Global.js" as Global
import "../Common" as Common

Flickable {
  id: mainMenu
  width: mediator.width; height: mediator.height;
  contentWidth: width
  contentHeight: height
  clip: true
  flickableDirection: Flickable.VerticalFlick

  signal handle(string name)

  ColumnLayout {
    spacing: settings.value("Menu", "spacing")

    Common.MenuItem {
      Layout.alignment: Qt.AlignCenter
      Layout.preferredWidth: mediator.width
      Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      menuText: qsTr("New Intrants")
      onClicked: handle("newIntrants.manage")
    }

    Common.MenuItem {
      Layout.alignment: Qt.AlignCenter
      Layout.preferredWidth: mediator.width
      Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      menuText: qsTr("Incubated Intrants")
      onClicked: handle("incubation.browse")
    }

    Common.MenuItem {
      Layout.alignment: Qt.AlignCenter
      Layout.preferredWidth: mediator.width
      Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      menuText: qsTr("References")
      onClicked: handle("references.browse")
    }

    Common.MenuItem {
      Layout.alignment: Qt.AlignCenter
      Layout.preferredWidth: mediator.width
      Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      menuText: qsTr("Projects")
      onClicked: handle("projects.browse")
    }

    Common.MenuItem {
      Layout.alignment: Qt.AlignCenter
      Layout.preferredWidth: mediator.width
      Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      menuText: qsTr("Next Actions")
      onClicked: handle("nextActions.browse")
    }

    Common.MenuItem {
      Layout.alignment: Qt.AlignCenter
      Layout.preferredWidth: mediator.width
      Layout.preferredHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      Layout.maximumHeight: mainWindow.scaledValue(settings.value("Menu", "height"))
      menuText: qsTr("Agenda")
      onClicked: handle("agenda")
    }

  }

  Component.onCompleted:
  {
    windowFooter.activateBackArrow(Global.history.length >= 2)
    windowFooter.activateHome(false)
    windowHeader.text = qsTr("Home")

    dataManager.load(appConfiguration.dataDir)
  }
}
