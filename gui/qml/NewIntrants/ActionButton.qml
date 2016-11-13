import QtQuick 2.5

import "/js/Global.js" as Global

Rectangle {
  property string buttonText

  border.color: "blue"
  Text {
    text: buttonText
    anchors.centerIn: parent
  }
  MouseArea {
    anchors.fill: parent
    onClicked: parent.onClicked()
  }
}
