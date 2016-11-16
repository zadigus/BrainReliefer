import QtQuick 2.0
import QtQuick.Controls 2.0

import "/js/Global.js" as Global
//import ".."
import "../Common/"

Rectangle
{
  id: addIntrantItem

  signal handle(string name)

  width: mediator.width
  height: mediator.height

  // TODO: make the whole rectangle flickable

  TextField {
    id: titleField
    focus: true
    placeholderText: qsTr("Enter title")
    width: parent.width
    height: 50
    background: FocusRectangle {
      textField: titleField
    }
    Binding {
      target: intrant
      property: "title"
      value: titleField.text
    }
  }

  Rectangle {
    id: toBeRemoved1
    width: parent.width
    height: 50
    anchors.top: titleField.bottom
    Text {
      text: "TODO: Put a button to add optional fields like the description"
    }
  }

  Rectangle {
    id: toBeRemoved2
    width: parent.width
    height: 50
    anchors.top: toBeRemoved1.bottom
    Text {
      text: "TODO: Once save button is clicked, reset the data"
    }
  }

  FocusableTextEdit {
    id: descriptionField
    width: parent.width
    height: 100
    anchors.top: toBeRemoved2.bottom
    placeHolderText: qsTr("Enter description here")
    Binding {
      target: intrant
      property: "description"
      value: descriptionField.editedText
    }
  }

  ActionButton {
    anchors.bottom: parent.bottom
    width: parent.width
    height: 100
    buttonText: qsTr("Save")

    function onClicked()
    {
      newIntrantsModel.addIntrant(intrant)
      windowFooter.goBack()
    }
  }

  Component.onCompleted:
  {
    windowHeader.text = qsTr("Add intrant")
    intrant.reset()
  }
}
