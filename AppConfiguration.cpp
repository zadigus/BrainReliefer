#include "AppConfiguration.hpp"

//----------------------------------------------------------------------------------------------
AppConfiguration::AppConfiguration(QObject* a_Parent)
  : QObject(a_Parent)
  , m_DataFileUrl("file:///G:/workspace/BrainReliefer/config/Data.xml")
{
  // TODO: this class' data should be stored in an XML file AppConf.xml located somewhere with the
  // application's binary file
}

//----------------------------------------------------------------------------------------------
void AppConfiguration::setDataFileUrl(const QUrl& a_Value)
{
  m_DataFileUrl = a_Value;
  emit dataFileUrlChanged();
}
