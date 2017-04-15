import QtQuick 2.7

State {
  PropertyChanges { target: background; color: "white" }
  PropertyChanges { target: intrant; x: 0; }
  // Fill the entire list area with the detailed view
  PropertyChanges { target: intrant; height: mediator.height }
  // Move the list so that this item is at the top.
  PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y }
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
  StateChangeScript { script: newIntrantsList.intrantOpened() }
}
