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

    property int initialIntrantHeight: mainWindow.scaledValue(settings.value("Intrant", "height"))

    width: parent.width
    height: initialIntrantHeight

    // A simple rounded rectangle for the background
    Rectangle { // TODO: use the same style everywhere: references, new intrants, ...
      id: background
      x: 2; y: 2; width: parent.width - 2*x; height: parent.height - 2*y
      color: "ivory"
      border.color: "orange"
      radius: 5
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

      // Lay out the page: title, description, ...
      ColumnLayout {

        Layout.alignment: Qt.AlignTop
        Layout.topMargin: 10
        Layout.leftMargin: 10
        Layout.rightMargin: 10

        spacing: 10

        Text {
          id: titleField
          text: title
          elide: Text.ElideRight
          wrapMode: intrant.state == 'Details' ? Text.Wrap : Text.NoWrap
          Layout.fillWidth: true
          font.pixelSize: mainWindow.scaledValue(settings.value("Projects", "title.pixelSize"))
        }

        Text {
          id: descriptionField
          text: description
          textFormat: Text.RichText
          font.pixelSize: mainWindow.scaledValue(settings.value("Projects", "description.pixelSize"))
          Layout.fillWidth: true
          wrapMode: Text.Wrap
          visible: false
        }

        Text {
          id: deadlineField
          text: deadline
          font.pixelSize: mainWindow.scaledValue(settings.value("Projects", "deadline.pixelSize"))
          Layout.fillWidth: true
          wrapMode: Text.Wrap
          visible: false
        }

        ListView {
          id: actionsList

          Layout.fillWidth: true
          Layout.fillHeight: true

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
        onFinalizeAction: {
          dataManager.addAction(projectsModel, sharedAction, index)
          intrant.state = 'Details'
        }
        Binding {
          target: intrant
          property: "state"
          value: defineNextActionLayout.myState
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
