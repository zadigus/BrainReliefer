#include "Data/SharedIntrant.hpp"

namespace N_Data {

  //---------------------------------------------------------------------------------------------------
  SharedIntrant::SharedIntrant(QObject* a_Parent)
    : QObject(a_Parent)
  {
    reset();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedIntrant::reset()
  {
//    m_Data.reset(new Intrant(""));
  }

  //---------------------------------------------------------------------------------------------------
  QString SharedIntrant::title() const
  {
//    return QString::fromStdString(m_Data->title());
    return QString();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedIntrant::setTitle(const QString& a_Value)
  {
//    m_Data->title(a_Value.toStdString());
  }

  //---------------------------------------------------------------------------------------------------
  QString SharedIntrant::description() const
  {
//    return m_Data->description().present() ? QString::fromStdString(*m_Data->description()) : QString();
    return QString();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedIntrant::setDescription(const QString& a_Value)
  {
//    m_Data->description(a_Value.toStdString());
  }

}
