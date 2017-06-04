import QtQuick 2.7
import QtQuick.Layouts 1.1

import "/js/Global.js" as Global
import ".."
import "../Common" as Common
import "states/" as States

Component
{
  Item
  {
    id: intrant

    width: parent.width
    height: mainWindow.scaledValue(settings.value("Intrant", "height"))

    Common.BackgroundRectangle {
      id: background
    }

    MouseArea {
      anchors.fill: parent
      onClicked: if(intrant.state == '') intrant.state = 'Details'
    }

    // A button to close the detailed view, i.e. set the state back to default ('').
    Common.CloseButton {
      id: closeButton
      anchors {
        right: background.right;
        top: background.top;
        topMargin: mainWindow.scaledValue(settings.value("CloseButton", "topMargin"));
        rightMargin: mainWindow.scaledValue(settings.value("CloseButton", "rightMargin"));  }
      onClicked: intrant.state = '';
      visible: false
    }

    ColumnLayout {

      anchors.fill: parent

      Text {
        id: titleField
        text: title
        elide: Text.ElideRight
        wrapMode: intrant.state == 'Details' ? Text.Wrap : Text.NoWrap
        font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "title.pixelSize"))
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop
        Layout.topMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))
        Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
        Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))
      }

      Flickable {
        id: flickableArea

        Layout.topMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))
        Layout.fillHeight: true

        width: intrant.width
        // we subtract the bottom margin from the height
        height: intrant.height - title.height - mainWindow.scaledValue(settings.value("GeneralLayout", "margin.bottom"))

        contentWidth: width
        contentHeight: contentItem.childrenRect.height
        clip: true
        flickableDirection: Flickable.VerticalFlick

        // Lay out the page: title, description, ...
        ColumnLayout {
          spacing: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))

          anchors.margins: {
            left: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"));
            right: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"));
          }

          // do not say anything about the height or this Flickable area will not allow
          // to scroll down without getting back up
          anchors.right: parent.right
          anchors.left: parent.left

          Text {
            id: descriptionField
            text: description
            textFormat: Text.RichText
            font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "description.pixelSize"))
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            visible: false
          }

          Text {
            id: deadlineField
            text: deadline
            font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "deadline.pixelSize"))
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            visible: false
          }

          ListView {
            id: actionsList

            Layout.fillWidth: true

            height: mainWindow.scaledValue(settings.value("Projects", "actionsListHeight"))

            orientation: ListView.Vertical

            model: actionsModel
            delegate: ActionDelegate {}

            visible: false
          }

          Common.AddButton {
            id: addNewActionBtn
            width: mainWindow.scaledValue(settings.value("Projects", "addBtnSize"))
            anchors { bottom: actionsList.bottom; horizontalCenter: actionsList.horizontalCenter }
            onClicked: intrant.state = 'AddAction'
            visible: false
          }

        }

        Common.DefineNextActionLayout {
          id: defineNextActionLayout

          anchors.margins: {
            left: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"));
            right: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"));
          }

          // do not say anything about the height or this Flickable area will not allow
          // to scroll down without getting back up
          anchors.right: parent.right
          anchors.left: parent.left

          onFinalizeAction: {
            dataManager.addAction(projectsList.model, sharedAction, index)
            intrant.state = 'Details'
          }
          Binding {
            target: intrant
            property: "state"
            value: defineNextActionLayout.myState
          }
        }

      }

    }

    states: [
      States.DetailsState {
        name: "Details"
      }, States.AddActionState {
        name: "AddAction"
      }, States.DelegateActionState {
        name: "DelegateAction"
      }, States.PostponeActionState {
        name: "PostponeAction"
      }
    ]

    transitions: Transition {
      // Make the state changes smooth
      ParallelAnimation {
        ColorAnimation { property: "color"; duration: 500 }
        NumberAnimation { duration: 300; properties: "x,contentY,height,width" }
      }
    }

  }
}
