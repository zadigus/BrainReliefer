import QtQuick 2.7
import QtQuick.Layouts 1.1

import "/js/Global.js" as Global
import ".."
import "../Common" as Common
import "../Projects/states" as States

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
      anchors.right: background.right
      opacity: detailsOpacity
      onClicked: intrant.state = '';
    }

    // Lay out the page: title, description, ...
    // Note that elements that should not be visible in the list
    // mode have their opacity set to detailsOpacity.
    ColumnLayout {
      id: topLayout

      Layout.alignment: Qt.AlignTop
      Layout.topMargin: 10
      Layout.leftMargin: 10
      Layout.rightMargin: 10

      anchors.fill: parent
      spacing: 10

      Text {
        text: title
        elide: Text.ElideRight
        wrapMode: detailsOpacity ? Text.Wrap : Text.NoWrap
        Layout.fillWidth: true
        font.pixelSize: mainWindow.scaledValue(settings.value("Projects", "title.pixelSize"))
      }

      Text {
        text: description
        textFormat: Text.RichText
        font.pixelSize: mainWindow.scaledValue(settings.value("Projects", "description.pixelSize"))
        Layout.fillWidth: true
        wrapMode: Text.Wrap
        opacity: detailsOpacity
      }

      Text {
        text: deadline
        font.pixelSize: mainWindow.scaledValue(settings.value("Projects", "deadline.pixelSize"))
        Layout.fillWidth: true
        wrapMode: Text.Wrap
        opacity: detailsOpacity
      }

      ListView
      {
        id: actionsList

        Layout.fillWidth: true
        Layout.fillHeight: true

        orientation: ListView.Vertical

        model: actionsModel
        delegate: ActionDelegate {}

        opacity: detailsOpacity
      }

      Common.AddButton {
        id: addNewActionBtn
        width: mainWindow.scaledValue(settings.value("Projects", "addBtnSize"))
        anchors { bottom: actionsList.bottom; horizontalCenter: actionsList.horizontalCenter }
        opacity: detailsOpacity
        onClicked: handle("projects.addAction")
      }

    }

    states: [
      States.DetailsState {
        name: "Details"
        mySubject: intrant
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
