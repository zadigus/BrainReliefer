import QtQuick 2.7
import QtQuick.Layouts 1.1

import "/js/Global.js" as Global
import "."
import "../Common" as Common

Component
{
  Item
  {
    id: action

    width: parent.width
    height: mainWindow.scaledValue(settings.value("Intrant", "height"))

    Common.BackgroundRectangle {
      id: background
    }

    MouseArea {
      id: dragArea
      anchors.fill: parent
      drag.target: action
      drag.axis: Drag.XAxis
      drag.minimumX: -action.width
      drag.maximumX: 0
      drag.onActiveChanged: {
        console.log("drag active changed: " + action.x)
        if(action.x <= drag.minimumX / 2)
        {
          console.log("remove item <" + index + ">")
          nextActionsList.model.sourceModel.remove(index)
        }
        else
        {
          action.x = 0
        }
      }
    }

    ColumnLayout {
      anchors.fill: parent

      ColumnLayout {
        spacing: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))

        Layout.alignment: Qt.AlignTop
        Layout.topMargin: spacing
        Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
        Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))

        Text {
          text: title
          elide: Text.ElideRight
          wrapMode: Text.NoWrap
          Layout.fillWidth: true
          font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "title.pixelSize"))
        }
      }
    }
  }
}
