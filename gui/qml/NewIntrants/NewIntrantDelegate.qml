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

    width: newIntrantsList.width
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
        rightMargin: mainWindow.scaledValue(settings.value("CloseButton", "rightMargin"));
      }
      visible: false
      onClicked: intrant.state = '';
    }

    ColumnLayout {
      id: mainColumn

      anchors.fill: parent

      Text {
        id: titleData
        text: title
        elide: Text.ElideRight
        wrapMode: intrant.state == 'Details' ? Text.Wrap : Text.NoWrap
        font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "title.pixelSize"))
        Layout.alignment: Qt.AlignTop
        Layout.fillWidth: true
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
        height: intrant.height - titleData.height - mainWindow.scaledValue(settings.value("GeneralLayout", "margin.bottom"))

        contentWidth: width
        contentHeight: contentItem.childrenRect.height
        clip: true
        flickableDirection: Flickable.VerticalFlick

        /*
       * Lay out the data: title, description,...
       */
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
            id: descriptionData
            text: description
            textFormat: Text.RichText
            font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "description.pixelSize"))
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

          anchors.margins: {
            left: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"));
            right: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"));
          }

          // do not say anything about the height or this Flickable area will not allow
          // to scroll down without getting back up
          anchors.right: parent.right
          anchors.left: parent.left

          spacing: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))
          visible: false

          Common.ActionButton {
            id: deleteBtn
            buttonText: qsTr("Delete")
            Layout.fillWidth: true
            onClicked: {
              dataManager.removeIntrant(newIntrantsList.model, index)
              newIntrantsList.intrantClosed()
            }
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
              newIntrantsList.model.setDate(index, pickedDate)
              dataManager.transferIntrant(newIntrantsList.model, incubatedModel, index)
              newIntrantsList.intrantClosed()
            }
            onDefaultClicked: {
              console.log("incubating index " + index + " without date")
              dataManager.transferIntrant(newIntrantsList.model, incubatedModel, index)
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
              newIntrantsList.model.setDate(index, pickedDate)
              dataManager.transferIntrant(newIntrantsList.model, referencesModel, index)
              newIntrantsList.intrantClosed()

            }
            onDefaultClicked: {
              console.log("setting index " + index + " as a reference without date")
              dataManager.transferIntrant(newIntrantsList.model, referencesModel, index)
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

          anchors.margins: {
            left: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"));
            right: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"));
          }

          // do not say anything about the height or this Flickable area will not allow
          // to scroll down without getting back up
          anchors.right: parent.right
          anchors.left: parent.left

          spacing: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))
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
              dataManager.transferIntrant(newIntrantsList.model, projectsModel, index)
              actionsModel.clear()
              newIntrantsList.intrantClosed()
            }
          }

          // List of defined actions
          ListView
          {
            id: actionsList

            Layout.fillWidth: true

            height: mainWindow.scaledValue(settings.value("Projects", "actionsListHeight"))

            visible: true

            orientation: ListView.Vertical

            header: Text {
              text: "Actions list"
              font { pixelSize: mainWindow.scaledValue(settings.value("NewIntrants", "actionsView.title.pixelSize")); bold: true }
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

          anchors.margins: {
            left: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"));
            right: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"));
          }

          // do not say anything about the height or this Flickable area will not allow
          // to scroll down without getting back up
          anchors.right: parent.right
          anchors.left: parent.left

          onFinalizeAction: {
            dataManager.addAction(newIntrantsList.model, sharedAction, index) // index is the intrant's index in the intrants list
            actionsModel.append({"title": sharedAction.title})
            intrant.state = 'Doable'
          }

          Binding {
            target: intrant
            property: "state"
            value: defineNextActionLayout.myState
          }
        }
      }

      /*
     * Doable / not doable buttons
     * if inside of the column layout, then these buttons never come at the bottom of the rectangle
     */
      RowLayout {
        id: doableBtnsLayout

        anchors {
          bottom: mainColumn.bottom
        }

        visible: false
        spacing: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))
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
