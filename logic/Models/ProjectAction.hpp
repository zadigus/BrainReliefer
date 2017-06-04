#ifndef MODELS_PROJECTACTION_HPP
#define MODELS_PROJECTACTION_HPP

#include "core/Global.hpp"

#include "common/Data/Action.hpp"

#include <QObject>

namespace N_Data {
  class Action;
}

namespace N_Models {


  class ProjectAction : public QObject, public N_CommonData::Action
  {
    Q_OBJECT

    public:
      ProjectAction(const N_Data::Action& a_Action, const QString& a_ProjectTitle);
       virtual ~ProjectAction();

      QString projectTitle() const;
      void setProjectTitle(const QString& a_Value);

    signals:
      void deleted(const QString& a_Title, const QString& a_ProjectTitle);

    private:
      QString m_ProjectTitle;
  };

}

#endif // MODELS_PROJECTACTION_HPP
