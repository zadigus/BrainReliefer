#ifndef DATA_DATAFILESMANAGER_HPP
#define DATA_DATAFILESMANAGER_HPP

#include "Data/Data.hpp"

#include <QUrl>
#include <QFile>
#include <QString>
#include <QObject>

#include <functional>
#include <memory>

namespace N_Data {
  class IntrantList;
}

namespace N_Data {

  class DataManager : public QObject
  {
    Q_OBJECT

    public:
      DataManager(QObject* a_Parent = NULL);
      virtual ~DataManager();

      Q_INVOKABLE void load(const QString& a_PathToFile);

    private:
      void emitNewIntrantsLoaded();

    signals:
      void invalidDataFile();

      void newIntrantsLoaded(const QString& a_FileName);

    private:
      QUrl m_DataXsd;
      QFile m_DataXmlFile;

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
