#include <QQmlApplicationEngine>

#include <QApplication>

#include "EngineConfigurator.hpp"

#include "Data/SharedIntrant.hpp"
#include "Data/SharedAction.hpp"
#include "InvalidData/FileSaveDialog.hpp"
#include "Models/IntrantsList.hpp"
#include "Models/ActionsList.hpp"

#include "Logger/Logger.hpp"

#include <QSettings>
#include <QMessageBox>
#include <QFileInfo>
#include <QDir>
#include <QStandardPaths>

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

  QSettings settings;
  settings.setValue("Date", QDate::currentDate().toString()); // this creates the settings folder

  auto myDir(QStandardPaths::standardLocations(QStandardPaths::HomeLocation)[0]);

  QFile file(myDir.append("/test.txt"));

  if(file.exists())
  {
    QMessageBox::information(app.activeWindow(), "File exists", "Yeaaaaah");
  }
  else
  {
    QMessageBox::information(app.activeWindow(), "File doesn't exist", "Noooooo");
  }

  if(file.open(QIODevice::ReadWrite))
  {
    QTextStream stream(&file);
    stream << "hahahaha";

    auto msg(QStandardPaths::standardLocations(QStandardPaths::HomeLocation));
    QMessageBox::warning(app.activeWindow(), "Success", msg.join(","));
  }
  else
  {
    auto msg(QStandardPaths::standardLocations(QStandardPaths::HomeLocation));
    QMessageBox::warning(app.activeWindow(), "Failed writing file", msg.join(","));
  }

  file.close();

//  qInstallMessageHandler(N_Logger::message);

//  app.setQuitOnLastWindowClosed(false);

  registerMetaTypes(); // must be called here because of the static initialization fiasco

  QQmlApplicationEngine engine;

  EngineConfigurator ec(engine);
  ec.setupContext();
  ec.setupProxyModels();
  ec.setupConnections();
  ec.loadQML(QUrl(QStringLiteral("qrc:/qml/main.qml")));

  return app.exec();
}
