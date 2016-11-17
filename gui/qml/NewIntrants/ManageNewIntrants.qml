import QtQuick 2.0
import QtQuick.Controls 1.4

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
      TextButton {
        id: closeButton
        y: 10
        anchors { right: background.right; rightMargin: 10 }
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
          width: background.width - 2 * x
          font.pixelSize: 24
        }

        Text {
          id: descriptionData
          text: description
          textFormat: Text.RichText
          font.pixelSize: 15
          x: 15
          width: background.width - 2 * x
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
          bottom: background.bottom; bottomMargin: 1
          left: background.left; leftMargin: leftMargin
        }
        visible: false
        spacing: 0

        property int buttonWidth: (background.width - 2 * leftMargin) / 2
        property int buttonHeight: 25

        ActionButton {
          buttonText: qsTr("Doable")
          width: parent.buttonWidth
          height: parent.buttonHeight
          radius: 5
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
          horizontalCenter: background.horizontalCenter
        }

        property int buttonWidth: background.width
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
          id: incubationDateSelectionLayout
          background: background
          defaultText: qsTr("Maybe one day")
          visible: false
          function onDateValidated(pickedDate)
          {
            console.log("incubating index " + index + " with date " + pickedDate)
            console.log("year = " + pickedDate.toLocaleDateString(Qt.locale(), "yyyy"))

          }
          function onDefaultClicked()
          {
            console.log("incubating index " + index + " without date")
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
          id: referenceDateSelectionLayout
          background: background
          defaultText: qsTr("No deadline")
          visible: false
          function onDateValidated(pickedDate)
          {
            console.log("setting index " + index + " as a reference with date " + pickedDate)
            newIntrantsModel.setDate(index, pickedDate) // TODO: why can't I serialize here??? it works, but the dataManager is then unavailable ...
            dataManager.transferIntrant(newIntrantsModel, referencesModel, index)
            // TODO: why aren't the models available here after this call???? The following command will fail:
//            console.log("nbrOfReferences = " + newIntrantsModel.getNbrOfIntrants())
          }
          function onDefaultClicked()
          {
            console.log("setting index " + index + " as a reference without date")
            dataManager.transferIntrant(newIntrantsModel, referencesModel, index)
          }
        }

      }

      /*
       * State machine
       */
      states: [ State {
          name: "Details"
          PropertyChanges { target: background; color: "red" }
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
          PropertyChanges { target: background; color: "green" }
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
          PropertyChanges { target: background; color: "blue" }
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
          PropertyChanges { target: incubationDateSelectionLayout; visible: true }
          PropertyChanges { target: deleteBtn; visible: false }
          PropertyChanges { target: referenceBtn; visible: false }
        }, State {
          name: "SetAsReference"
          PropertyChanges { target: background; color: "blue" }
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
          PropertyChanges { target: referenceDateSelectionLayout; visible: true }
          PropertyChanges { target: deleteBtn; visible: false }
          PropertyChanges { target: incubateBtn; visible: false }
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
