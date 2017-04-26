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
      onClicked: {
        if(intrant.state == '') intrant.state = 'Details'
      }
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

      Text {
        id: titleText
        text: title
        elide: Text.ElideRight
        wrapMode: detailsOpacity ? Text.Wrap : Text.NoWrap
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop
        Layout.topMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))
        Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
        Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))
        font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "title.pixelSize"))
      }

      Flickable {
        id: flickableArea

        Layout.topMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "spacing"))
        Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
        Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))
        Layout.fillHeight: true

        width: intrant.width
        // we subtract the bottom margin from the height
        height: intrant.height - titleText.height - mainWindow.scaledValue(settings.value("GeneralLayout", "margin.bottom"))

        contentWidth: width
        contentHeight: contentItem.childrenRect.height
        clip: true
        flickableDirection: Flickable.VerticalFlick

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
            text: description
            textFormat: Text.RichText
            Layout.fillWidth: true
            font.pixelSize: mainWindow.scaledValue(settings.value("Intrant", "description.pixelSize"))
            wrapMode: Text.WordWrap
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
