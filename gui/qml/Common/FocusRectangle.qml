import QtQuick 2.5

Rectangle {
  property var textField
  border.color: textField.activeFocus ? "red" : "transparent"
}
