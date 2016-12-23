import QtQuick 2.5

State {
  PropertyChanges { target: backgroundRectangle; color: "red" }
  // Make details visible
  PropertyChanges { target: intrant; x: 0 }
  // Fill the entire list area with the detailed view
  PropertyChanges { target: intrant; height: newIntrantsList.height + intrant.initialIntrantHeight / 2 }
  // Move the list so that this item is at the top.
  PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
  // Disallow flicking while we're in detailed view
  PropertyChanges { target: intrant.ListView.view; interactive: false }
  // Show close button
  PropertyChanges { target: closeButton; visible: true }
  // Show doable / not doable buttons
  PropertyChanges { target: doableBtnsLayout; visible: true }
  // Show description
  PropertyChanges { target: descriptionData; visible: true }
}
