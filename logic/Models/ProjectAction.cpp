#include "Models/ProjectAction.hpp"

//#include "Data/IntrantList.hpp"

namespace N_Models {

  //---------------------------------------------------------------------------------------------------
  ProjectAction::ProjectAction(const N_Data::Action& a_Action, const QString& a_ProjectTitle)
    : N_CommonData::Action(a_Action)
    , m_ProjectTitle(a_ProjectTitle)
  {

  }

  //---------------------------------------------------------------------------------------------------
  QString ProjectAction::projectTitle() const
  {
    return m_ProjectTitle;
  }

  //---------------------------------------------------------------------------------------------------
  void ProjectAction::setProjectTitle(const QString& a_Value)
  {
    m_ProjectTitle = a_Value;
  }

}
