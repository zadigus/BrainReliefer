#include "EngineConfigurator.hpp"

#include "AppConfiguration.hpp"

#include "Data/DataManager.hpp"

#include "Models/NewIntrants.hpp"

#include "InvalidData/FileSaveDialog.hpp"

#include <QQmlContext>

//----------------------------------------------------------------------------------------------
EngineConfigurator::EngineConfigurator(QQmlApplicationEngine& a_Engine)
  : m_Engine(a_Engine)
  , m_AppConfiguration(new AppConfiguration())
  , m_NewIntrantsModel(new N_Models::NewIntrants())
  , m_DataManager(new N_Data::DataManager())
{

}

//----------------------------------------------------------------------------------------------
void EngineConfigurator::setupContext()
{
  m_AppConfiguration->setup();

  QQmlContext* context(m_Engine.rootContext());
  context->setContextProperty("appConfiguration", m_AppConfiguration);
  context->setContextProperty("dataManager", m_DataManager);
  context->setContextProperty("newIntrantsModel", m_NewIntrantsModel);
}

//----------------------------------------------------------------------------------------------
void EngineConfigurator::registerMetaTypes ()
{
  qmlRegisterType<FileSaveDialog>("InvalidData", 1, 0, "FileSaveDialog");
}

//----------------------------------------------------------------------------------------------
void EngineConfigurator::loadQML(const QUrl& a_MainQml)
{
  m_Engine.load(a_MainQml);
}

//----------------------------------------------------------------------------------------------
void EngineConfigurator::setupConnections()
{
  QObject::connect(m_DataManager, SIGNAL(newIntrantsLoaded(QString)), m_NewIntrantsModel, SLOT(reload(QString)));
}
