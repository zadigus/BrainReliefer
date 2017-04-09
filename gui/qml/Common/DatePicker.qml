import QtQuick 2.7
import QtQuick.Layouts 1.1

ColumnLayout {
  id: datePickerLayout

  property string defaultText

  spacing: mainWindow.scaledValue(settings.value("DatePicker", "spacing"))

  signal dateValidated(date pickedDate)
  signal defaultClicked

  onVisibleChanged: {
    validateButton.visible = false
    changeDateButton.visible = true
    defaultDateButton.visible = true
    myCalendar.visible = false
  }

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
        myCalendar.visible = true
        validateButton.visible = true
        changeDateButton.visible = false
        defaultDateButton.visible = false
      }
    }
  }

  Calendar {
    id: myCalendar
    visible: false
    Layout.alignment: Qt.AlignHCenter
  }

  ActionButton {
    id: validateButton
    buttonText: qsTr("Validate")
    Layout.fillWidth: true
    visible: false
    onClicked: datePickerLayout.dateValidated(myCalendar.selectedDate)
  }
}
