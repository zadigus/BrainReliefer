import QtQuick 2.7
import QtQuick.Layouts 1.1

import ".."

ColumnLayout {
  id: datePickerLayout

  property string defaultText

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

  property int buttonHeight: mainWindow.scaledValue(settings.value("ActionButton", "height"))

  signal dateValidated(date pickedDate)
  signal defaultClicked

  RowLayout {
    spacing: 2
    ActionButton {
      id: defaultDateButton
      buttonText: defaultText
      Layout.fillWidth: true
      visible: true
      onClicked: datePickerLayout.defaultClicked()
    }
    ActionButton {
      id: changeDateButton
      buttonText: qsTr("Change consultation deadline")
      Layout.fillWidth: true
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
    Layout.fillWidth: true
    visible: false
    onClicked: {
      var chosenDate
      if(calendarComponent)
      {
        chosenDate = calendarComponent.selectedDate
      }

      datePickerLayout.dateValidated(chosenDate)
    }
  }
}
