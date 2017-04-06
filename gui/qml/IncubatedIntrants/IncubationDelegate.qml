import QtQuick 2.7

import "/js/Global.js" as Global
import "../Common" as Common
import "../IncubatedIntrants/states" as States

Component
{
  Item
  {
    id: intrant

    // Create a property to contain the visibility of the details.
    // We can bind multiple element's opacity to this one property,
    // rather than having a "PropertyChanges" line for each element we
    // want to fade.
    property bool detailsOpacity : false
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
      anchors { right: backgroundRectangle.right; top: backgroundRectangle.top; topMargin: 5; rightMargin: 2 }
      opacity: detailsOpacity
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

      Text {
        text: deadline
        font.pixelSize: 15
        x: 15
        width: parent.width - 2 * x
        wrapMode: Text.Wrap
        opacity: detailsOpacity
      }
    }

    states: [
      States.DetailsState {
        name: "Details"
      }]

    transitions: Transition {
      // Make the state changes smooth
      ParallelAnimation {
        ColorAnimation { property: "color"; duration: 500 }
        NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
      }
    }

  }
}
