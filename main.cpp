#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>

#include "Data/DataManager.hpp"

#include "Models/NewIntrants.hpp"

using namespace N_Data;
using namespace N_Models;

int main(int argc, char *argv[])
{
  DataManager::getInstance().load("config/Data.xml");
  NewIntrants newIntrantsModel;

  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;
  engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

  QQmlContext* context(engine.rootContext());
  context->setContextProperty("newIntrantsModel", &newIntrantsModel);

  return app.exec();
}
