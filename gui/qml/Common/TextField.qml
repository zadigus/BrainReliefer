import QtQuick 2.7
import QtQuick.Controls 2.0

TextField {
  height: mainWindow.scaledValue(settings.value("TextField", "height"))
  topPadding: mainWindow.scaledValue(settings.value("TextField", "topPadding"))
  bottomPadding: mainWindow.scaledValue(settings.value("TextField", "bottomPadding"))
  font.pixelSize: width * settings.value("TextField", "fontRatio")
  background: FocusRectangle {
    textField: parent
  }
}
