import QtQuick 2.7

Rectangle {
  x: mainWindow.scaledValue(settings.value("BackgroundRectangle", "leftPadding"))
  y: mainWindow.scaledValue(settings.value("BackgroundRectangle", "topPadding"));
  width: parent.width - 2*x; height: parent.height - 2*y
  color: settings.value("BackgroundRectangle", "color")
  border.color: settings.value("BackgroundRectangle", "border.color")
  radius: 5
}
