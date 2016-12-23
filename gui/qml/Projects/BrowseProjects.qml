import QtQuick 2.5

import "/js/Global.js" as Global
import ".."
import "../Common"

Item {

  signal handle(string name)

  ListView
  {
    id: projectsList
    width: mediator.width
    height: mediator.height

    signal handle(string name)

    orientation: ListView.Vertical

    model: projectsModel
    delegate: ProjectDelegate {}
  }

  Component.onCompleted:
  {
    windowFooter.activateHome(true)
    windowFooter.activateBackArrow(Global.history.length >= 2)
    windowHeader.text = qsTr("Projects")
  }
}
