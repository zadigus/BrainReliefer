import QtQuick 2.7
import QtQuick.Layouts 1.1

ColumnLayout {
  spacing: 10

  signal dateValidated(date pickedDate)

  onVisibleChanged: {
    validateButton.visible = false
    myCalendar.visible = false
  }

  function displayCalendar()
  {
    myCalendar.visible = true
    validateButton.visible = true
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
    onClicked: parent.dateValidated(myCalendar.selectedDate)
  }
}
