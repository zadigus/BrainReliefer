#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QFileInfo>

#include "Data/Data.hpp"
#include "Data/DataValidator.hpp"

using namespace N_Data;

int main(int argc, char *argv[])
{
  QFile xsdFile("Data/Data.xsd");
  QFile xmlFile("Data/Data.xml");

  if(!N_DataValidator::isXMLDataValid(xsdFile, xmlFile))
  {
    qDebug() << "invalid XML file";
    return 0;
  }

  QFileInfo info(xmlFile);
  std::unique_ptr<Data> data(Data_(info.absoluteFilePath().toStdString()));
  Data::DataPath_sequence dataPaths = data->DataPath();

  qDebug() << "number of paths = " << dataPaths.size();

  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

  return app.exec();
}
