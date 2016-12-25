#include <QQmlApplicationEngine>

#include <QApplication>

#include "EngineConfigurator.hpp"

// a comment to test git
int main(int argc, char *argv[])
{
  QApplication app(argc, argv);

//  app.setQuitOnLastWindowClosed(false);

  QQmlApplicationEngine engine;

  EngineConfigurator ec(engine);
  ec.setupContext();
  ec.setupProxyModels();
  ec.registerMetaTypes();
  ec.setupConnections();
  ec.loadQML(QUrl(QStringLiteral("qrc:/qml/main.qml")));

  return app.exec();
}
