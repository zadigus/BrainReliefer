import QtQuick 2.7
import QtQuick.Layouts 1.1

import ".."

ColumnLayout {
  property var calendar

  spacing: 10

  signal dateValidated(date pickedDate)

  onVisibleChanged: {
    if(calendar)
    {
      validateButton.visible = false
      calendar.destroy()
    }
  }

  function displayCalendar()
  {
    if(calendar)
    {
      calendar.destroy()
    }

    var component = Qt.createComponent("/Common/Calendar.qml")
    calendar = component.createObject(parent)
    validateButton.visible = true
  }

  ActionButton {
    id: validateButton
    buttonText: qsTr("Validate")
    Layout.fillWidth: true
    visible: false
    onClicked: {
      var chosenDate
      if(parent.calendar)
      {
        chosenDate = parent.calendar.selectedDate
      }

      parent.dateValidated(chosenDate);
    }
  }
}
