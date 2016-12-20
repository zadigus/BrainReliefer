#include "Action.hpp"

namespace N_Models {

  //---------------------------------------------------------------------------------------------------
  Action::Action(const N_Data::Action& a_Action)
    : m_Action(a_Action)
  {

  }

  //---------------------------------------------------------------------------------------------------
  QString Action::title() const
  {
    return QString::fromStdString(m_Action.title());
  }

  //---------------------------------------------------------------------------------------------------
  QString Action::delegate() const
  {
    return m_Action.delegate().present() ? QString::fromStdString(*(m_Action.delegate())) : QString();
  }

  //---------------------------------------------------------------------------------------------------
  QDate Action::deadline() const
  {
    auto value(m_Action.deadlineDate());
    return value.present() ? QDate((*value).year(), (*value).month(), (*value).day()) : QDate();
  }

  //---------------------------------------------------------------------------------------------------
  QString Action::projectTitle() const
  {
    return m_ProjectTitle;
  }

  //---------------------------------------------------------------------------------------------------
  void Action::setProjectTitle(const QString& a_Value)
  {
    m_ProjectTitle = a_Value;
  }

}
