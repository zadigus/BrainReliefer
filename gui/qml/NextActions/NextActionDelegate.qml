import QtQuick 2.7

import "/js/Global.js" as Global
import ".."
import "../Common" as Common

Component
{
  Item
  {
    id: action

    property int initialActionHeight: mainWindow.scaledValue(settings.value("Intrant", "height"))

    width: parent.width
    height: initialActionHeight

    Common.BackgroundRectangle {
      id: background
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
