#ifndef DATA_DATAFILESMANAGER_HPP
#define DATA_DATAFILESMANAGER_HPP

#include "core/Global.hpp"

#include "Data/Data.hpp"

#include <QUrl>
#include <QFile>
#include <QString>
#include <QObject>

namespace N_Data {
  class IntrantList;
  class SharedIntrant;
  class SharedAction;
}

namespace N_Models {
  class IntrantsList;
}

namespace N_Data {

  class DataManager : public QObject
  {
    Q_OBJECT

    public:
      DataManager(QObject* a_Parent = NULL);
      virtual ~DataManager();

      Q_INVOKABLE void load(const QUrl& a_PathToFile);

      Q_INVOKABLE void addAction(N_Models::IntrantsList* a_SrcModel, N_Data::SharedAction* a_Action, int a_Idx);

      Q_INVOKABLE void addIntrant(N_Models::IntrantsList* a_SrcModel, N_Data::SharedIntrant* a_Intrant);
      Q_INVOKABLE void removeIntrant(N_Models::IntrantsList* a_SrcModel, int a_Idx);
      Q_INVOKABLE void transferIntrant(N_Models::IntrantsList* a_SrcModel, N_Models::IntrantsList* a_DestModel, int a_Idx);

    private:
      void emitLoaded(const std::string& a_ItemName, const std::function<void(const QString&)>& a_EmitCallback);

    signals:
      void invalidDataFile();

      void newIntrantsLoaded(const QString& a_FileName);
      void referencesLoaded(const QString& a_FileName);
      void incubatedLoaded(const QString& a_FileName);
      void projectsLoaded(const QString& a_FileName);

    private:
      QUrl m_DataXsd;

      std::unique_ptr<Data> m_Data;
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------
  // non-member method(s)
  //----------------------------------------------------------------------------------

}

#endif // DATA_DATAFILESMANAGER_HPP
