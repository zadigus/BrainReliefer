import QtQuick 2.5

import "/js/Global.js" as Global
import ".."
import "../Common"

Item {

  signal handle(string name)

  ListView
  {
    id: referencesList
    width: mediator.width
    height: mediator.height

    signal handle(string name)

    orientation: ListView.Vertical

    model: referencesModel
    delegate: ReferenceDelegate {}
  }

  Component.onCompleted:
  {
    windowFooter.activateHome(true)
    windowFooter.activateBackArrow(Global.history.length >= 2)
    windowHeader.text = qsTr("References")
  }
}
