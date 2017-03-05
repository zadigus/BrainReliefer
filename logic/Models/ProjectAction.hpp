#ifndef MODELS_PROJECTACTION_HPP
#define MODELS_PROJECTACTION_HPP

#include "core/Global.hpp"

#include "common/Data/Action.hpp"

#include <QDate>

namespace N_Data {
  class Action;
}

namespace N_Models {


  class ProjectAction : public N_CommonData::Action
  {
    public:
      ProjectAction(const N_Data::Action& a_Action, const QString& a_ProjectTitle);

      QString projectTitle() const;
      void setProjectTitle(const QString& a_Value);

    private:
      QString m_ProjectTitle;
  };

}

#endif // MODELS_PROJECTACTION_HPP
