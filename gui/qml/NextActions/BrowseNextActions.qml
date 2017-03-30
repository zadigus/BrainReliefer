import QtQuick 2.7

import "/js/Global.js" as Global
import ".."
import "../Common"

Item {

  signal handle(string name)

  ListView
  {
    id: nextActionslist
    width: mediator.width
    height: mediator.height

    orientation: ListView.Vertical

    model: actionsModel
    delegate: NextActionDelegate {}
  }

  Component.onCompleted:
  {
    windowFooter.activateHome(true)
    windowFooter.activateBackArrow(Global.history.length >= 2)
    windowHeader.text = qsTr("Next actions")

    actionsModel.setFilterWildcard("*")
  }

}
