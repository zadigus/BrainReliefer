#include "SharedAction.hpp"

#include <QDate>

namespace N_Data {

  //---------------------------------------------------------------------------------------------------
  SharedAction::SharedAction(QObject *a_Parent)
    : QObject(a_Parent)
  {
    reset();
  }

  //---------------------------------------------------------------------------------------------------
  void SharedAction::reset()
  {
    m_Action.title().clear();
    m_Action.delegate().reset();
    m_Action.deadlineDate().reset();
  }

}
