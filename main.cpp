#include <QQmlApplicationEngine>

#include <QApplication>

#include <QDebug>

#include "EngineConfigurator.hpp"

using namespace N_Data;
using namespace N_Models;

int main(int argc, char *argv[])
{
  QApplication app(argc, argv);

//  app.setQuitOnLastWindowClosed(false);

  QQmlApplicationEngine engine;

  EngineConfigurator ec(engine);
  ec.setupContext();
  ec.registerMetaTypes();
  ec.setupConnections();
  ec.loadQML(QUrl(QStringLiteral("qrc:/qml/main.qml")));

  return app.exec();
}
