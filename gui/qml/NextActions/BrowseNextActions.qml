import QtQuick 2.5

import "/js/Global.js" as Global
import ".."
import "../Common"

Item {

  signal handle(string name)

  Component
  {
    id: myDelegate
    Item
    {
      id: action

      property int initialActionHeight: 40

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

  ListView
  {
    id: list
    width: mediator.width
    height: mediator.height

    orientation: ListView.Vertical

    model: actionsModel
    delegate: myDelegate
  }

  Component.onCompleted:
  {
    windowFooter.activateHome(true)
    windowFooter.activateBackArrow(Global.history.length >= 2)
    windowHeader.text = qsTr("Next actions")

//      actionsModel.setFilterFixedString("Test project")
  }

}
