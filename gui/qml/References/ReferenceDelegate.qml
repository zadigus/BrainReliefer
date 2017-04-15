import QtQuick 2.7
import QtQuick.Layouts 1.1

import "/js/Global.js" as Global
import "../Common" as Common
import "states" as States

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

    width: parent.width
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
      opacity: detailsOpacity
      onClicked: intrant.state = '';
    }

    ColumnLayout {

      anchors.fill: parent

      /*Flickable {
        //      anchors.fill: parent
        //          width: 500; height: 500;
        Layout.fillHeight: true
        Layout.fillWidth: true
        contentWidth: contentItem.childrenRect.width
        contentHeight: contentItem.childrenRect.width
        clip: true
        flickableDirection: Flickable.VerticalFlick

        Rectangle {
          anchors.fill: parent
          border.color: "red"
          border.width: 5
        }*/

        ColumnLayout {
          spacing: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))

          Layout.alignment: Qt.AlignTop
          Layout.topMargin: spacing
          Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
          Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))

          Text {
            text: title
            elide: Text.ElideRight
            wrapMode: detailsOpacity ? Text.Wrap : Text.NoWrap
            Layout.fillWidth: true
            font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "title.pixelSize"))
          }

          Text {
            text: description
            textFormat: Text.RichText
            Layout.fillWidth: true
            font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "description.pixelSize"))
            wrapMode: Text.Wrap
            opacity: detailsOpacity
          }

          Text {
            text: deadline
            Layout.fillWidth: true
            font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "deadline.pixelSize"))
            wrapMode: Text.Wrap
            opacity: detailsOpacity
          }
        }
//      }
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
