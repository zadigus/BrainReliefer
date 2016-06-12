#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDebug>

#include "EngineConfigurator.hpp"

using namespace N_Data;
using namespace N_Models;

int main(int argc, char *argv[])
{
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;

  EngineConfigurator ec(engine);
  ec.setupContext();
  ec.setupConnections();
  ec.loadQML(QUrl(QStringLiteral("qrc:/qml/main.qml")));

  return app.exec();
}
