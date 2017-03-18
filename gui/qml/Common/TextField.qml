import QtQuick 2.5
import QtQuick.Controls 2.0

TextField {
  height: settings.value("TextField", "height")
  topPadding: settings.value("TextField", "topPadding")
  bottomPadding: settings.value("TextField", "bottomPadding")
  font { pointSize: settings.value("TextField", "font.pointSize") }
  background: FocusRectangle {
    textField: parent
  }
}
