#include "Models/ProjectAction.hpp"

namespace N_Models {

  //---------------------------------------------------------------------------------------------------
  ProjectAction::ProjectAction(const N_Data::Action& a_Action, const std::string& a_ProjectTitle)
    : N_CommonData::Action(a_Action) //m_Action(a_Action)
    , m_ProjectTitle(QString::fromStdString(a_ProjectTitle))
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
