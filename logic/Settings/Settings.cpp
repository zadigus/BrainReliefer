#include "Settings/Settings.hpp"

#include <QGuiApplication>
#include <QScreen>
#include <QApplication>
#include <QWidget>

namespace N_Settings {

  //---------------------------------------------------------------------------------------------------
  Settings::Settings(QObject* a_Parent)
    : QObject(a_Parent)
    , m_Settings(":/conf/Settings.conf", QSettings::IniFormat)
  { }

  //---------------------------------------------------------------------------------------------------
  QVariant Settings::value(const QString& a_Section, const QString& a_Key)
  {
    m_Settings.beginGroup(a_Section);
    auto result(m_Settings.value(a_Key));
    m_Settings.endGroup();
    return result;
  }

}
