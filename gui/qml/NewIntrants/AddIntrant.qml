import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

import MyDataManagement 1.0

import "/js/Global.js" as Global
import "../Common/" as Common

Rectangle
{
  id: addIntrantItem

  signal handle(string name)

  width: mediator.width
  height: mediator.height

  // TODO: make the whole rectangle flickable (except the row layout for the cancel / save buttons)

  ColumnLayout {

    anchors.fill: parent

    Common.TextField {
      id: titleField
      focus: true
      placeholderText: qsTr("Enter title")
      Layout.fillWidth: true
      Binding {
        target: sharedIntrant
        property: "title"
        value: titleField.text
      }
    }

    Common.FocusableTextEdit {
      id: descriptionField
      Layout.fillWidth: true
      placeHolderText: qsTr("Enter (optional) description here")
      Binding {
        target: sharedIntrant
        property: "description"
        value: descriptionField.editedText
      }
    }
  }

  RowLayout {

    spacing: 5

    anchors { bottom: addIntrantItem.bottom; left: addIntrantItem.left; right: addIntrantItem.right }

    Common.ActionButton {
      Layout.fillWidth: true
      buttonText: qsTr("Cancel")

      onClicked: {
        sharedIntrant.reset()
        handle("newIntrants.manage")
      }
    }

    Common.ActionButton {
      Layout.fillWidth: true
      buttonText: qsTr("Save")

      onClicked: {
        // TODO: instead of using a sharedIntrant, we could
        // 1. create a new entry in the model
        // 2. set the currentIndex to the last model entry
        // 3. set the data directly in that last model entry
        // if cancel, then remove last model entry
        dataManager.addIntrant(newIntrantsModel, sharedIntrant)
        sharedIntrant.reset()
        handle("newIntrants.manage")
      }
    }

  }

  Component.onCompleted:
  {
    windowHeader.text = qsTr("Add intrant")
    sharedIntrant.reset()
  }
}
