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
  m_DataDir = settings.value("DataDir").toString();
  settings.endGroup();
}

//----------------------------------------------------------------------------------------------
void AppConfiguration::setup()
{
  setupData();
}

//----------------------------------------------------------------------------------------------
void AppConfiguration::setDataDir(const QUrl& a_Value)
{
  m_DataDir = a_Value;
  emit dataDirChanged();

  QSettings settings;
  settings.beginGroup("Data");
  settings.setValue("DataDir", m_DataDir);
  settings.endGroup();
}
