#include "SharedAction.hpp"

#include <QDate>

namespace N_Data {

  //---------------------------------------------------------------------------------------------------
  void SharedAction::reset()
  {
    m_Action.reset(new N_Data::Action());
  }

}
