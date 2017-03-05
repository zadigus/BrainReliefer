#include "AppConfiguration.hpp"

#include <QApplication>
#include <QSettings>

//----------------------------------------------------------------------------------------------
AppConfiguration::AppConfiguration(QObject* a_Parent)
  : QObject(a_Parent)
{ }

//----------------------------------------------------------------------------------------------
void AppConfiguration::setupData()
{
  QSettings settings;
  settings.beginGroup("Data");
  m_DataFileUrl = QUrl::fromLocalFile(settings.value("DataFile").toString());
  settings.endGroup();
}

//----------------------------------------------------------------------------------------------
void AppConfiguration::setup()
{
  setupData();
}

//----------------------------------------------------------------------------------------------
void AppConfiguration::setDataFileUrl(const QUrl& a_Value)
{
  m_DataFileUrl = a_Value;
  emit dataFileUrlChanged();

  QSettings settings;
  settings.beginGroup("Data");
  settings.setValue("DataFile", m_DataFileUrl.toLocalFile());
  settings.endGroup();
}
