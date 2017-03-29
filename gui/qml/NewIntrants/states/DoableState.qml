import QtQuick 2.5

State {
  PropertyChanges { target: backgroundRectangle; color: "white" }
  PropertyChanges { target: intrant; x: 0; }
  // Fill the entire list area with the "doable" view
  PropertyChanges { target: intrant; height: newIntrantsList.height + intrant.initialIntrantHeight / 2 }
  // Move the list so that this item is at the top.
  PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
  // Disallow flicking while we're in detailed view
  PropertyChanges { target: intrant.ListView.view; interactive: false }
  // Show close button
  PropertyChanges { target: closeButton; visible: true }
  // Show doable page layout
  PropertyChanges { target: doableLayout; visible: true }
  PropertyChanges { target: actionList; visible: true }
  StateChangeScript { script: newIntrantsList.intrantOpened() }
}
