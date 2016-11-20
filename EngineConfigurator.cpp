#include "EngineConfigurator.hpp"

#include "AppConfiguration.hpp"

#include "Data/DataManager.hpp"
#include "Data/SharedIntrant.hpp"
#include "Data/SharedAction.hpp"

#include "Models/IntrantsList.hpp"

#include "InvalidData/FileSaveDialog.hpp"

#include <QQmlContext>

//----------------------------------------------------------------------------------------------
EngineConfigurator::EngineConfigurator(QQmlApplicationEngine& a_Engine)
  : m_Engine(a_Engine)
  , m_AppConfiguration(new AppConfiguration)
  , m_NewIntrantsModel(new N_Models::IntrantsList)
  , m_ReferencesModel(new N_Models::IntrantsList)
  , m_IncubatedModel(new N_Models::IntrantsList)
  , m_DataManager(new N_Data::DataManager)
  , m_SharedIntrant(new N_Data::SharedIntrant)
  , m_SharedAction(new N_Data::SharedAction)
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
  context->setContextProperty("referencesModel", m_ReferencesModel);
  context->setContextProperty("incubatedModel", m_IncubatedModel);
  context->setContextProperty("sharedIntrant", m_SharedIntrant);
  context->setContextProperty("sharedAction", m_SharedAction);
}

//----------------------------------------------------------------------------------------------
void EngineConfigurator::registerMetaTypes ()
{
  qmlRegisterType<FileSaveDialog>("InvalidData", 1, 0, "FileSaveDialog");
  qmlRegisterType<N_Models::IntrantsList>("MyDataManagement", 1, 0, "IntrantsList");
  qmlRegisterType<N_Data::SharedIntrant>("MyDataManagement", 1, 0, "SharedIntrant");
  qmlRegisterType<N_Data::SharedAction>("MyDataManagement", 1, 0, "SharedAction");
}

//----------------------------------------------------------------------------------------------
void EngineConfigurator::loadQML(const QUrl& a_MainQml)
{
  m_Engine.load(a_MainQml);
}

//----------------------------------------------------------------------------------------------
void EngineConfigurator::setupConnections()
{
  QObject::connect(m_DataManager, SIGNAL(newIntrantsLoaded(QString)), m_NewIntrantsModel, SLOT(loadDataFromFile(QString)));
  QObject::connect(m_DataManager, SIGNAL(referencesLoaded(QString)), m_ReferencesModel, SLOT(loadDataFromFile(QString)));
  QObject::connect(m_DataManager, SIGNAL(incubatedLoaded(QString)), m_IncubatedModel, SLOT(loadDataFromFile(QString)));
}
