import QtQuick 2.0
import QtQuick.Controls 2.0

import "/js/Global.js" as Global
import ".."

Rectangle
{
  id: addIntrantItem

  signal handle(string name)

  width: mediator.width
  height: mediator.height

  TextField {
    id: titleField
    focus: true
    placeholderText: qsTr("Enter title")
    width: parent.width
    height: 50
    background: FocusRectangle {
      textField: titleField
    }
    onEditingFinished:
    {
      intrant.title =  titleField.text
    }
  }

  FocusRectangle {
    textField: editDescription
    width: parent.width
    height: 100
    border.color: editDescription.focus ? "red" : "transparent"
    anchors.top: titleField.bottom

    Flickable {
      id: flickDescription

      width: parent.width; height: parent.height;
      contentWidth: editDescription.paintedWidth
      contentHeight: editDescription.paintedHeight
      clip: true
      flickableDirection: Flickable.VerticalFlick
      leftMargin: 10

      function ensureVisible(r)
      {
        if (contentY >= r.y)
          contentY = r.y;
        else if (contentY+height <= r.y+r.height)
          contentY = r.y+r.height-height;
      }

      TextEdit {
        id: editDescription
        width: flickDescription.width
        height: flickDescription.height
        wrapMode: TextEdit.Wrap
        onCursorRectangleChanged: flickDescription.ensureVisible(cursorRectangle)

        PlaceHolderText {
          placeHolderText:  "Enter description here..."
          textField: editDescription
        }
      }
    }
  }

  Component.onCompleted:
  {
    windowHeader.text = qsTr("Add intrant")
  }
  Component.onDestruction:
  {
    intrant.clear()
  }
}
