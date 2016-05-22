#include "DataManager.hpp"

#include "Data/DataManagerHelper.hpp"
#include "Data/DataExceptions.hpp"

#include "Data/Data.hpp"
#include "Data/IntrantList.hpp"

#include <iostream>

#include <QFile>

#include <QDebug>

namespace N_Data {

  //----------------------------------------------------------------------------------------------
  DataManager::DataManager()
    : m_DataXsd(QStringLiteral("qrc:/xsd/Data.xsd"))
    , m_IntrantListXsd(QStringLiteral("qrc:/xsd/IntrantList.xsd"))
  {
    // TODO: copy the XSD files in the same directory as Data.xml
  }

  //----------------------------------------------------------------------------------------------
  void DataManager::load(const QString& a_PathToFile)
  {
    m_DataXmlFile.setFileName(a_PathToFile);
    auto DataBuilder = [] (const std::string& a_FileName) { return Data_(a_FileName); };

    try
    {
      m_Data = N_DataManagerHelper::getParsedXML<Data>(m_DataXmlFile, m_DataXsd, DataBuilder);
    }
    catch(const XInvalidData& ex)
    {
      qDebug() << ex.what();
      // TODO: ask the user to enter another file and then reload

      // make this a QObject
      // emit a signal that the exception has been thrown
      // connect that signal to the handle signal of the object which called DataManager::load (probably MainMenu.qml)
    }
  }

  //----------------------------------------------------------------------------------------------
  std::unique_ptr<IntrantList> DataManager::getNewIntrantsData() const
  {
    if(m_Data)
    {
      auto IsDataWithName = [] (const DataPath& a_DataPath) { return a_DataPath.name() == "NewIntrantItems"; };
      Data::DataPath_const_iterator it(std::find_if(m_Data->DataPath().begin(), m_Data->DataPath().end(), IsDataWithName));
      if(it != m_Data->DataPath().end())
      {
        auto DataBuilder = [] (const std::string& a_FileName) { return IntrantList_(a_FileName); };

        std::unique_ptr<IntrantList> result;

        try
        {
          QFile file(QString::fromStdString(*it));
          result = N_DataManagerHelper::getParsedXML<IntrantList>(file, m_IntrantListXsd, DataBuilder);
        }
        catch(const XInvalidData& ex)
        {
          qDebug() << ex.what();
          // TODO: if the data does not exist, then automatically create the missing file in the same directory as the main Data.xml
        }

        return result;
      }
      throw XInexistentData("NewIntrantItems does not exist.");
    }

    throw XInexistentData("Main data file missing.");
  }

}
