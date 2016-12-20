#ifndef MODELS_ACTION_HPP
#define MODELS_ACTION_HPP

#include "core/Global.hpp"

#include "Data/IntrantList.hpp"

namespace N_Models {

  class Action
  {
    public:
      Action(const N_Data::Action& a_Action);

      QString title() const;
      QString delegate() const;
      QDate deadline() const;

      QString projectTitle() const;
      void setProjectTitle(const QString& a_Value);

    private:
      N_Data::Action& m_Action;
      QString m_ProjectTitle;
  };

}

#endif // ACTION_HPP
