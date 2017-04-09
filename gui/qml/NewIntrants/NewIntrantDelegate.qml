import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

import "../Common" as Common
import "../NewIntrants/states" as States

import MyDataManagement 1.0

Component
{
  Item
  {
    id: intrant

    ListModel {
      id: actionsModel
    }

    property int initialIntrantHeight: mainWindow.scaledValue(settings.value("Intrant", "height"))

    width: newIntrantsList.width
    height: initialIntrantHeight

    // A simple rounded rectangle for the background
    Rectangle {
      id: backgroundRectangle
      x: 2; y: 2; width: parent.width - 2 * x; height: parent.height - 2 * y
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
        right: backgroundRectangle.right;
        top: backgroundRectangle.top;
        topMargin: mainWindow.scaledValue(settings.value("CloseButton", "topMargin"));
        rightMargin: mainWindow.scaledValue(settings.value("CloseButton", "rightMargin"));  }
      visible: false
      onClicked: intrant.state = '';
    }

    ColumnLayout {
      id: mainColumn

      anchors.fill: parent

      /*
       * Lay out the data: title, description,...
       */
      ColumnLayout {
        id: dataLayout
        spacing: 10

        Layout.alignment: Qt.AlignTop
        Layout.topMargin: 10
        Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
        Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))

        Text {
          id: titleData
          text: title
          elide: Text.ElideRight
          wrapMode: intrant.state == 'Details' ? Text.Wrap : Text.NoWrap
          Layout.fillWidth: true
          font.pixelSize: mainWindow.scaledValue(settings.value("NewIntrants", "title.pixelSize"))
        }

        Text {
          id: descriptionData
          text: description
          textFormat: Text.RichText
          font.pixelSize: mainWindow.scaledValue(settings.value("NewIntrants", "description.pixelSize"))
          Layout.fillWidth: true
          wrapMode: Text.Wrap
          visible: false
        }
      }

      /*
       * "Not doable" actions: delete, incubate, set as reference
       */
      ColumnLayout {
        id: notDoableLayout

        Layout.alignment: Qt.AlignTop
        Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
        Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))

        spacing: 5
        visible: false

        Common.ActionButton {
          id: deleteBtn
          buttonText: qsTr("Delete")
          Layout.fillWidth: true
          onClicked: dataManager.removeIntrant(newIntrantsModel, index)
        }

        Common.ActionButton {
          id: incubateBtn
          buttonText: qsTr("Incubate")
          Layout.fillWidth: true
          onClicked: intrant.state = 'Incubate'
        }

        Common.DatePicker {
          id: incubationDatePicker
          defaultText: qsTr("Maybe one day")
          visible: false
          onDateValidated: {
            console.log("incubating index " + index + " with date " + pickedDate)
            newIntrantsModel.setDate(index, pickedDate)
            dataManager.transferIntrant(newIntrantsModel, incubatedModel, index)
            newIntrantsList.intrantClosed()
          }
          onDefaultClicked: {
            console.log("incubating index " + index + " without date")
            dataManager.transferIntrant(newIntrantsModel, incubatedModel, index)
            newIntrantsList.intrantClosed()
          }
        }

        Common.ActionButton {
          id: referenceBtn
          buttonText: qsTr("Keep as reference")
          Layout.fillWidth: true
          onClicked: intrant.state = 'SetAsReference'
        }

        Common.DatePicker {
          id: referenceDatePicker
          defaultText: qsTr("No deadline")
          visible: false
          onDateValidated: {
            console.log("setting index " + index + " as a reference with date " + pickedDate)
            newIntrantsModel.setDate(index, pickedDate)
            dataManager.transferIntrant(newIntrantsModel, referencesModel, index)
            newIntrantsList.intrantClosed()

          }
          onDefaultClicked: {
            console.log("setting index " + index + " as a reference without date")
            dataManager.transferIntrant(newIntrantsModel, referencesModel, index)
            newIntrantsList.intrantClosed()
          }
        }

        Item { // only way found to push the layout upwards, i.e.
          // to move all the above buttons to the top
          id: dummy
          Layout.fillHeight: true
        }
      }

      /*
       * "Doable" actions: define next actions button and list of defined next actions
       */
      ColumnLayout {
        id: doableLayout

        Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
        Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))

        spacing: 10
        visible: false

        Common.ActionButton {
          id: addNextActionBtn
          buttonText: qsTr("Define next action")
          Layout.fillWidth: true
          onClicked: {
            intrant.state = 'DefineNextAction'
            sharedAction.reset()
          }
        }

        Common.ActionButton {
          id: addProjectBtn
          buttonText: qsTr("Done")
          Layout.fillWidth: true
          visible: actionsModel.count > 0
          onClicked: {
            dataManager.transferIntrant(newIntrantsModel, projectsModel, index)
            actionsModel.clear()
            newIntrantsList.intrantClosed()
          }
        }

        // List of defined actions
        ListView
        {
          id: actionsList

          Layout.fillWidth: true
          Layout.fillHeight: true

          visible: true

          orientation: ListView.Vertical

          header: Text {
            text: "Actions list"
            font { pointSize: 18; bold: true }
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
          }

          model: actionsModel
          delegate: ActionDelegate { }
        }

      }

      /*
     * Define next action
     */
      Common.DefineNextActionLayout {
        id: defineNextActionLayout

        onFinalizeAction: {
          dataManager.addAction(newIntrantsModel, sharedAction, index) // index is the intrant's index in the intrants list
          actionsModel.append({"title": sharedAction.title})
          intrant.state = 'Doable'
        }

        Binding {
          target: intrant
          property: "state"
          value: defineNextActionLayout.myState
        }
      }

      /*
       * Doable / not doable buttons
       * if inside of the column layout, then these buttons never come at the bottom of the rectangle
       */
      RowLayout {
        id: doableBtnsLayout

        anchors {
          bottom: mainColumn.bottom; bottomMargin: 1
        }

        visible: false
        spacing: 5
        Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
        Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))
        Layout.fillWidth: true

        Common.ActionButton {
          buttonText: qsTr("Doable")
          Layout.fillWidth: true
          onClicked: intrant.state = 'Doable' // TODO: clear listview model
        }

        Common.ActionButton {
          buttonText: qsTr("Not doable")
          Layout.fillWidth: true
          onClicked: intrant.state = 'NotDoable'
        }
      }
    }

    /*
     * State machine
     */
    states: [ States.DetailsState {
        name: "Details"
      }, States.NotDoableState {
        name: "NotDoable"
      }, States.IncubateState {
       name: "Incubate"
      }, States.SetAsReferenceState {
        name: "SetAsReference"
      }, States.DoableState {
          name: "Doable"
      }, States.DefineNextActionState {
        name: "DefineNextAction"
      }, States.PostponeActionState {
        name: "PostponeAction"
      }, States.DelegateActionState {
        name: "DelegateAction"
      }, States.DefaultState {
        name: ""
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
