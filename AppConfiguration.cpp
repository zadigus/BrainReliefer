#include "AppConfiguration.hpp"

#include "logic/Data/Application.hpp"

#include "logic/Data/DataManagerHelper.hpp"

#include "logic/Logger/Logger.hpp"

#include <QUrl>
#include <QDebug>

using namespace N_Data;

//----------------------------------------------------------------------------------------------
AppConfiguration::AppConfiguration(QObject* a_Parent)
  : QObject(a_Parent)
  , m_ConfXmlUrl("file:///G:/workspace/BrainReliefer/config/Application.xml")
  , m_ConfXsdUrl("qrc:/xsd/Application.xsd")
{

}

//----------------------------------------------------------------------------------------------
void AppConfiguration::setup()
{
//  try
//  {
//    auto DataBuilder = [] (const std::string& a_FileName) { return N_ApplicationData::Application_(a_FileName, xml_schema::flags::dont_validate); };
//    std::unique_ptr<N_ApplicationData::Application> appData(N_DataManagerHelper::getParsedXML<N_ApplicationData::Application>(m_ConfXmlUrl.toLocalFile(), m_ConfXsdUrl, DataBuilder));

//    N_Logger::Logger::getInstance().init(appData->Log());

//    if(appData->Settings().Filename())
//    {
//      std::string filename(*(appData->Settings().Filename()));
//      m_DataFileUrl = QUrl::fromLocalFile(QString::fromStdString(filename));
//    }
//  }
//  catch(const XInvalidData& ex)
//  {
//    LOG_WRN("Caught XInvalidData exception: " << ex.what());
//    LOG_WRN("I should use default settings, which is not implemented yet.");
//    // TODO: use default settings
//  }
}

//----------------------------------------------------------------------------------------------
void AppConfiguration::setDataFileUrl(const QUrl& a_Value)
{
  m_DataFileUrl = a_Value;
  emit dataFileUrlChanged();
  LOG_INF("I should write the filename in the Application.xml file which is not implemented yet.");
  // TODO: write the filename in the Application.xml file
}
