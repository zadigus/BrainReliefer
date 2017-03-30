import QtQuick 2.7

import ".."

Column {
  property string defaultText
  property var background

  spacing: 10

  property var calendarComponent
  onVisibleChanged: {
    if(calendarComponent)
    {
      validateButton.visible = false
      changeDateButton.visible = true
      defaultDateButton.visible = true
      calendarComponent.destroy()
    }
  }

  property int buttonWidth: background.width / 2
  property int buttonHeight: mainWindow.scaledValue(settings.value("ActionButton", "height"))

  signal dateValidated(date pickedDate)
  signal defaultClicked

  Row {
    spacing: 0
    ActionButton {
      id: defaultDateButton
      buttonText: defaultText
      width: buttonWidth
      visible: true
      onClicked: parent.parent.defaultClicked()
    }
    ActionButton {
      id: changeDateButton
      buttonText: qsTr("Change consultation deadline")
      width: buttonWidth
      visible: true
      onClicked: {
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
    width: background.width
    visible: false
    onClicked: {
      var chosenDate
      if(calendarComponent)
      {
        chosenDate = calendarComponent.selectedDate
      }

      parent.dateValidated(chosenDate)
    }
  }
}
