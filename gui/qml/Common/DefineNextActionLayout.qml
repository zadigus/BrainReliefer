import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

import "." as Common

ColumnLayout {
  id: myLayout

  property alias actionTitleField: actionTitleField
  property alias postponeBtn: postponeBtn
  property alias postponedActionDatePicker: postponedActionDatePicker
  property alias delegateBtn: delegateBtn
  property alias delegateField: delegateField
  property alias delegatedActionDatePicker: delegatedActionDatePicker
  property alias validateActionBtn: validateActionBtn


  Layout.topMargin: 5
  Layout.alignment: Qt.AlignTop | Qt.AlignCenter

  property string myState

  signal finalizeAction

  spacing: 10
  visible: false

  Common.TextField {
    id: actionTitleField
    focus: false
    placeholderText: qsTr("Enter action title")
    Layout.fillWidth: true
    Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
    Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))
    Binding {
      target: sharedAction
      property: "title"
      value: actionTitleField.text
    }
  }

  ColumnLayout {
    spacing: 5

    Common.ActionButton {
      id: postponeBtn
      buttonText: qsTr("Post-pone")
      Layout.fillWidth: true
      Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
      Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))
      onClicked: {
        myLayout.myState = 'PostponeAction'
      }
    }

    Common.SimpleDatePicker {
      id: postponedActionDatePicker
      visible: false
      onDateValidated: {
        sharedAction.deadline = pickedDate
        myLayout.finalizeAction()
      }
    }

    Common.ActionButton {
      id: delegateBtn
      buttonText: qsTr("Delegate")
      Layout.fillWidth: true
      Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
      Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))
      onClicked: intrant.state = 'DelegateAction'
    }

    Common.TextField {
      id: delegateField
      visible: false
      focus: true
      placeholderText: qsTr("Enter delegate name")
      Layout.fillWidth: true
      Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
      Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))
      Binding {
        target: sharedAction
        property: "delegate"
        value: delegateField.text
      }
    }

    Common.SimpleDatePicker {
      id: delegatedActionDatePicker
      visible: false
      onDateValidated: {
        sharedAction.deadline = pickedDate
        myLayout.finalizeAction()
      }
    }

    Common.ActionButton {
      id: validateActionBtn
      buttonText: qsTr("Done")
      Layout.fillWidth: true
      Layout.leftMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.left"))
      Layout.rightMargin: mainWindow.scaledValue(settings.value("GeneralLayout", "margin.right"))
      onClicked: myLayout.finalizeAction()
    }

  }

}
