import QtQuick 2.7

import "/js/Global.js" as Global

Rectangle {
  property string buttonText

  radius: settings.value("ActionButton", "radius")
  height: mainWindow.scaledValue(settings.value("ActionButton", "height"))

  signal clicked

  border.color: "blue"
  Text {
    text: buttonText
    anchors.centerIn: parent
    font.pixelSize: mainWindow.scaledValue(settings.value("ActionButton", "pixelSize"))
  }
  MouseArea {
    anchors.fill: parent
    onClicked: parent.clicked()
  }
}
