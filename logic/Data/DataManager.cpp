#include "DataManager.hpp"

#include "Data/DataManagerHelper.hpp"
#include "Data/DataExceptions.hpp"
#include "Data/DataConstants.hpp"
#include "Data/Data.hpp"
#include "Data/IntrantList.hpp"

#include <iostream>

#include <QFile>
#include <QDir>

#include <QDebug>

namespace N_Data {

  //----------------------------------------------------------------------------------------------
  DataManager::DataManager(QObject* a_Parent)
    : QObject(a_Parent)
    , m_DataXsd(QStringLiteral("qrc:/xsd/Data.xsd"))
  {

  }

  //----------------------------------------------------------------------------------------------
  DataManager::~DataManager()
  {

  }

  //----------------------------------------------------------------------------------------------
  void DataManager::load(const QUrl& a_PathToFile)
  {
    m_DataXmlFile.setFileName(a_PathToFile.toLocalFile());
    auto DataBuilder = [] (const std::string& a_FileName) { return Data_(a_FileName, xml_schema::flags::dont_validate); };

    try
    {
      m_Data = N_DataManagerHelper::getParsedXML<Data>(m_DataXmlFile, m_DataXsd, DataBuilder);
      emitNewIntrantsLoaded();
    }
    catch(const XInvalidData& ex)
    {
      qDebug() << ex.what();
      emit invalidDataFile();
    }
    catch(const XInexistentData& ex)
    {
      qDebug() << ex.what();
      // TODO: handle this exception
    }
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::emitNewIntrantsLoaded()
  {
    if(m_Data)
    {
      auto IsDataWithName = [] (const DataPath& a_DataPath) { return a_DataPath.name() == N_Data::NEW_INTRANTS_ITEMS; };
      Data::DataPath_const_iterator it(std::find_if(m_Data->DataPath().begin(), m_Data->DataPath().end(), IsDataWithName));
      if(it != m_Data->DataPath().end())
      {
        emit newIntrantsLoaded(QDir(QString::fromStdString(m_Data->RootDir())).filePath(QString::fromStdString(*it)));
        return;
      }
      throw XInexistentData("NewIntrantItems does not exist.");
    }
    throw XInexistentData("Main data file missing.");
  }

}
