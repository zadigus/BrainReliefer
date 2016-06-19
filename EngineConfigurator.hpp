#ifndef ENGINECONFIGURATOR_HPP
#define ENGINECONFIGURATOR_HPP

#include <QQmlApplicationEngine>

class QUrl;

class AppConfiguration;

namespace N_Models {
  class NewIntrants;
}

namespace N_Data {
  class DataManager;
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

    N_Models::NewIntrants* m_NewIntrantsModel;
    N_Data::DataManager* m_DataManager;
};

#endif // ENGINECONFIGURATOR_HPP