import QtQuick 2.7

import "/js/Global.js" as Global

Rectangle {
  radius: settings.value("CloseButton", "radius")
  height: mainWindow.scaledValue(settings.value("CloseButton", "height"))
  width: mainWindow.scaledValue(settings.value("CloseButton", "width"))

  signal clicked

  border.color: "black"
  Text {
    text: qsTr("Close")
    anchors.centerIn: parent
    font.pixelSize: mainWindow.scaledValue(settings.value("CloseButton", "pixelSize"))
  }
  MouseArea {
    anchors.fill: parent
    onClicked: parent.clicked()
  }
}
