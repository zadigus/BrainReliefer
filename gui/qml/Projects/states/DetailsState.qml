import QtQuick 2.7

State {
  PropertyChanges { target: background; color: "white" }
  // Make details visible
  PropertyChanges { target: intrant; x: 0 }
  // Fill the entire list area with the detailed view
  PropertyChanges { target: intrant; height: mediator.height }
  // Move the list so that this item is at the top.
  PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y }
  // Disallow flicking while we're in detailed view
  PropertyChanges { target: intrant.ListView.view; interactive: false }
  StateChangeScript { script: actionsModel.setFilterFixedString(title) }
  PropertyChanges { target: closeButton; visible: true }
  PropertyChanges { target: titleField; visible: true }
  PropertyChanges { target: descriptionField; visible: true }
  PropertyChanges { target: deadlineField; visible: true }
  PropertyChanges { target: actionsList; visible: true }
  PropertyChanges { target: addNewActionBtn; visible: true }
}
