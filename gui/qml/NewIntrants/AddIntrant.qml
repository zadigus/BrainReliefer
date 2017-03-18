import QtQuick 2.5
import QtQuick.Controls 2.0

import MyDataManagement 1.0

import "/js/Global.js" as Global
import "../Common/" as Common

Rectangle
{
  id: addIntrantItem

  signal handle(string name)

  width: mediator.width
  height: mediator.height

  // TODO: make the whole rectangle flickable

  Common.TextField {
    id: titleField
    focus: true
    placeholderText: qsTr("Enter title")
    width: parent.width
    Binding {
      target: sharedIntrant
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

  Common.FocusableTextEdit {
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

  Common.ActionButton {
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
