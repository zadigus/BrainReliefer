import QtQuick 2.5

import "/js/Global.js" as Global
import ".."
import "../Common"

State {
  property var mySubject

  PropertyChanges { target: background; color: "red" }
  // Make details visible
  PropertyChanges { target: mySubject; detailsOpacity: true; x: 0 }
  // Fill the entire list area with the detailed view
  PropertyChanges { target: mySubject; height: referencesList.height + mySubject.initialIntrantHeight / 2 }
  // Move the list so that this item is at the top.
  PropertyChanges { target: mySubject.ListView.view; explicit: true; contentY: mySubject.y + mySubject.initialIntrantHeight / 2 }
  // Disallow flicking while we're in detailed view
  PropertyChanges { target: mySubject.ListView.view; interactive: false }
}
