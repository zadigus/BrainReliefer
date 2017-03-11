#ifndef DATA_DATAFILESMANAGER_HPP
#define DATA_DATAFILESMANAGER_HPP

#include "core/Global.hpp"

#include <QString>
#include <QObject>
#include <QMap>

namespace N_Data {
  class SharedIntrant;
  class SharedAction;
}

namespace N_Models {
  class IntrantsModel;
}

class QDir;

namespace N_Data {

  class DataManager : public QObject
  {
    Q_OBJECT

    public:
      typedef QMap<QString, std::function<void(const QString&)> > T_LoadSignals;

    public:
      DataManager(QObject* a_Parent = NULL);
      virtual ~DataManager();

      Q_INVOKABLE void load(const QUrl& a_PathToDir);

      Q_INVOKABLE void addAction(N_Models::IntrantsModel* a_SrcModel, N_Data::SharedAction* a_Action, int a_Idx);

      Q_INVOKABLE void addIntrant(N_Models::IntrantsModel* a_SrcModel, N_Data::SharedIntrant* a_Intrant);
      Q_INVOKABLE void removeIntrant(N_Models::IntrantsModel* a_SrcModel, int a_Idx);
      Q_INVOKABLE void transferIntrant(N_Models::IntrantsModel* a_SrcModel, N_Models::IntrantsModel* a_DestModel, int a_Idx);

    private:
      void loadExistingFiles(const QDir& a_DataDir);
      void createMissingFiles(const QDir& a_DataDir);

    signals:
      void invalidDataFile();

      void newIntrantsLoaded(const QString& a_FileName);
      void referencesLoaded(const QString& a_FileName);
      void incubatedLoaded(const QString& a_FileName);
      void projectsLoaded(const QString& a_FileName);

    private:
      T_LoadSignals m_LoadSignals;
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------
  // non-member method(s)
  //----------------------------------------------------------------------------------
  DataManager::T_LoadSignals loadSignals(DataManager* a_DataManager);
}

#endif // DATA_DATAFILESMANAGER_HPP
