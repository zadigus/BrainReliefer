import QtQuick 2.7

import "/js/Global.js" as Global
import ".."

FocusRectangle {
    id: myRootFocusRectangle
    property string placeHolderText

    property alias editedText: myTextEdit.text

    textField: myTextEdit

    Flickable {
      id: myFlickable

      width: parent.width; height: parent.height;
      contentWidth: myTextEdit.paintedWidth
      contentHeight: myTextEdit.paintedHeight
      clip: true
      flickableDirection: Flickable.VerticalFlick

      function ensureVisible(r)
      {
        if (contentY >= r.y)
          contentY = r.y;
        else if (contentY+height <= r.y+r.height)
          contentY = r.y+r.height-height;
      }

      TextEdit {
        id: myTextEdit
        x: 10;
        width: myFlickable.width - 2*x
        height: myFlickable.height
        wrapMode: TextEdit.Wrap
        onCursorRectangleChanged: myFlickable.ensureVisible(cursorRectangle)

        PlaceHolderText {
          placeHolderText: myRootFocusRectangle.placeHolderText
          textField: myTextEdit
        }
      }
    }
  }
