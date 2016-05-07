#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QFileInfo>

#include "Data/Data.hpp"
#include "Data/DataValidator.hpp"

#include "Models/NewIntrants.hpp"

using namespace N_Data;
using namespace N_Models;

int main(int argc, char *argv[])
{
  QFile dataXsdFile("config/Data.xsd");
  QFile dataXmlFile("config/Data.xml");

  if(!N_DataValidator::isXMLDataValid(dataXsdFile, dataXmlFile))
  {
    qDebug() << "invalid XML file";
    return 0;
  }

  QFileInfo info(dataXmlFile);
  std::unique_ptr<Data> data(Data_(info.absoluteFilePath().toStdString()));
  Data::DataPath_sequence dataPaths = data->DataPath();

  qDebug() << "number of paths = " << dataPaths.size();

  Data::DataPath_const_iterator it(std::find_if(dataPaths.begin(), dataPaths.end(),
                                                [] (const DataPath& a_Path) -> bool
                                                {
                                                  return a_Path.name() == "NewIntrantItems";
                                                }));
  if(it == dataPaths.end())
  {
    qFatal("Incomplete file: no NewIntrantsItems found"); // TODO: if the entry doesn't exist, then create it after the user has saved the data
  }

  QString pathToNewIntrantsXml(QString::fromStdString(*it));
  QString pathToNewIntrantsXsd(QString::fromStdString("config/IntrantList.xsd"));

  NewIntrants newIntrantsModel(pathToNewIntrantsXml, pathToNewIntrantsXsd);

  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

  QQmlContext* context(engine.rootContext());
  context->setContextProperty("newIntrantsModel", &newIntrantsModel);

  return app.exec();
}
