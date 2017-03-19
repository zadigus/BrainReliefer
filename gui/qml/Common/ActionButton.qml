import QtQuick 2.5

import "/js/Global.js" as Global

Rectangle {
  property string buttonText

  radius: settings.value("ActionButton", "radius")
  height: settings.value("ActionButton", "height")

  border.color: "blue"
  Text {
    text: buttonText
    anchors.centerIn: parent
    font { pointSize: settings.value("ActionButton", "font.pointSize") }
  }
  MouseArea {
    anchors.fill: parent
    onClicked: parent.onClicked()
  }
}
