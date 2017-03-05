#include "common/Data/Action.hpp"

namespace N_CommonData {

  //---------------------------------------------------------------------------------------------------
  Action::Action()
    : m_Action(new N_Data::Action())
  { }

  //---------------------------------------------------------------------------------------------------
  Action::Action(const N_Data::Action& a_Action)
    : m_Action(new N_Data::Action(a_Action))
  { }

  //---------------------------------------------------------------------------------------------------
  QString Action::title() const
  {
    return QString::fromStdString(m_Action->title());
  }

  //---------------------------------------------------------------------------------------------------
  void Action::setTitle(const QString& a_Value)
  {
    m_Action->title(a_Value.toStdString());
  }

  //---------------------------------------------------------------------------------------------------
  QDate Action::deadline() const
  {
    auto value(m_Action->deadlineDate());
    return m_Action->deadlineDate_present() ? QDate(value.year(), value.month(), value.day()) : QDate();
  }

  //---------------------------------------------------------------------------------------------------
  void Action::setDeadline(const QDate& a_Value)
  {
    m_Action->deadlineDate(xml_schema::date(a_Value.year(), a_Value.month(), a_Value.day()));
  }

  //---------------------------------------------------------------------------------------------------
  QString Action::delegate() const
  {
    return m_Action->delegate_present() ? QString::fromStdString(m_Action->delegate()) : QString();
  }

  //---------------------------------------------------------------------------------------------------
  void Action::setDelegate(const QString& a_Value)
  {
    m_Action->delegate(a_Value.toStdString());
  }

}
