#include "Data/SharedIntrant.hpp"

namespace N_Data {

  //---------------------------------------------------------------------------------------------------
  SharedIntrant::SharedIntrant(QObject* a_Parent)
    : QObject(a_Parent)
    , m_Data(new Intrant())
  { }

  //---------------------------------------------------------------------------------------------------
  void SharedIntrant::reset()
  {
    m_Data.reset(new Intrant());
  }

  //---------------------------------------------------------------------------------------------------
  std::unique_ptr<N_Data::Intrant> SharedIntrant::getData()
  {
    return std::move(m_Data);
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
    return m_Data->description_present() ? QString::fromStdString(m_Data->description()) : QString();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedIntrant::setDescription(const QString& a_Value)
  {
    m_Data->description(a_Value.toStdString());
  }

}
