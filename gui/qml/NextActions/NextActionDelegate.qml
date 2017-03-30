import QtQuick 2.7

import "/js/Global.js" as Global
import ".."
import "../Common"

Component
{
  Item
  {
    id: action

    property int initialActionHeight: mainWindow.scaledValue(settings.value("Intrant", "height"))

    width: parent.width
    height: initialActionHeight

    // A simple rounded rectangle for the background
    Rectangle {
      id: background
      x: 2; y: 2; width: parent.width - 2*x; height: parent.height - 2*y
      color: "ivory"
      border.color: "orange"
      radius: 5
    }

    Column {
      id: topLayout
      x: 0; y: 10;
      height: parent.height;
      width: parent.width
      spacing: 10

      Text {
        text: title
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
        x: 10
        width: parent.width - 2 * x
        font.pixelSize: 24
      }

    }
  }
}
