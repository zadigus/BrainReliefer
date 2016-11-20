#ifndef ENGINECONFIGURATOR_HPP
#define ENGINECONFIGURATOR_HPP

#include <QQmlApplicationEngine>

class QUrl;

class AppConfiguration;

namespace N_Models {
  class IntrantsList;
}

namespace N_Data {
  class DataManager;
  class SharedIntrant;
  class SharedAction;
}

class EngineConfigurator
{
  public:
    EngineConfigurator(QQmlApplicationEngine& a_Engine);

    void setupContext();
    void registerMetaTypes();
    void loadQML(const QUrl& a_MainQml);
    void setupConnections();

  private:
    QQmlApplicationEngine& m_Engine;

    AppConfiguration* m_AppConfiguration;

    N_Models::IntrantsList* m_NewIntrantsModel;
    N_Models::IntrantsList* m_ReferencesModel;
    N_Models::IntrantsList* m_IncubatedModel;
    N_Data::DataManager* m_DataManager;
    N_Data::SharedIntrant* m_SharedIntrant;
    N_Data::SharedAction* m_SharedAction;
};

#endif // ENGINECONFIGURATOR_HPP
