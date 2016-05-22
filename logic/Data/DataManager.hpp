#ifndef DATA_DATAFILESMANAGER_HPP
#define DATA_DATAFILESMANAGER_HPP

#include "Singleton.hpp"

#include "Data/Data.hpp"

#include <QUrl>
#include <QFile>
#include <QString>

#include <functional>
#include <memory>

namespace N_Data {
  class IntrantList;
}

namespace N_Data {

  class DataManager : public Singleton<DataManager>
  {
    friend class Singleton<DataManager>;

    public:
      std::unique_ptr<N_Data::IntrantList> getNewIntrantsData() const;

      void load(const QString& a_PathToFile);

    private:
      DataManager();

    private:
      QUrl m_DataXsd;
      QUrl m_IntrantListXsd;

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
