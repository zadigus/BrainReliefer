import QtQuick 2.7

import "/js/Global.js" as Global
import ".."
import "../Common" as Common

Item {
  id: mainItem

  signal handle(string name)

  width: mediator.width
  height: mediator.height

  Common.DefineNextActionLayout {
    id: defineNextActionLayout
    anchors.fill: parent
  }

  /*
   * State machine
   */
  states: [ State {
      name: "DefaultState"
      PropertyChanges { target: defineNextActionLayout; visible: true }
    }

  ]

  Component.onCompleted:
  {
    windowFooter.activateHome(true)
    windowFooter.activateBackArrow(Global.history.length >= 2)
    windowHeader.text = qsTr("Add action")
    mainItem.state = "DefaultState"
  }
}
