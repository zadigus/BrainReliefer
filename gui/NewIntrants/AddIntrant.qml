import QtQuick 2.0

import "/js/Global.js" as Global
import ".."

Rectangle
{

    signal handle(string name)

    width: mediator.width
    height: mediator.height

    border {color: "red"; width: 2}
}
