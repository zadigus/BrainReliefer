import QtQuick 2.7

import "/js/Global.js" as Global

Rectangle {
  radius: settings.value("CloseButton", "radius")
  height: mainWindow.scaledValue(settings.value("CloseButton", "height"))
  width: mainWindow.scaledValue(settings.value("CloseButton", "width"))

  y: 10
  anchors.rightMargin: 10

  signal clicked

  border.color: "black"
  Text {
    text: qsTr("Close")
    anchors.centerIn: parent
    font.pixelSize: parent.width * settings.value("CloseButton", "fontRatio")
  }
  MouseArea {
    anchors.fill: parent
    onClicked: parent.clicked()
  }
}
