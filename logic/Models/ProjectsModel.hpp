#ifndef MODELS_PROJECTSMODEL_HPP
#define MODELS_PROJECTSMODEL_HPP

#include "core/Global.hpp"

#include "Models/IntrantsModel.hpp"

namespace N_Models {

  class ProjectsModel : public IntrantsModel
  {
      Q_OBJECT

    public:
      ProjectsModel(QObject* a_Parent = Q_NULLPTR);
      ~ProjectsModel();

      virtual void addAction(const N_Data::Action& a_Action, int a_Idx) override;

    public slots:
      void onActionDeleted(const QString& a_ActionTitle, const QString& a_ProjectTitle);

    private:
      void removeActionFromProject(N_Data::Intrant& a_Project, const QString& a_ActionTitle);

    signals:
      void actionAdded(int a_IntrantIdx, int a_ActionIdx);

    private:

  };

  //----------------------------------------------------------------------------------
  // inline / template method(s) implementation
  //----------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------
  // non-member method(s)
  //----------------------------------------------------------------------------------
}

#endif
