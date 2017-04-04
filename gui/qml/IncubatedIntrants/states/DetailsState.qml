import QtQuick 2.7

State {
  PropertyChanges { target: background; color: "red" }
  // Make details visible
  PropertyChanges { target: intrant; detailsOpacity: true; x: 0 }
  // Fill the entire list area with the detailed view
  PropertyChanges { target: intrant; height: incubationlist.height + intrant.initialIntrantHeight / 2 }
  // Move the list so that this item is at the top.
  PropertyChanges { target: intrant.ListView.view; explicit: true; contentY: intrant.y + intrant.initialIntrantHeight / 2 }
  // Disallow flicking while we're in detailed view
  PropertyChanges { target: intrant.ListView.view; interactive: false }
}
