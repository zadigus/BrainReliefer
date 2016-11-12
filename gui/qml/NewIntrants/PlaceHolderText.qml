import QtQuick 2.5

import "/js/Global.js" as Global

Text {
  property var textField
  property string placeHolderText

  text: placeHolderText
  color: "#aaa"
  visible: !textField.text
}
