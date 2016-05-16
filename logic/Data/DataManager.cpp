#include "DataManager.hpp"

#include "Data/DataManagerHelper.hpp"

#include <QFileInfo>

#include <QDebug>

namespace N_Data {

  //----------------------------------------------------------------------------------------------
  DataFilesManager::DataFilesManager()
    : m_DataXsd(QStringLiteral("qrc:/xsd/Data.xsd"))
    , m_DataXmlFile("config/Data.xml")
    , m_DataCtor([] (const std::string& a_FileName) { return Data_(a_FileName); })
  {
    m_Data = N_DataManagerHelper::getParsedXML<Data>(m_DataXmlFile, m_DataXsd, m_DataCtor);
    initFileNames();
  }

  //----------------------------------------------------------------------------------------------
  void DataFilesManager::initFileNames()
  {
    Data::DataPath_const_iterator it(m_Data->DataPath().begin());
    while(it != m_Data->DataPath().end())
    {
      // TODO: if the file is not listed in the XML structure, then create it
      QString file(QString::fromStdString(*it));
      if((*it).name() == "NewIntrantItems")
      {
        m_NewIntrantsFile = file;
      }
      else if((*it).name() == "IncubatedItems")
      {
        m_IncubatedFile = file;
      }
      else if((*it).name() == "ReferenceItems")
      {
        m_ReferencesFile = file;
      }
      else if((*it).name() == "ProjectItems")
      {
        m_ProjectsFile = file;
      }
      else if((*it).name() == "NextActionItems")
      {
        m_NextActionsFile = file;
      }
      else if((*it).name() == "AgendaItems")
      {
        m_AgendaFile = file;
      }

      ++it;
    }
  }

}
