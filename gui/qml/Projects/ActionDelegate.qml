import QtQuick 2.7

import "/js/Global.js" as Global
import ".."
import "../Common"

Component
{
  Text {
    text: title
    elide: Text.ElideRight
    width: parent.parent.width
    horizontalAlignment: Text.AlignHCenter
  }
}
