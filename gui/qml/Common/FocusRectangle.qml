import QtQuick 2.7

Rectangle {
  property var textField
  border.color: textField.activeFocus ? "red" : "transparent"
}
