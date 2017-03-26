#ifndef SETTINGS_SETTINGS_HPP
#define SETTINGS_SETTINGS_HPP

#include "core/Global.hpp"

#include <QObject>
#include <QSettings>

namespace N_Settings {

  class Settings : public QObject
  {
    Q_OBJECT

    public:
      Settings(QObject* a_Parent = Q_NULLPTR);
      virtual ~Settings();

      Q_INVOKABLE QVariant value(const QString& a_Section, const QString& a_Key);

    private:
      QSettings m_Settings;
  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  inline Settings::~Settings()
  { }

  //----------------------------------------------------------------------------------
  // non-member method(s) declaration
  //----------------------------------------------------------------------------------

}

#endif // SETTINGS_HPP
