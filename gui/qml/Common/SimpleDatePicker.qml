import QtQuick 2.5

import ".."

Column {
  property var calendar
  property var background

  spacing: 10

  property int buttonWidth: background.width
  property int buttonHeight: 25

  onVisibleChanged:
  {
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
    width: 50 // parent.buttonWidth
    visible: false
    function onClicked()
    {
      console.log("SimpleDatePicker::validate")
      var chosenDate
      if(parent.calendar)
      {
        chosenDate = parent.calendar.selectedDate
      }

      parent.onDateValidated(chosenDate);
    }
  }
}
