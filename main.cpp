#include <QQmlApplicationEngine>

#include <QApplication>

#include "EngineConfigurator.hpp"

#include "Data/SharedIntrant.hpp"
#include "Data/SharedAction.hpp"
#include "InvalidData/FileSaveDialog.hpp"
#include "Models/IntrantsList.hpp"
#include "Models/ActionsList.hpp"

#include "Logger/Logger.hpp"

//----------------------------------------------------------------------------------------------
void registerMetaTypes ()
{
  qmlRegisterType<FileSaveDialog>("InvalidData", 1, 0, "FileSaveDialog");
  qmlRegisterType<N_Models::IntrantsList>("MyDataManagement", 1, 0, "IntrantsList");
  qmlRegisterType<N_Models::ActionsList>("MyDataManagement", 1, 0, "ActionsList");
  qmlRegisterType<N_Data::SharedIntrant>("MyDataManagement", 1, 0, "SharedIntrant");
  qmlRegisterType<N_Data::SharedAction>("MyDataManagement", 1, 0, "SharedAction");
}

//----------------------------------------------------------------------------------------------
int main(int argc, char *argv[])
{
  QApplication app(argc, argv);

  QCoreApplication::setOrganizationName("LM");
  QCoreApplication::setOrganizationDomain("LM.com");
  QCoreApplication::setApplicationName("BrainReliefer");

//  app.setQuitOnLastWindowClosed(false);

  registerMetaTypes(); // must be called here because of the static initialization fiasco

  QQmlApplicationEngine engine;

  EngineConfigurator ec(engine);
  ec.setupContext();
  ec.setupProxyModels();
  ec.setupConnections();
  ec.loadQML(QUrl(QStringLiteral("qrc:/qml/main.qml")));

  qInstallMessageHandler(N_Logger::message);

  return app.exec();
}
