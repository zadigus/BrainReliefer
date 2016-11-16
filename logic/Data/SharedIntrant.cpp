#include "Data/SharedIntrant.hpp"

namespace N_Data {

  const N_Data::Intrant::title_type SharedIntrant::DEFAULT_TITLE = "DefaultTitle";

  //---------------------------------------------------------------------------------------------------
  SharedIntrant::SharedIntrant(QObject* a_Parent)
    : QObject(a_Parent)
  {
    reset();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedIntrant::reset()
  {
    m_Data.reset(new Intrant(DEFAULT_TITLE));
  }

  //---------------------------------------------------------------------------------------------------
  QString SharedIntrant::title() const
  {
    return QString::fromStdString(m_Data->title());
  }

  //---------------------------------------------------------------------------------------------------
  void SharedIntrant::setTitle(const QString& a_Value)
  {
    m_Data->title(a_Value.toStdString());
  }

  //---------------------------------------------------------------------------------------------------
  QString SharedIntrant::description() const
  {
    return m_Data->description().present() ? QString::fromStdString(*m_Data->description()) : QString();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedIntrant::setDescription(const QString& a_Value)
  {
    m_Data->description(a_Value.toStdString());
  }

}
