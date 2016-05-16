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

  class DataFilesManager : public Singleton<DataFilesManager>
  {
    friend class Singleton<DataFilesManager>;

    public:
      QString getNewIntrantsFile() const;

    private:
      DataFilesManager();

      void initFileNames();

    private:
      QUrl m_DataXsd;
      QFile m_DataXmlFile;
      QString m_NewIntrantsFile;
      QString m_IncubatedFile;
      QString m_ReferencesFile;
      QString m_ProjectsFile;
      QString m_NextActionsFile;
      QString m_AgendaFile;

      std::function<std::unique_ptr<Data>(const std::string&)> m_DataCtor;

      std::unique_ptr<Data> m_Data;
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  inline QString DataFilesManager::getNewIntrantsFile() const
  {
    return m_NewIntrantsFile;
  }

  //----------------------------------------------------------------------------------
  // non-member method(s)
  //----------------------------------------------------------------------------------

}

#endif // DATA_DATAFILESMANAGER_HPP
