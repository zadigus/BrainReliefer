import QtQuick 2.0

import "/js/Global.js" as Global
import ".."

Rectangle
{

    signal handle(string name)

    width: mediator.width
    height: mediator.height

    border {color: "red"; width: 2}

    Component.onCompleted:
    {
        windowFooter.activateBackArrow(Global.history.length >= 2)
        windowHeader.text = qsTr("New Data")
    }
}
