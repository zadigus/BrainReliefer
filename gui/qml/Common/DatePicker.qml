import QtQuick 2.5

import ".."

Column {
  property string defaultText
  property var background

  spacing: 10

  property var calendarComponent
  onVisibleChanged:
      if(calendarComponent)
      {
        validateButton.visible = false
        changeDateButton.visible = true
        defaultDateButton.visible = true
        calendarComponent.destroy()
      }

  property int buttonWidth: background.width / 2
  property int buttonHeight: 25

  Row {
    spacing: 0
    ActionButton {
      id: defaultDateButton
      buttonText: defaultText
      width: buttonWidth
      height: buttonHeight
      radius: 5
      visible: true
      function onClicked()
      {
        parent.parent.onDefaultClicked()
      }
    }
    ActionButton {
      id: changeDateButton
      buttonText: qsTr("Change consultation deadline")
      width: buttonWidth
      height: buttonHeight
      radius: 5
      visible: true
      function onClicked()
      {
        if(!calendarComponent)
        {
          var component = Qt.createComponent("/Common/Calendar.qml")
          var calendar = component.createObject(parent.parent)
          parent.parent.calendarComponent = calendar
          validateButton.visible = true
          changeDateButton.visible = false
          defaultDateButton.visible = false
        }
      }
    }
  }

  ActionButton {
    id: validateButton
    buttonText: qsTr("Validate")
    width: 350
    height: 50
    radius: 5
    visible: false
    function onClicked()
    {
      var chosenDate
      if(calendarComponent)
      {
        chosenDate = calendarComponent.selectedDate
      }

      parent.onDateValidated(chosenDate);
    }
  }
}
