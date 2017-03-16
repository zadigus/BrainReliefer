#include "Settings/Settings.hpp"

namespace N_Settings {

  //---------------------------------------------------------------------------------------------------
  QVariant Settings::value(const QString& a_Section, const QString& a_Key)
  {
    m_Settings.beginGroup(a_Section);
    auto result(m_Settings.value(a_Key));
    m_Settings.endGroup();
    return result;
  }

}
