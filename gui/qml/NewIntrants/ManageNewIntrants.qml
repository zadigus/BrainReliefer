import QtQuick 2.0

import "/js/Global.js" as Global
import ".."

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
      property real detailsOpacity : 0

      width: parent.width
      height: 40

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
        onClicked: intrant.state = 'Details'
      }

      // Lay out the page: title, description, ...
      // Note that elements that should not be visible in the list
      // mode have their opacity set to detailsOpacity.
      Column {
        id: topLayout
        x: 10; y: 10;
        height: parent.height;
        width: parent.width
        spacing: 10

        Text {
          text: title
          font.pixelSize: 24
        }

        Text {
          text: description
          textFormat: Text.RichText
          font.pixelSize: 15
          width: parent.width - 4
          wrapMode: Text.Wrap
          opacity: detailsOpacity
        }
      }

//      Row {
//        anchors.bottom: intrant.bottom
//        opacity: detailsOpacity
//        spacing: 10
//        ActionButton {
//          buttonText: qsTr("Doable")
//          width: background.width
//          height: 25
//        }
//        ActionButton {
//          buttonText: qsTr("Not Doable")
//          width: 50
//          height: 25
//        }
//      }

      // A button to close the detailed view, i.e. set the state back to default ('').
      TextButton {
        y: 10
        anchors { right: background.right; rightMargin: 10 }
        opacity: intrant.detailsOpacity
        text: "Close"

        onClicked: intrant.state = '';
      }

      states: State {
        name: "Details"

        PropertyChanges { target: background; color: "red" }
        // Make details visible
        PropertyChanges { target: intrant; detailsOpacity: 1; x: 0 }
        // Fill the entire list area with the detailed view
        PropertyChanges { target: intrant; height: list.height }

        // Move the list so that this item is at the top.
        PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: recipe.y }

        // Disallow flicking while we're in detailed view
        PropertyChanges { target: intrant.ListView.view; interactive: false }
      }

      transitions: Transition {
        // Make the state changes smooth
        ParallelAnimation {
          ColorAnimation { property: "color"; duration: 500 }
          NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
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
