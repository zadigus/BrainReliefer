#include "Models/ProjectsModel.hpp"

using namespace N_Data;

namespace N_Models {

  //-------------------------------------------------------------------------------------------
  ProjectsModel::ProjectsModel(QObject* a_Parent)
    : IntrantsModel(a_Parent)
  { }

  //-------------------------------------------------------------------------------------------
  ProjectsModel::~ProjectsModel()
  { }

  //-------------------------------------------------------------------------------------------
  void ProjectsModel::removeActionFromProject(N_Data::Intrant& a_Project, const QString& a_ActionTitle)
  {
    if(a_Project.actions_present())
    {
      auto actionTitle(a_ActionTitle.toStdString());
      auto& actionsList(a_Project.actions().Action());
      actionsList.erase(std::remove_if(actionsList.begin(), actionsList.end(),
        [&actionTitle](const N_Data::Action& a_Item){ return a_Item.title() == actionTitle; }));
      save();
    }
  }

  //-------------------------------------------------------------------------------------------
  void ProjectsModel::onActionDeleted(const QString& a_ActionTitle, const QString& a_ProjectTitle)
  {
    qInfo() << "Deleting action <" << a_ActionTitle << "> from project <" << a_ProjectTitle << ">";

    auto projectTitle(a_ProjectTitle.toStdString());
    auto it(std::find_if(m_Data->Intrant().begin(), m_Data->Intrant().end(),
                 [&projectTitle](const N_Data::Intrant& a_Item) { return a_Item.title() == projectTitle; }));

    if(it != m_Data->Intrant().end())
    {
      removeActionFromProject(*it, a_ActionTitle);
    }
    else
    {
      qWarning() << "Found no project <" << a_ProjectTitle << ">";
    }
  }

  //-------------------------------------------------------------------------------------------
  void ProjectsModel::addAction(const N_Data::Action& a_Action, int a_Idx)
  {
    IntrantsModel::addAction(a_Action, a_Idx);
    auto& intrant(m_Data->Intrant()[a_Idx]);
    emit actionAdded(a_Idx, intrant.actions().Action().size() - 1);
    save();
  }

}
