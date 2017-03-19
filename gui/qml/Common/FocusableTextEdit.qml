import QtQuick 2.5

import "/js/Global.js" as Global
import ".."

FocusRectangle {
    id: myRootFocusRectangle

    property string placeHolderText
    property alias editedText: myTextEdit.text

    height: settings.value("TextEdit", "height")

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
        x: settings.value("TextEdit", "leftPadding");
        y: settings.value("TextEdit", "topPadding");
        width: myFlickable.width - 2*x
        height: myFlickable.height - 2*y

        font { pointSize: settings.value("TextEdit", "font.pointSize") }

        onCursorRectangleChanged: myFlickable.ensureVisible(cursorRectangle)

        PlaceHolderText {
          placeHolderText: myRootFocusRectangle.placeHolderText
          font: myTextEdit.font
          textField: myTextEdit
        }
      }
    }
  }
