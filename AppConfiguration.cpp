#include "AppConfiguration.hpp"

#include <QApplication>
#include <QSettings>

#ifdef __ANDROID__
#include <QStandardPaths>
#endif

//----------------------------------------------------------------------------------------------
AppConfiguration::AppConfiguration(QObject* a_Parent)
  : QObject(a_Parent)
{ }

#ifdef __ANDROID__
//----------------------------------------------------------------------------------------------
void AppConfiguration::setupData()
{ // under Android (and probably iOSx and Windows Phone), we need to set that location automatically
  m_DataDir = QStandardPaths::standardLocations(QStandardPaths::HomeLocation)[0];
}
#else
//----------------------------------------------------------------------------------------------
void AppConfiguration::setupData()
{
  QSettings settings;
  settings.beginGroup("Data");
  m_DataDir = settings.value("DataDir").toString();
  settings.endGroup();
}
#endif

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
