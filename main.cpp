#include "EngineConfigurator.hpp"

#include "Data/SharedIntrant.hpp"
#include "Data/SharedAction.hpp"
#include "Models/IntrantsModel.hpp"
#include "Models/ActionsModel.hpp"

#include "Logger/Logger.hpp"

#include <QQmlApplicationEngine>

#include <QApplication>

//----------------------------------------------------------------------------------------------
void registerMetaTypes ()
{
  qmlRegisterType<N_Models::IntrantsModel>("MyDataManagement", 1, 0, "IntrantsList");
  qmlRegisterType<N_Models::ActionsModel>("MyDataManagement", 1, 0, "ActionsList");
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

  N_Logger::resetLogFile();
  qInstallMessageHandler(N_Logger::message); // if called too early, this doesn't work (--> the application hangs forever)

  ec.setupContext();
  ec.setupSettings(); // TODO: put that into setupContext
  ec.loadQML(QUrl(QStringLiteral("qrc:/qml/main.qml")));

  return app.exec();
}
