import QtQuick 2.5
import QtQuick.Controls 2.0

import MyDataManagement 1.0

import "/js/Global.js" as Global
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
    onTextChanged: sharedIntrant.title = text
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

  FocusableTextEdit {
    id: descriptionField
    width: parent.width
    height: 100
    anchors.top: toBeRemoved1.bottom
    placeHolderText: qsTr("Enter description here")
    Binding {
      target: sharedIntrant
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
      dataManager.addIntrant(newIntrantsModel, sharedIntrant)
      windowFooter.goBack()
    }
  }

  Component.onCompleted:
  {
    windowHeader.text = qsTr("Add intrant")
    sharedIntrant.reset()
  }
}
