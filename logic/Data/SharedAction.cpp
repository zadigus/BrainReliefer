#include "SharedAction.hpp"

#include <QDate>

namespace N_Data {

  //---------------------------------------------------------------------------------------------------
  void SharedAction::reset()
  {
    m_Action.reset(new N_Data::Action());
  }

  //---------------------------------------------------------------------------------------------------
  void SharedAction::setTitle(const QString& a_Value)
  {
    Action::setTitle(a_Value);
    emit titleChanged();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedAction::setDeadline(const QDate& a_Value)
  {
    Action::setDeadline(a_Value);
    emit deadlineChanged();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedAction::setDelegate(const QString& a_Value)
  {
    Action::setDelegate(a_Value);
    emit delegateChanged();
  }

}
