#include "common/Data/Action.hpp"

namespace N_CommonData {

  //---------------------------------------------------------------------------------------------------
  QString Action::title() const
  {
//    return QString::fromStdString(m_Action.title());
      return QString();
  }

  //---------------------------------------------------------------------------------------------------
  void Action::setTitle(const QString& a_Value)
  {
//    m_Action.title(a_Value.toStdString());
  }

  //---------------------------------------------------------------------------------------------------
  QDate Action::deadline() const
  {
//    auto value(m_Action.deadlineDate());
//    return value.present() ? QDate((*value).year(), (*value).month(), (*value).day()) : QDate();
      return QDate();
  }

  //---------------------------------------------------------------------------------------------------
  void Action::setDeadline(const QDate& a_Value)
  {
//    m_Action.deadlineDate(N_Data::Action::deadlineDate_type(a_Value.year(), a_Value.month(), a_Value.day()));
  }

  //---------------------------------------------------------------------------------------------------
  QString Action::delegate() const
  {
//    return m_Action.delegate().present() ? QString::fromStdString(*(m_Action.delegate())) : QString();
      return QString();
  }

  //---------------------------------------------------------------------------------------------------
  void Action::setDelegate(const QString& a_Value)
  {
//    m_Action.delegate(a_Value.toStdString());
  }

}
