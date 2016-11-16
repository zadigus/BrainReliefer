import QtQuick 2.0

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

      // Create a property to contain the visibility of the details.
      // We can bind multiple element's opacity to this one property,
      // rather than having a "PropertyChanges" line for each element we
      // want to fade.
      property bool detailsOpacity : false // TODO: use bools
      property bool notDoableOpacity : false
      property int initialIntrantHeight: 40

      width: parent.width
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
        opacity: detailsOpacity || notDoableOpacity
        text: "Close"

        onClicked: intrant.state = '';
      }

      // Lay out the page: title, description, ...
      // Note that elements that should not be visible in the list
      // mode have their opacity set to detailsOpacity.
      Column {
        id: topLayout
        x: 0; y: 10;
        height: parent.height;
        width: parent.width
        spacing: 10

        Text {
          text: title
          elide: Text.ElideRight
          wrapMode: detailsOpacity ? Text.Wrap : Text.NoWrap
          x: 10
          width: parent.width - 2 * x
          font.pixelSize: 24
        }

        Text {
          text: description
          textFormat: Text.RichText
          font.pixelSize: 15
          x: 15
          width: parent.width - 2 * x
          wrapMode: Text.Wrap
          opacity: detailsOpacity
        }
      }

      Row {

        property int leftMargin: 2;

        anchors {
          bottom: background.bottom; bottomMargin: 1
          left: background.left; leftMargin: leftMargin
        }
        opacity: detailsOpacity
        spacing: 0

        property int buttonWidth: opacity * (background.width - 2 * leftMargin) / 2
        property int buttonHeight: opacity * 25

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

      Column {

        id: notDoableLayout
        spacing: 10
        opacity: notDoableOpacity

        anchors {
          bottom: background.bottom; bottomMargin: 1
          horizontalCenter: background.horizontalCenter
        }

        property int buttonWidth: opacity * background.width
        property int buttonHeight: opacity * 25

        ActionButton {
          buttonText: qsTr("Delete")
          width: parent.buttonWidth
          height: parent.buttonHeight
          radius: 5
          function onClicked()
          {
            console.log("current index = " + index)
            newIntrantsModel.removeIntrant(index)
          }
        }
        ActionButton {
          buttonText: qsTr("Incubate")
          width: parent.buttonWidth
          height: parent.buttonHeight
          radius: 5
        }
        ActionButton {
          buttonText: qsTr("Keep as reference")
          width: parent.buttonWidth
          height: parent.buttonHeight
          radius: 5
        }
      }

      states: [ State {
        name: "Details"
        PropertyChanges { target: background; color: "red" }
        // Make details visible
        PropertyChanges { target: intrant; detailsOpacity: true; x: 0 }
        // Fill the entire list area with the detailed view
        PropertyChanges { target: intrant; height: list.height + intrant.initialIntrantHeight / 2 }
        // Move the list so that this item is at the top.
        PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
        // Disallow flicking while we're in detailed view
        PropertyChanges { target: intrant.ListView.view; interactive: false }
      }, State {
       name: "NotDoable"
       PropertyChanges { target: background; color: "green" }
       PropertyChanges { target: intrant; detailsOpacity: false; x: 0; notDoableOpacity: true }
       // Fill the entire list area with the "not doable" view
       PropertyChanges { target: intrant; height: list.height + intrant.initialIntrantHeight / 2 }
       // Move the list so that this item is at the top.
       PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
       // Disallow flicking while we're in detailed view
       PropertyChanges { target: intrant.ListView.view; interactive: false }
      }]

      transitions: Transition {
        // Make the state changes smooth
        ParallelAnimation {
          ColorAnimation { property: "color"; duration: 500 }
          NumberAnimation { duration: 300; properties: "detailsOpacity,notDoableOpacity,x,contentY,height,width" }
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
