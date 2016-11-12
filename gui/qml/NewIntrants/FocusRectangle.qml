import QtQuick 2.5

import "/js/Global.js" as Global

Rectangle {
  property var textField
  border.color: textField.focus ? "red" : "transparent"
}
