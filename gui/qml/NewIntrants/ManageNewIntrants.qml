import QtQuick 2.5
import QtQuick.Controls 2.0

import MyDataManagement 1.0

import "/js/Global.js" as Global
import ".."
import "../Common"

Item {

  signal handle(string name)

  /*Component
    {
        id: bannerComponent

        Rectangle
        {
            id: banner
            width: parent.width
            height: 50
            gradient: clubcolors
            border {color: "#9EDDF2"; width: 2}
            Text
            {
                anchors.centerIn: parent
                text: "New Intrants"
                font.pixelSize: 32
            }
        }
    }*/

  Gradient
  {
    id: clubcolors
    GradientStop { position: 0.0; color: "#8EE2FE"}
    GradientStop { position: 0.66; color: "#7ED2EE"}
  }

  ListModel {
    id: actionModel
  }

  Component
  {
    id: actionDelegate
    Text {
      text: title
    }
  }

  Component
  {
    id: intrantDelegate
    Item
    {
      id: intrant

      property int initialIntrantHeight: 40

      width: list.width
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
      TextButton {
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

        ActionButton {
          buttonText: qsTr("Doable")
          width: parent.buttonWidth
          height: parent.buttonHeight
          radius: 5
          function onClicked()
          {
            intrant.state = 'Doable'
          }
        }
        ActionButton {
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

        ActionButton {
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
        ActionButton {
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

        DatePicker {
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

        ActionButton {
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

        DatePicker {
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

        ListView
        {
          id: actionList
          width: backgroundRectangle.width
          height: 250

          orientation: ListView.Vertical
          header: Text {
            text: "Action list"
          }

          model: actionModel
          delegate: actionDelegate

        }

        ActionButton {
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

        ActionButton {
          id: addProjectBtn
          buttonText: qsTr("Done")
          width: parent.buttonWidth
          height: parent.buttonHeight
          visible: actionModel.count > 0
          radius: 5
          function onClicked()
          {
//            intrant.state = 'DefineNextAction'
//            sharedAction.reset()
            console.log("Define the project!")
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
          background: FocusRectangle {
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

          ActionButton {
            id: postponeBtn
            buttonText: qsTr("Post-pone")
            width: parent.buttonWidth - 2 * defineNextActionLayout.sideMargin
            height: parent.buttonHeight
            radius: 5
            function onClicked()
            {
              console.log("Set to agenda")
              intrant.state = 'PostponeAction'
            }
          }

          function finalizeAction()
          {
            dataManager.addAction(newIntrantsModel, sharedAction, index)
            actionModel.append({"title": sharedAction.title})
            intrant.state = 'Doable'
          }

          SimpleDatePicker {
            id: postponedActionDatePicker
            background: backgroundRectangle
            visible: false
            function onDateValidated(pickedDate)
            {
              console.log("Validate the date " + pickedDate)
              sharedAction.deadline = pickedDate
              parent.finalizeAction()
            }
          }

          ActionButton {
            id: delegateBtn
            buttonText: qsTr("Delegate")
            width: parent.buttonWidth - 2 * defineNextActionLayout.sideMargin
            height: parent.buttonHeight
            radius: 5
            function onClicked()
            {
              console.log("Ask for delegate's name and deadline")
            }
          }

          ActionButton {
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

        // TODO: when finished, go back to doable state
      }

      /*
       * State machine
       */
      states: [ State {
          name: "Details"
          PropertyChanges { target: backgroundRectangle; color: "red" }
          // Make details visible
          PropertyChanges { target: intrant; x: 0 }
          // Fill the entire list area with the detailed view
          PropertyChanges { target: intrant; height: list.height + intrant.initialIntrantHeight / 2 }
          // Move the list so that this item is at the top.
          PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
          // Disallow flicking while we're in detailed view
          PropertyChanges { target: intrant.ListView.view; interactive: false }
          // Show close button
          PropertyChanges { target: closeButton; visible: true }
          // Show doable / not doable buttons
          PropertyChanges { target: doableBtnsLayout; visible: true }
          // Show description
          PropertyChanges { target: descriptionData; visible: true }
        }, State {
          name: "NotDoable"
          PropertyChanges { target: backgroundRectangle; color: "green" }
          PropertyChanges { target: intrant; x: 0; }
          // Fill the entire list area with the "not doable" view
          PropertyChanges { target: intrant; height: list.height + intrant.initialIntrantHeight / 2 }
          // Move the list so that this item is at the top.
          PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
          // Disallow flicking while we're in detailed view
          PropertyChanges { target: intrant.ListView.view; interactive: false }
          // Show close button
          PropertyChanges { target: closeButton; visible: true }
          // Show not doable buttons: delete, incubate, keep as reference
          PropertyChanges { target: notDoableLayout; visible: true }
        }, State {
          name: "Incubate"
          PropertyChanges { target: backgroundRectangle; color: "blue" }
          PropertyChanges { target: intrant; x: 0; }
          // Fill the entire list area with the "not doable" view
          PropertyChanges { target: intrant; height: list.height + intrant.initialIntrantHeight / 2 }
          // Move the list so that this item is at the top.
          PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
          // Disallow flicking while we're in detailed view
          PropertyChanges { target: intrant.ListView.view; interactive: false }
          // Show close button
          PropertyChanges { target: closeButton; visible: true }
          // Show not doable buttons: delete, incubate, keep as reference
          PropertyChanges { target: notDoableLayout; visible: true }
          // Show Calendar settings
          PropertyChanges { target: incubationDatePicker; visible: true }
          PropertyChanges { target: deleteBtn; visible: false }
          PropertyChanges { target: referenceBtn; visible: false }
        }, State {
          name: "SetAsReference"
          PropertyChanges { target: backgroundRectangle; color: "blue" }
          PropertyChanges { target: intrant; x: 0; }
          // Fill the entire list area with the "not doable" view
          PropertyChanges { target: intrant; height: list.height + intrant.initialIntrantHeight / 2 }
          // Move the list so that this item is at the top.
          PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
          // Disallow flicking while we're in detailed view
          PropertyChanges { target: intrant.ListView.view; interactive: false }
          // Show close button
          PropertyChanges { target: closeButton; visible: true }
          // Show not doable buttons: delete, incubate, keep as reference
          PropertyChanges { target: notDoableLayout; visible: true }
          // Show Calendar settings
          PropertyChanges { target: referenceDatePicker; visible: true }
          PropertyChanges { target: deleteBtn; visible: false }
          PropertyChanges { target: incubateBtn; visible: false }
        }, State {
          name: "Doable"
          PropertyChanges { target: backgroundRectangle; color: "white" }
          PropertyChanges { target: intrant; x: 0; }
          // Fill the entire list area with the "doable" view
          PropertyChanges { target: intrant; height: list.height + intrant.initialIntrantHeight / 2 }
          // Move the list so that this item is at the top.
          PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
          // Disallow flicking while we're in detailed view
          PropertyChanges { target: intrant.ListView.view; interactive: false }
          // Show close button
          PropertyChanges { target: closeButton; visible: true }
          // Show doable page layout
          PropertyChanges { target: doableLayout; visible: true }
        }, State {
          name: "DefineNextAction"
          PropertyChanges { target: backgroundRectangle; color: "white" }
          PropertyChanges { target: intrant; x: 0; }
          // Fill the entire list area with the state's view
          PropertyChanges { target: intrant; height: list.height + intrant.initialIntrantHeight / 2 }
          // Move the list so that this item is at the top.
          PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
          // Disallow flicking while we're in detailed view
          PropertyChanges { target: intrant.ListView.view; interactive: false }
          // Show close button
          PropertyChanges { target: closeButton; visible: true }
          // Show state page layout
          PropertyChanges { target: defineNextActionLayout; visible: true }
        }, State {
          name: "PostponeAction"
          PropertyChanges { target: backgroundRectangle; color: "white" }
          PropertyChanges { target: intrant; x: 0; }
          // Fill the entire list area with the state's view
          PropertyChanges { target: intrant; height: list.height + intrant.initialIntrantHeight / 2 }
          // Move the list so that this item is at the top.
          PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
          // Disallow flicking while we're in detailed view
          PropertyChanges { target: intrant.ListView.view; interactive: false }
          // Show close button
          PropertyChanges { target: closeButton; visible: true }
          // Show state page layout
          PropertyChanges { target: defineNextActionLayout; visible: true }
          PropertyChanges { target: postponedActionDatePicker; visible: true }
          PropertyChanges { target: delegateBtn; visible: false}
          PropertyChanges { target: validateActionBtn; visible: false}
          StateChangeScript { script: postponedActionDatePicker.displayCalendar() }
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

  ListView
  {
    id: list
    //        anchors.fill: parent
    width: mediator.width
    height: mediator.height

    signal handle(string name)

    orientation: ListView.Vertical

    model: newIntrantsModel
    delegate: intrantDelegate

    //    highlight: Rectangle {
    //      width: parent.width
    //      color: "lightgray"
    //      y: list.currentItem.y
    //    }

    Component.onCompleted:
    {
      windowFooter.activateHome(true)
      windowFooter.activateBackArrow(Global.history.length >= 2)
      windowHeader.text = qsTr("New Intrants List")
    }

  }
}
