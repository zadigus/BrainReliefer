import QtQuick 2.5

Component {
  id: actionDelegate
  Text {
    text: title
    elide: Text.ElideRight
    width: parent.parent.width
    horizontalAlignment: Text.AlignHCenter
  }
}
