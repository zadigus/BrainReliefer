#include "EngineConfigurator.hpp"

#include "AppConfiguration.hpp"

#include "Data/DataManager.hpp"
#include "Data/SharedIntrant.hpp"
#include "Data/SharedAction.hpp"

#include "Models/IntrantsModel.hpp"
#include "Models/ActionsModel.hpp"

#include "Settings/Settings.hpp"

#include <QQmlContext>
#include <QSortFilterProxyModel>

//----------------------------------------------------------------------------------------------
EngineConfigurator::EngineConfigurator(QQmlApplicationEngine& a_Engine)
  : m_Engine(a_Engine)
  , m_AppConfiguration(new AppConfiguration)
  , m_Settings(Q_NULLPTR) // this needs to be initialized after the call to loadQML
  , m_NewIntrantsModel(new N_Models::IntrantsModel)
  , m_ReferencesModel(new N_Models::IntrantsModel)
  , m_IncubatedModel(new N_Models::IntrantsModel)
  , m_ProjectsModel(new N_Models::IntrantsModel)
  , m_ActionsModel(new QSortFilterProxyModel)
  , m_DataManager(new N_Data::DataManager)
  , m_SharedIntrant(new N_Data::SharedIntrant)
  , m_SharedAction(new N_Data::SharedAction)
{ }

//----------------------------------------------------------------------------------------------
void EngineConfigurator::setupSettings()
{
  m_Settings = new N_Settings::Settings;

  QQmlContext* context(m_Engine.rootContext());
  context->setContextProperty("settings", m_Settings);
}

//----------------------------------------------------------------------------------------------
void EngineConfigurator::setupProxyModels()
{
  N_Models::ActionsModel* model(new N_Models::ActionsModel);
  m_ActionsModel->setSourceModel(model);
  m_ActionsModel->setFilterRole(N_Models::ActionsModel::ProjectRole);
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
  context->setContextProperty("projectsModel", m_ProjectsModel);
  context->setContextProperty("actionsModel", m_ActionsModel);
  context->setContextProperty("sharedIntrant", m_SharedIntrant);
  context->setContextProperty("sharedAction", m_SharedAction);

  setupProxyModels();
  setupConnections();
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
  QObject::connect(m_DataManager, SIGNAL(projectsLoaded(QString)), m_ProjectsModel, SLOT(loadDataFromFile(QString)));
  QObject::connect(m_DataManager, SIGNAL(projectsLoaded(QString)), m_ActionsModel->sourceModel(), SLOT(loadDataFromFile(QString))); // sourceModel() really necessary because without it we connect to the proxy model
  QObject::connect(m_ProjectsModel, SIGNAL(intrantAdded(int)), m_ActionsModel->sourceModel(), SLOT(onIntrantAdded(int)));
}
