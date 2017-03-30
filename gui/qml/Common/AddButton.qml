import QtQuick 2.7

import "/js/Global.js" as Global

Rectangle {
  radius: width * 0.5

  height: width

  signal clicked

  color: "green"

  Text {
    text: "+"
    font.pixelSize: parent.width
    color: "white"
    anchors.centerIn: parent
  }

  MouseArea {
    anchors.fill: parent
    onClicked: parent.clicked()
  }
}
