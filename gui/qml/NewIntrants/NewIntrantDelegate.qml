import QtQuick 2.5
import QtQuick.Controls 2.0

import "../Common" as Common
import "../NewIntrants/states" as States

import MyDataManagement 1.0

Component
{
  Item
  {
    id: intrant

    ListModel {
      id: actionModel
    }

    property int initialIntrantHeight: 40

    width: newIntrantsList.width // TODO: set the parent here
    height: initialIntrantHeight

    // A simple rounded rectangle for the background
    Rectangle {
      id: backgroundRectangle
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
    Common.TextButton {
      id: closeButton
      y: 10
      anchors { right: backgroundRectangle.right; rightMargin: 10 }
      visible: false
      text: "Close"

      onClicked: intrant.state = '';
    }

    /*
     * Lay out the data: title, description,...
     */
    Column {
      id: dataLayout
      x: 0; y: 10;
      spacing: 10

      Text {
        id: titleData
        text: title
        elide: Text.ElideRight
        wrapMode: intrant.state == 'Details' ? Text.Wrap : Text.NoWrap
        x: 10
        width: backgroundRectangle.width - 2 * x
        font.pixelSize: 24
      }

      Text {
        id: descriptionData
        text: description
        textFormat: Text.RichText
        font.pixelSize: 15
        x: 15
        width: backgroundRectangle.width - 2 * x
        wrapMode: Text.Wrap
        visible: false
      }
    }

    /*
     * Doable / not doable buttons
     */
    Row {
      id: doableBtnsLayout
      property int leftMargin: 2;

      anchors {
        bottom: backgroundRectangle.bottom; bottomMargin: 1
        left: backgroundRectangle.left; leftMargin: leftMargin
      }
      visible: false
      spacing: 0

      property int buttonWidth: (backgroundRectangle.width - 2 * leftMargin) / 2
      property int buttonHeight: 25

      Common.ActionButton {
        buttonText: qsTr("Doable")
        width: parent.buttonWidth
        height: parent.buttonHeight
        radius: 5
        function onClicked()
        {
          intrant.state = 'Doable'
          // TODO: clear listview model
        }
      }
      Common.ActionButton {
        buttonText: qsTr("Not doable")
        width: parent.buttonWidth
        height: parent.buttonHeight
        radius: 5
        function onClicked()
        {
          intrant.state = 'NotDoable'
        }
      }
    }

    /*
     * "Not doable" actions: delete, incubate, set as reference
     */
    Column {
      id: notDoableLayout
      spacing: 10
      visible: false

      anchors {
        top: dataLayout.bottom; topMargin: 1
        horizontalCenter: backgroundRectangle.horizontalCenter
      }

      property int buttonWidth: backgroundRectangle.width
      property int buttonHeight: 25

      Common.ActionButton {
        id: deleteBtn
        buttonText: qsTr("Delete")
        width: parent.buttonWidth
        height: parent.buttonHeight
        radius: 5
        function onClicked()
        {
          console.log("deleting index = " + index)
          dataManager.removeIntrant(newIntrantsModel, index)
        }
      }
      Common.ActionButton {
        id: incubateBtn
        buttonText: qsTr("Incubate")
        width: parent.buttonWidth
        height: parent.buttonHeight
        radius: 5
        function onClicked()
        {
          intrant.state = 'Incubate'
        }
      }

      Common.DatePicker {
        id: incubationDatePicker
        background: backgroundRectangle
        defaultText: qsTr("Maybe one day")
        visible: false
        function onDateValidated(pickedDate)
        {
          console.log("incubating index " + index + " with date " + pickedDate)
          newIntrantsModel.setDate(index, pickedDate)
          dataManager.transferIntrant(newIntrantsModel, incubatedModel, index)
        }
        function onDefaultClicked()
        {
          console.log("incubating index " + index + " without date")
          dataManager.transferIntrant(newIntrantsModel, incubatedModel, index)
        }
      }

      Common.ActionButton {
        id: referenceBtn
        buttonText: qsTr("Keep as reference")
        width: parent.buttonWidth
        height: parent.buttonHeight
        radius: 5
        function onClicked()
        {
          intrant.state = 'SetAsReference'
        }
      }

      Common.DatePicker {
        id: referenceDatePicker
        background: backgroundRectangle
        defaultText: qsTr("No deadline")
        visible: false
        function onDateValidated(pickedDate)
        {
          console.log("setting index " + index + " as a reference with date " + pickedDate)
          newIntrantsModel.setDate(index, pickedDate)
          dataManager.transferIntrant(newIntrantsModel, referencesModel, index)
        }
        function onDefaultClicked()
        {
          console.log("setting index " + index + " as a reference without date")
          dataManager.transferIntrant(newIntrantsModel, referencesModel, index)
        }
      }
    }

    /*
     * "Doable" actions: define next actions button and list of defined next actions
     */
    Column {
      id: doableLayout
      spacing: 10
      visible: false

      anchors {
        top: dataLayout.bottom; topMargin: 1
        horizontalCenter: backgroundRectangle.horizontalCenter
      }

      property int buttonWidth: backgroundRectangle.width
      property int buttonHeight: 25

      Common.ActionButton {
        id: addNextActionBtn
        buttonText: qsTr("Define next action")
        width: parent.buttonWidth
        height: parent.buttonHeight
        radius: 5
        function onClicked()
        {
          intrant.state = 'DefineNextAction'
          sharedAction.reset()
        }
      }

      Common.ActionButton {
        id: addProjectBtn
        buttonText: qsTr("Done")
        width: parent.buttonWidth
        height: parent.buttonHeight
        visible: actionModel.count > 0
        radius: 5
        function onClicked()
        {
          console.log("Define the project!")
          dataManager.transferIntrant(newIntrantsModel, projectsModel, index)
          actionModel.clear()
        }
      }

    }

    /*
     * Define next action
     */
    Column {
      id: defineNextActionLayout
      spacing: 10
      visible: false

      anchors {
        top: dataLayout.bottom; topMargin: 1
        horizontalCenter: backgroundRectangle.horizontalCenter
      }

      property int sideMargin: 10

      TextField {
        id: actionTitleField
        focus: false
        placeholderText: qsTr("Enter action title")
        width: backgroundRectangle.width - 2 * defineNextActionLayout.sideMargin
        height: 50
        background: Common.FocusRectangle {
          textField: actionTitleField
        }
        Binding {
          target: sharedAction
          property: "title"
          value: actionTitleField.text
        }
      }

      Column {
        spacing: 5

        property int buttonWidth: backgroundRectangle.width
        property int buttonHeight: 25

        Common.ActionButton {
          id: postponeBtn
          buttonText: qsTr("Post-pone")
          width: parent.buttonWidth - 2 * defineNextActionLayout.sideMargin
          height: parent.buttonHeight
          radius: 5
          function onClicked()
          {
            intrant.state = 'PostponeAction'
          }
        }

        function finalizeAction()
        {
          dataManager.addAction(newIntrantsModel, sharedAction, index)
          actionModel.append({"title": sharedAction.title})
          intrant.state = 'Doable'
        }

        Common.SimpleDatePicker {
          id: postponedActionDatePicker
          background: backgroundRectangle
          visible: false
          function onDateValidated(pickedDate)
          {
            sharedAction.deadline = pickedDate
            parent.finalizeAction()
          }
        }

        Common.ActionButton {
          id: delegateBtn
          buttonText: qsTr("Delegate")
          width: parent.buttonWidth - 2 * defineNextActionLayout.sideMargin
          height: parent.buttonHeight
          radius: 5
          function onClicked()
          {
            intrant.state = 'DelegateAction'
          }
        }

        TextField {
          id: delegateField
          visible: false
          focus: true
          placeholderText: qsTr("Enter delegate name")
          width: backgroundRectangle.width - 2 * defineNextActionLayout.sideMargin
          height: 50
          background: Common.FocusRectangle {
            textField: delegateField
          }
          Binding {
            target: sharedAction
            property: "delegate"
            value: delegateField.text
          }
        }

        Common.SimpleDatePicker {
          id: delegatedActionDatePicker
          background: backgroundRectangle
          visible: false
          function onDateValidated(pickedDate)
          {
            sharedAction.deadline = pickedDate
            parent.finalizeAction()
          }
        }

        Common.ActionButton {
          id: validateActionBtn
          buttonText: qsTr("Done")
          width: parent.buttonWidth - 2 * defineNextActionLayout.sideMargin
          height: parent.buttonHeight
          radius: 5
          function onClicked()
          {
            parent.finalizeAction()
          }
        }
      }
    }

    // List of defined actions
    ListView
    {
      id: actionList

      visible: false

      width: backgroundRectangle.width
      height: 250

      anchors {
        top: doableLayout.bottom; topMargin: 1
        horizontalCenter: backgroundRectangle.horizontalCenter
      }

      orientation: ListView.Vertical

      header: Text {
        text: "Action list"
        font { pointSize: 18; bold: true }
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
      }

      model: actionModel
      delegate: ActionDelegate { }
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
      }]

    transitions: Transition {
      // Make the state changes smooth
      ParallelAnimation {
        ColorAnimation { property: "color"; duration: 500 }
        NumberAnimation { duration: 300; properties: "x,contentY,height,width" }
      }
    }

  }
}