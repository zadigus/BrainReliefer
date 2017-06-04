#ifndef ENGINECONFIGURATOR_HPP
#define ENGINECONFIGURATOR_HPP

#include <QQmlApplicationEngine>

class QUrl;

class AppConfiguration;

namespace N_Settings {
  class Settings;
}

namespace N_Models {
  class IntrantsModel;
  class ProjectsModel;
}

namespace N_Data {
  class DataManager;
  class SharedIntrant;
  class SharedAction;
}

class QSortFilterProxyModel;

class EngineConfigurator
{
  public:
    EngineConfigurator(QQmlApplicationEngine& a_Engine);

    void setupContext();
    void setupSettings();
    void loadQML(const QUrl& a_MainQml);

  private:
    void setupProxyModels();
    void setupConnections();

  private:
    QQmlApplicationEngine& m_Engine;

    AppConfiguration* m_AppConfiguration;
    N_Settings::Settings* m_Settings;

    N_Models::IntrantsModel* m_NewIntrantsModel;
    N_Models::IntrantsModel* m_ReferencesModel;
    N_Models::IntrantsModel* m_IncubatedModel;
    N_Models::ProjectsModel* m_ProjectsModel;
    QSortFilterProxyModel* m_ActionsModel;
    N_Data::DataManager* m_DataManager;
    N_Data::SharedIntrant* m_SharedIntrant;
    N_Data::SharedAction* m_SharedAction;
};

#endif // ENGINECONFIGURATOR_HPP
