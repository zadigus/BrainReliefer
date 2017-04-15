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
  // Show state page layout
  PropertyChanges { target: defineNextActionLayout; visible: true }
  PropertyChanges { target: defineNextActionLayout.delegatedActionDatePicker; visible: true }
  PropertyChanges { target: defineNextActionLayout.postponeBtn; visible: false}
  PropertyChanges { target: defineNextActionLayout.validateActionBtn; visible: false}
  PropertyChanges { target: defineNextActionLayout.delegateField; visible: true }
  StateChangeScript { script: defineNextActionLayout.delegatedActionDatePicker.displayCalendar() }
  StateChangeScript { script: newIntrantsList.intrantOpened() }
}
