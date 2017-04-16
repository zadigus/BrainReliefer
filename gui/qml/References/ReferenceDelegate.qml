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
      z: 10
    }

    ColumnLayout {

      anchors.fill: parent

      Flickable {
        id: flickableArea

        Layout.alignment: Qt.AlignTop
        Layout.topMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))
        Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
        Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))

        width: intrant.width
        height: intrant.height
        contentWidth: width
        contentHeight: contentItem.childrenRect.width
        clip: true
        flickableDirection: Flickable.VerticalFlick

        ColumnLayout {
          spacing: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))

          Text {
            text: title
            elide: Text.ElideRight
            wrapMode: detailsOpacity ? Text.Wrap : Text.NoWrap
            Layout.fillWidth: true
            font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "title.pixelSize"))

            MouseArea {
              anchors.fill: parent
              onClicked: {
                console.log("wouaaaaaaaaaaaaaaaaaaaaaaaaaah")
                if(intrant.state == '') intrant.state = 'Details'
              }
            }
          }

          Text {
            text: description
            elide: Text.ElideRight
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
      }
    }

    states: [
      State {
        name: ''
        PropertyChanges { target: flickableArea; contentY: 0 }
      }, States.DetailsState {
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
