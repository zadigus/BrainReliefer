#include "Settings/Settings.hpp"

#include <QGuiApplication>
#include <QScreen>
#include <QApplication>
#include <QWidget>

namespace N_Settings {

  //---------------------------------------------------------------------------------------------------
  qreal ratio(QSettings& a_Settings)
  {
    QRect rect(QGuiApplication::primaryScreen()->geometry());
    qreal height(qMax(rect.width(), rect.height()));
    qreal width(qMin(rect.width(), rect.height()));

    a_Settings.beginGroup("Scaling");
    qreal refHeight(a_Settings.value("refHeight").toReal());
    qreal refWidth(a_Settings.value("refWidth").toReal());
    a_Settings.endGroup();

    return qMin(height/refHeight, width/refWidth);
  }

  //---------------------------------------------------------------------------------------------------
  qreal fontRatio(QSettings& a_Settings, qreal a_Ratio)
  {
    qreal dpi(QGuiApplication::primaryScreen()->logicalDotsPerInch());
    a_Settings.beginGroup("Scaling");
    qreal refDPI(a_Settings.value("refDPI").toReal());
    a_Settings.endGroup();
    return a_Ratio * refDPI/dpi;
  }

  //---------------------------------------------------------------------------------------------------
  Settings::Settings(QObject* a_Parent)
    : QObject(a_Parent)
    , m_Settings(":/conf/Settings.conf", QSettings::IniFormat)
    , m_Ratio(ratio(m_Settings))
    , m_FontRatio(fontRatio(m_Settings, m_Ratio))
  {
    qDebug() << "ratio     = " << m_Ratio;
    qDebug() << "fontRatio = " << m_FontRatio;
  }

  //---------------------------------------------------------------------------------------------------
  QVariant Settings::value(const QString& a_Section, const QString& a_Key)
  {
    m_Settings.beginGroup(a_Section);
    auto result(m_Settings.value(a_Key));
    m_Settings.endGroup();
    return result; // need to multiply by m_Ratio and make sure the application is started fullscreen or get the application's main window size ...
  }

}
