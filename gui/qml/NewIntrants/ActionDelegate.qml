import QtQuick 2.7

Component {
  id: actionDelegate
  Text {
    text: title
    elide: Text.ElideRight
    width: parent.parent.width
    horizontalAlignment: Text.AlignHCenter
  }
}
