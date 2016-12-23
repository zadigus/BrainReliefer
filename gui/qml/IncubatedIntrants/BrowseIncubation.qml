import QtQuick 2.5

import "/js/Global.js" as Global
import ".."
import "../Common"

Item {

  signal handle(string name)

  ListView
  {
    id: incubationlist
    width: mediator.width
    height: mediator.height

    signal handle(string name)

    orientation: ListView.Vertical

    model: incubatedModel
    delegate: IncubationDelegate {}
  }

  Component.onCompleted:
  {
    windowFooter.activateHome(true)
    windowFooter.activateBackArrow(Global.history.length >= 2)
    windowHeader.text = qsTr("Incubated intrants")
  }

}
