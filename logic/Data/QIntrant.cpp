#include "Data/QIntrant.hpp"

namespace N_Data {

  const N_Data::Intrant::title_type QIntrant::DEFAULT_TITLE = "DefaultTitle";
  const N_Data::Intrant::ID_type QIntrant::DEFAULT_ID = "1";

  //---------------------------------------------------------------------------------------------------
  QIntrant::QIntrant(QObject *a_Parent)
    : QObject(a_Parent)
  {
    reset();
  }

  //---------------------------------------------------------------------------------------------------
  void QIntrant::reset()
  {
    m_Data.reset(new N_Data::Intrant(DEFAULT_TITLE, DEFAULT_ID));
  }

  //---------------------------------------------------------------------------------------------------
  QString QIntrant::title() const
  {
    return QString::fromStdString(m_Data->title());
  }

  //---------------------------------------------------------------------------------------------------
  void QIntrant::setTitle(const QString& a_Value)
  {
    m_Data->title(a_Value.toStdString());
  }

  //---------------------------------------------------------------------------------------------------
  QString QIntrant::description() const
  {
    return m_Data->description().present() ? QString::fromStdString(*(m_Data->description())) : QString();
  }

  //---------------------------------------------------------------------------------------------------
  void QIntrant::setDescription(const QString& a_Value)
  {
    m_Data->description(a_Value.toStdString());
  }

}
